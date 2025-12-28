package com.app.util;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

public class DatabaseSchema {

    public static void initialize() {
        try (Connection conn = DatabaseConnection.getConnection();
                Statement stmt = conn.createStatement()) {

            // Table: multiplayer_rooms
            String createRoomsObj = "CREATE TABLE IF NOT EXISTS multiplayer_rooms (" +
                    "room_id VARCHAR(50) PRIMARY KEY," +
                    "room_name VARCHAR(100) NOT NULL," +
                    "host_user_id INT NOT NULL," +
                    "host_ip VARCHAR(50)," +
                    "language VARCHAR(50)," +
                    "difficulty VARCHAR(20)," +
                    "max_players INT DEFAULT 4," +
                    "status VARCHAR(20) DEFAULT 'WAITING'," +
                    "current_quiz_id INT," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")";
            stmt.execute(createRoomsObj);

            // Migration: Add columns if they don't exist (using try/catch for simplicity in
            // migration)
            try {
                stmt.execute("ALTER TABLE multiplayer_rooms ADD COLUMN host_ip VARCHAR(50)");
            } catch (SQLException ignore) {
            }
            try {
                stmt.execute("ALTER TABLE multiplayer_rooms ADD COLUMN language VARCHAR(50)");
            } catch (SQLException ignore) {
            }
            try {
                stmt.execute("ALTER TABLE multiplayer_rooms ADD COLUMN difficulty VARCHAR(20)");
            } catch (SQLException ignore) {
            }

            // Table: room_players
            String createPlayers = "CREATE TABLE IF NOT EXISTS room_players (" +
                    "room_id VARCHAR(50)," +
                    "user_id INT," +
                    "username VARCHAR(100)," +
                    "is_ready BOOLEAN DEFAULT FALSE," +
                    "score INT DEFAULT 0," +
                    "PRIMARY KEY (room_id, user_id)," +
                    "FOREIGN KEY (room_id) REFERENCES multiplayer_rooms(room_id) ON DELETE CASCADE" +
                    ")";
            stmt.execute(createPlayers);

            // Migration: Add time_taken to room_players
            try {
                stmt.execute("ALTER TABLE room_players ADD COLUMN time_taken INT DEFAULT 0");
            } catch (SQLException ignore) {
            }

            System.out.println("✅ Multiplayer tables initialized.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
