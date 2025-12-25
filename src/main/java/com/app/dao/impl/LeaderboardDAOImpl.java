package com.app.dao.impl;

import com.app.dao.LeaderboardDAO;
import com.app.model.LeaderboardEntry;
import com.app.model.LeaderboardEntry.LeaderboardType;
import com.app.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class LeaderboardDAOImpl implements LeaderboardDAO {

    @Override
    public List<LeaderboardEntry> getLeaderboard(LeaderboardType type, String languageTag, Date periodStart,
            int limit) {
        List<LeaderboardEntry> entries = new ArrayList<>();

        String sql = "SELECT le.*, u.username, us.current_level, " +
                "(SELECT COUNT(*) FROM user_badges WHERE user_id = le.user_id) as badge_count " +
                "FROM leaderboard_entries le " +
                "JOIN users u ON le.user_id = u.id " +
                "LEFT JOIN user_stats us ON le.user_id = us.user_id " +
                "WHERE le.leaderboard_type = ? " +
                (languageTag != null ? "AND le.language_tag = ? " : "AND le.language_tag IS NULL ") +
                "AND le.period_start = ? " +
                "ORDER BY le.rank_position ASC " +
                "LIMIT ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            stmt.setString(paramIndex++, type.name());
            if (languageTag != null) {
                stmt.setString(paramIndex++, languageTag);
            }
            stmt.setDate(paramIndex++, periodStart);
            stmt.setInt(paramIndex++, limit);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                entries.add(mapResultSetToEntry(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return entries;
    }

    @Override
    public List<LeaderboardEntry> getDailyLeaderboard(String languageTag, int limit) {
        // Calculate daily leaderboard from user_stats in real-time
        return calculateRealTimeLeaderboard(LeaderboardType.DAILY, languageTag, limit);
    }

    @Override
    public List<LeaderboardEntry> getWeeklyLeaderboard(String languageTag, int limit) {
        return calculateRealTimeLeaderboard(LeaderboardType.WEEKLY, languageTag, limit);
    }

    @Override
    public List<LeaderboardEntry> getGlobalLeaderboard(String languageTag, int limit) {
        return calculateRealTimeLeaderboard(LeaderboardType.GLOBAL, languageTag, limit);
    }

    /**
     * Calculate leaderboard in real-time from user_stats
     */
    private List<LeaderboardEntry> calculateRealTimeLeaderboard(LeaderboardType type, String languageTag, int limit) {
        List<LeaderboardEntry> entries = new ArrayList<>();

        String sql;
        if (languageTag == null) {
            // Global leaderboard - use total_points from user_stats
            sql = "SELECT u.id as user_id, u.username, us.total_points as score, " +
                    "us.current_level, " +
                    "(SELECT COUNT(*) FROM user_badges WHERE user_id = u.id) as badge_count " +
                    "FROM users u " +
                    "JOIN user_stats us ON u.id = us.user_id " +
                    "WHERE u.is_active = TRUE " +
                    "ORDER BY us.total_points DESC, us.current_level DESC " +
                    "LIMIT ?";
        } else {
            // Language-specific leaderboard
            sql = "SELECT u.id as user_id, u.username, uls.points as score, " +
                    "us.current_level, " +
                    "(SELECT COUNT(*) FROM user_badges WHERE user_id = u.id) as badge_count " +
                    "FROM users u " +
                    "JOIN user_language_stats uls ON u.id = uls.user_id " +
                    "LEFT JOIN user_stats us ON u.id = us.user_id " +
                    "WHERE u.is_active = TRUE AND uls.language_tag = ? " +
                    "ORDER BY uls.points DESC " +
                    "LIMIT ?";
        }

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            if (languageTag != null) {
                stmt.setString(paramIndex++, languageTag);
            }
            stmt.setInt(paramIndex++, limit);

            ResultSet rs = stmt.executeQuery();
            int rank = 1;
            while (rs.next()) {
                LeaderboardEntry entry = new LeaderboardEntry();
                entry.setUserId(rs.getInt("user_id"));
                entry.setUsername(rs.getString("username"));
                entry.setScore(rs.getInt("score"));
                entry.setRankPosition(rank++);
                entry.setLeaderboardType(type);
                entry.setLanguageTag(languageTag);
                entry.setUserLevel(rs.getInt("current_level"));
                entry.setBadgeCount(rs.getInt("badge_count"));
                entries.add(entry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return entries;
    }

    @Override
    public int getUserRank(int userId, LeaderboardType type, String languageTag) {
        String sql;
        if (languageTag == null) {
            sql = "SELECT COUNT(*) + 1 as `rank` FROM user_stats " +
                    "WHERE total_points > (SELECT total_points FROM user_stats WHERE user_id = ?)";
        } else {
            sql = "SELECT COUNT(*) + 1 as `rank` FROM user_language_stats " +
                    "WHERE language_tag = ? AND points > " +
                    "(SELECT points FROM user_language_stats WHERE user_id = ? AND language_tag = ?)";
        }

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (languageTag == null) {
                stmt.setInt(1, userId);
            } else {
                stmt.setString(1, languageTag);
                stmt.setInt(2, userId);
                stmt.setString(3, languageTag);
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("rank");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    @Override
    public boolean saveEntry(LeaderboardEntry entry) {
        String sql = "INSERT INTO leaderboard_entries " +
                "(user_id, leaderboard_type, language_tag, rank_position, score, period_start, period_end) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, entry.getUserId());
            stmt.setString(2, entry.getLeaderboardType().name());
            stmt.setString(3, entry.getLanguageTag());
            stmt.setInt(4, entry.getRankPosition());
            stmt.setInt(5, entry.getScore());
            stmt.setDate(6, entry.getPeriodStart());
            stmt.setDate(7, entry.getPeriodEnd());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean clearOldEntries(Date beforeDate) {
        String sql = "DELETE FROM leaderboard_entries WHERE period_end < ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDate(1, beforeDate);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private LeaderboardEntry mapResultSetToEntry(ResultSet rs) throws SQLException {
        LeaderboardEntry entry = new LeaderboardEntry();
        entry.setId(rs.getInt("id"));
        entry.setUserId(rs.getInt("user_id"));
        entry.setUsername(rs.getString("username"));
        entry.setLeaderboardType(LeaderboardType.valueOf(rs.getString("leaderboard_type")));
        entry.setLanguageTag(rs.getString("language_tag"));
        entry.setRankPosition(rs.getInt("rank_position"));
        entry.setScore(rs.getInt("score"));
        entry.setPeriodStart(rs.getDate("period_start"));
        entry.setPeriodEnd(rs.getDate("period_end"));
        entry.setUserLevel(rs.getInt("current_level"));
        entry.setBadgeCount(rs.getInt("badge_count"));
        return entry;
    }
}
