package com.app.roomquiz;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Manager for multiplayer rooms
 */
public class RoomManager {

    private static RoomManager instance;
    private final Map<String, Room> rooms;

    private RoomManager() {
        this.rooms = new ConcurrentHashMap<>();
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
    public Room createRoom(String roomName, String hostUserId, int maxPlayers) {
        String roomId = UUID.randomUUID().toString().substring(0, 8);
        Room room = new Room(roomId, roomName, hostUserId, maxPlayers);
        rooms.put(roomId, room);

        System.out.println("🎮 Room created: " + roomName + " (ID: " + roomId + ")");
        return room;
    }

    /**
     * Get room by ID
     */
    public Room getRoom(String roomId) {
        return rooms.get(roomId);
    }

    /**
     * Get all available rooms
     */
    public List<Room> getAvailableRooms() {
        List<Room> available = new ArrayList<>();

        for (Room room : rooms.values()) {
            if (room.getStatus() == Room.RoomStatus.WAITING && !room.isFull()) {
                available.add(room);
            }
        }

        return available;
    }

    /**
     * Join a room
     */
    public boolean joinRoom(String roomId, String userId, String username) {
        Room room = rooms.get(roomId);

        if (room == null) {
            return false;
        }

        Player player = new Player(userId, username);
        boolean joined = room.addPlayer(player);

        if (joined) {
            System.out.println("👤 " + username + " joined room: " + room.getRoomName());
        }

        return joined;
    }

    /**
     * Leave a room
     */
    public void leaveRoom(String roomId, String userId) {
        Room room = rooms.get(roomId);

        if (room != null) {
            room.removePlayer(userId);

            // Delete room if empty
            if (room.getPlayerCount() == 0) {
                rooms.remove(roomId);
                System.out.println("🗑️ Room deleted (empty): " + room.getRoomName());
            }
        }
    }

    /**
     * Start quiz in room
     */
    public boolean startQuiz(String roomId, Quiz quiz) {
        Room room = rooms.get(roomId);

        if (room != null) {
            boolean started = room.startQuiz(quiz);

            if (started) {
                System.out.println("🎯 Quiz started in room: " + room.getRoomName());
            }

            return started;
        }

        return false;
    }

    /**
     * Get room count
     */
    public int getRoomCount() {
        return rooms.size();
    }

    /**
     * Get total players across all rooms
     */
    public int getTotalPlayers() {
        return rooms.values().stream()
                .mapToInt(Room::getPlayerCount)
                .sum();
    }

    /**
     * Clean up finished rooms
     */
    public void cleanupFinishedRooms() {
        List<String> toRemove = new ArrayList<>();

        for (Map.Entry<String, Room> entry : rooms.entrySet()) {
            if (entry.getValue().getStatus() == Room.RoomStatus.FINISHED) {
                toRemove.add(entry.getKey());
            }
        }

        for (String roomId : toRemove) {
            rooms.remove(roomId);
        }

        if (!toRemove.isEmpty()) {
            System.out.println("🧹 Cleaned up " + toRemove.size() + " finished rooms");
        }
    }
}
