package com.app.dao.impl;

import com.app.dao.RoomDAO;
import com.app.roomquiz.Player;
import com.app.roomquiz.Room;
import com.app.roomquiz.Room.RoomStatus;
import com.app.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAOImpl implements RoomDAO {

    @Override
    public boolean createRoom(Room room) {
        String sql = "INSERT INTO multiplayer_rooms (room_id, room_name, host_user_id, host_ip, language, difficulty, max_players, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, room.getRoomId());
            stmt.setString(2, room.getRoomName());
            stmt.setInt(3, Integer.parseInt(room.getHostUserId()));
            stmt.setString(4, room.getHostIp());
            stmt.setString(5, room.getLanguage());
            stmt.setString(6, room.getDifficulty());
            stmt.setInt(7, room.getMaxPlayers());
            stmt.setString(8, room.getStatus().name());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Room getRoom(String roomId) {
        String sql = "SELECT * FROM multiplayer_rooms WHERE room_id = ?";
        Room room = null;
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, roomId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                room = new Room(
                        rs.getString("room_id"),
                        rs.getString("room_name"),
                        String.valueOf(rs.getInt("host_user_id")),
                        rs.getString("host_ip"),
                        rs.getString("language"),
                        rs.getString("difficulty"),
                        rs.getInt("max_players"));
                room.setStatus(RoomStatus.valueOf(rs.getString("status")));
                room.setCurrentQuizId(rs.getInt("current_quiz_id"));
                // Note: getInt returns 0 if NULL, which is fine (0 means no quiz)

                // Load players
                loadPlayers(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return room;
    }

    @Override
    public boolean updatePlayerScore(String roomId, String userId, int score, int timeTaken) {
        String sql = "UPDATE room_players SET score = ?, time_taken = ? WHERE room_id = ? AND user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, score);
            stmt.setInt(2, timeTaken);
            stmt.setString(3, roomId);
            stmt.setInt(4, Integer.parseInt(userId));
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void loadPlayers(Room room) {
        // Try to load with time_taken first
        String sqlWithTime = "SELECT user_id, username, is_ready, score, time_taken FROM room_players WHERE room_id = ?";
        String sqlSimple = "SELECT user_id, username, is_ready, score FROM room_players WHERE room_id = ?";

        try (Connection conn = DatabaseConnection.getConnection()) {
            boolean loadedWithTime = false;
            try (PreparedStatement stmt = conn.prepareStatement(sqlWithTime)) {
                stmt.setString(1, room.getRoomId());
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Player p = new Player(String.valueOf(rs.getInt("user_id")), rs.getString("username"));
                    p.setReady(rs.getBoolean("is_ready"));
                    room.addPlayerFromDB(p, rs.getInt("score"), rs.getInt("time_taken"));
                }
                loadedWithTime = true;
            } catch (SQLException e) {
                // time_taken column likely missing
                System.err.println("Note: time_taken column missing, falling back to simple load.");
            }

            if (!loadedWithTime) {
                try (PreparedStatement stmt = conn.prepareStatement(sqlSimple)) {
                    stmt.setString(1, room.getRoomId());
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        Player p = new Player(String.valueOf(rs.getInt("user_id")), rs.getString("username"));
                        p.setReady(rs.getBoolean("is_ready"));
                        room.addPlayerFromDB(p, rs.getInt("score"), 0);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // The getIntOrDefault method is no longer needed with the new loadPlayers logic
    // private int getIntOrDefault(ResultSet rs, String col, int def) {
    // try {
    // return rs.getInt(col);
    // } catch (SQLException e) {
    // return def;
    // }
    // }

    @Override
    public List<Room> getAvailableRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM multiplayer_rooms WHERE status = 'WAITING'";
        try (Connection conn = DatabaseConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Room room = new Room(
                        rs.getString("room_id"),
                        rs.getString("room_name"),
                        String.valueOf(rs.getInt("host_user_id")),
                        rs.getString("host_ip"),
                        rs.getString("language"),
                        rs.getString("difficulty"),
                        rs.getInt("max_players"));
                room.setStatus(RoomStatus.valueOf(rs.getString("status")));
                room.setCurrentQuizId(rs.getInt("current_quiz_id"));
                loadPlayers(room);
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    @Override
    public boolean addPlayer(String roomId, Player player) {
        String sql = "INSERT INTO room_players (room_id, user_id, username, is_ready) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, roomId);
            stmt.setInt(2, Integer.parseInt(player.getUserId()));
            stmt.setString(3, player.getUsername());
            stmt.setBoolean(4, player.isReady());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void removePlayer(String roomId, String userId) {
        String sql = "DELETE FROM room_players WHERE room_id = ? AND user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, roomId);
            stmt.setInt(2, Integer.parseInt(userId));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateRoomStatus(String roomId, RoomStatus status) {
        String sql = "UPDATE multiplayer_rooms SET status = ? WHERE room_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status.name());
            stmt.setString(2, roomId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateCurrentQuizId(String roomId, int quizId) {
        String sql = "UPDATE multiplayer_rooms SET current_quiz_id = ? WHERE room_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            stmt.setString(2, roomId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRoom(String roomId) {
        // Cascade delete should handle players, but explicit delete is fine too if
        // cascade not set
        String sql = "DELETE FROM multiplayer_rooms WHERE room_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, roomId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
