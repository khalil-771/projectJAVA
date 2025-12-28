package com.app.dao;

import com.app.util.DatabaseConnection;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class AdminDAO {

    public Map<String, Object> getGlobalStatistics() {
        Map<String, Object> stats = new HashMap<>();

        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn == null) {
                System.err.println("❌ Database connection is null");
                return getDefaultStats();
            }

            // 1. Total Users
            int totalUsers = getCount(conn, "SELECT COUNT(*) FROM users");
            stats.put("totalUsers", totalUsers);
            System.out.println("📊 Total Users: " + totalUsers);

            // 2. Total Quizzes Played (Solo)
            int totalQuizzes = getCount(conn, "SELECT COUNT(*) FROM user_quiz_results");
            stats.put("totalSoloQuizzes", totalQuizzes);
            System.out.println("📊 Total Solo Quizzes: " + totalQuizzes);

            // 3. Total Multiplayer Rooms Created
            int totalRooms = getCount(conn, "SELECT COUNT(*) FROM multiplayer_rooms");
            stats.put("totalRooms", totalRooms);
            System.out.println("📊 Total Rooms: " + totalRooms);

            // 4. Average Score
            double avgScore = getAverage(conn, "SELECT AVG(score) FROM user_quiz_results");
            stats.put("averageScore", avgScore);
            System.out.println("📊 Average Score: " + avgScore + "%");

            // 5. Popular Language
            String sqlPopularLang = "SELECT c.language_tag, COUNT(*) as count " +
                    "FROM user_quiz_results uqr " +
                    "JOIN quizzes q ON uqr.quiz_id = q.id " +
                    "JOIN courses c ON q.course_id = c.id " +
                    "GROUP BY c.language_tag " +
                    "ORDER BY count DESC LIMIT 1";

            String popularLang = getStringValue(conn, sqlPopularLang, "language_tag");
            stats.put("popularLanguage", popularLang != null ? popularLang.toUpperCase() : "N/A");
            System.out.println("📊 Popular Language: " + popularLang);

            // 6. Total Questions
            int totalQuestions = getCount(conn, "SELECT COUNT(*) FROM questions");
            stats.put("totalQuestions", totalQuestions);
            System.out.println("📊 Total Questions: " + totalQuestions);

            System.out.println("✅ Statistics loaded successfully");

        } catch (SQLException e) {
            System.err.println("❌ Error fetching statistics: " + e.getMessage());
            e.printStackTrace();
            return getDefaultStats();
        }

        return stats;
    }

    private Map<String, Object> getDefaultStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUsers", 0);
        stats.put("totalSoloQuizzes", 0);
        stats.put("totalRooms", 0);
        stats.put("averageScore", 0.0);
        stats.put("popularLanguage", "N/A");
        stats.put("totalQuestions", 0);
        return stats;
    }

    private int getCount(Connection conn, String sql) throws SQLException {
        try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("❌ Error in getCount: " + sql);
            throw e;
        }
        return 0;
    }

    private double getAverage(Connection conn, String sql) throws SQLException {
        try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                double avg = rs.getDouble(1);
                return rs.wasNull() ? 0.0 : avg; // Handle NULL average
            }
        } catch (SQLException e) {
            System.err.println("❌ Error in getAverage: " + sql);
            throw e;
        }
        return 0.0;
    }

    private String getStringValue(Connection conn, String sql, String column) throws SQLException {
        try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getString(column);
            }
        } catch (SQLException e) {
            System.err.println("❌ Error in getStringValue: " + sql);
            throw e;
        }
        return "N/A";
    }
}
