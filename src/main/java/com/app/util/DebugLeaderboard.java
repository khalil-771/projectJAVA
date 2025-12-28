package com.app.util;

import java.sql.*;

public class DebugLeaderboard {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("--- USERS ---");
            try (Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT id, username, is_active FROM users")) {
                while (rs.next()) {
                    System.out.println("ID: " + rs.getInt("id") + ", User: " + rs.getString("username") + ", Active: "
                            + rs.getBoolean("is_active"));
                }
            }

            System.out.println("\n--- USER_LANGUAGE_STATS ---");
            try (Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM user_language_stats")) {
                while (rs.next()) {
                    System.out.println("UserID: " + rs.getInt("user_id") + ", Lang: [" + rs.getString("language_tag")
                            + "], Points: " + rs.getInt("points"));
                }
            }

            System.out.println("\n--- LEADERBOARD QUERY (java) ---");
            String sql = "SELECT u.id as user_id, u.username, uls.points as score " +
                    "FROM users u " +
                    "JOIN user_language_stats uls ON u.id = uls.user_id " +
                    "WHERE u.is_active = TRUE AND uls.language_tag = 'java'";
            try (Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    System.out.println("User: " + rs.getString("username") + ", Score: " + rs.getInt("score"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
