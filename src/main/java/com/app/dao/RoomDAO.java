package com.app.dao;

import com.app.roomquiz.Room;
import com.app.roomquiz.Player;
import java.util.List;

public interface RoomDAO {
    boolean createRoom(Room room);

    Room getRoom(String roomId);

    List<Room> getAvailableRooms();

    boolean addPlayer(String roomId, Player player);

    boolean updatePlayerScore(String roomId, String userId, int score, int timeTaken);

    void removePlayer(String roomId, String userId);

    void updateRoomStatus(String roomId, Room.RoomStatus status);

    void updateCurrentQuizId(String roomId, int quizId);

    void deleteRoom(String roomId);
}
