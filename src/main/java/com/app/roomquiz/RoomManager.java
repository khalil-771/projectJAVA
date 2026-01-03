package com.app.roomquiz;

import java.util.*;

import com.app.dao.RoomDAO;
import com.app.dao.impl.RoomDAOImpl;
import com.app.model.Quiz;

/**
 * Manager for multiplayer rooms
 */
public class RoomManager {

    private static RoomManager instance;
    private final RoomDAO roomDAO;
    // We remove local cache 'rooms' to force DB fetch

    private RoomManager() {
        this.roomDAO = new RoomDAOImpl();
    }

    public static synchronized RoomManager getInstance() {
        if (instance == null) {
            instance = new RoomManager();
        }
        return instance;
    }

    /**
     * Create a new room
     */
    public Room createRoom(String roomName, String hostUserId, String hostIp, String language, String difficulty,
            int maxPlayers) {
        // Generate a short 6-digit code for easier typing
        String roomId = String.format("%06d", new Random().nextInt(999999));
        // Ensure uniqueness loop could be here

        Room room = new Room(roomId, roomName, hostUserId, hostIp, language, difficulty, maxPlayers);
        boolean success = roomDAO.createRoom(room);

        if (success) {
            System.out.println("🎮 Room created: " + roomName + " (ID: " + roomId + ")");
            return room;
        }
        return null;
    }

    /**
     * Get room by ID (fetches from DB)
     */
    public Room getRoom(String roomId) {
        return roomDAO.getRoom(roomId);
    }

    /**
     * Sync room data locally (for guests joining from IP)
     */
    public boolean syncRoomLocally(Room room) {
        if (room == null)
            return false;
        Room existing = getRoom(room.getRoomId());
        if (existing == null) {
            roomDAO.createRoom(room);
        }

        // Sync players too
        if (room.getPlayers() != null) {
            for (Player p : room.getPlayers().values()) {
                roomDAO.addPlayer(room.getRoomId(), p);
            }
        }
        return true;
    }

    /**
     * Get all available rooms
     */
    public List<Room> getAvailableRooms() {
        return roomDAO.getAvailableRooms();
    }

    /**
     * Join a room
     */
    public boolean joinRoom(String roomId, String userId, String username) {
        Room room = getRoom(roomId);
        if (room == null)
            return false;

        // internal check
        if (room.isFull())
            return false;
        if (room.getStatus() != Room.RoomStatus.WAITING)
            return false;

        Player player = new Player(userId, username);
        boolean success = roomDAO.addPlayer(roomId, player);

        if (success) {
            System.out.println("👤 " + username + " joined room: " + room.getRoomName());
        }

        return success;
    }

    /**
     * Leave a room
     */
    public void leaveRoom(String roomId, String userId) {
        Room room = getRoom(roomId);
        boolean isHost = room != null && userId.equals(room.getHostUserId());

        roomDAO.removePlayer(roomId, userId);

        // If host leaves or room is empty, delete it
        if (isHost || (room != null && room.getPlayerCount() == 1)) { // 1 because we just removed one in memory?
            // Actually getRoom(roomId) returns fresh from DB including the removal.
            Room freshRoom = getRoom(roomId);
            if (isHost || freshRoom == null || freshRoom.getPlayerCount() == 0) {
                roomDAO.deleteRoom(roomId);
                System.out.println("🗑 Room deleted: " + roomId);
            }
        }
    }

    /**
     * Start quiz in room
     */
    public boolean startQuiz(String roomId, Quiz quiz) {
        // We probably need to update DB with current_quiz_id
        // For now, let's just update status.
        // Syncing the actual quiz content across machines is trickier without saving
        // quiz_id
        // My table has current_quiz_id, I should update it.
        // But RoomDataAccess doesn't have updateCurrentQuiz method yet?
        // Let's assume RoomStatus update is enough for now to trigger 'Game Started' on
        // client,
        // and client pulls quiz?
        // Actually, the client needs to know WHICH quiz.
        // So I should simple update the status in DB.
        // Update current quiz ID in DB so clients know what to load
        roomDAO.updateCurrentQuizId(roomId, quiz.getId());

        // Update Status to IN_PROGRESS
        roomDAO.updateRoomStatus(roomId, Room.RoomStatus.IN_PROGRESS);

        return true;
    }

    public boolean submitFinalScore(String roomId, String userId, int score, int timeTaken) {
        return roomDAO.updatePlayerScore(roomId, userId, score, timeTaken);
    }
}