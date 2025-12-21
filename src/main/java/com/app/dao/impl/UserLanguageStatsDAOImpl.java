package com.app.dao.impl;

import com.app.dao.UserLanguageStatsDAO;
import com.app.model.DifficultyLevel;
import com.app.model.UserLanguageStats;
import com.app.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserLanguageStatsDAOImpl implements UserLanguageStatsDAO {

    @Override
    public Optional<UserLanguageStats> findByUserAndLanguage(int userId, String languageTag) {
        String sql = "SELECT * FROM user_language_stats WHERE user_id = ? AND language_tag = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, languageTag);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return Optional.of(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public List<UserLanguageStats> findByUserId(int userId) {
        List<UserLanguageStats> statsList = new ArrayList<>();
        String sql = "SELECT * FROM user_language_stats WHERE user_id = ? ORDER BY points DESC";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                statsList.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statsList;
    }

    @Override
    public boolean create(UserLanguageStats stats) {
        String sql = "INSERT INTO user_language_stats (user_id, language_tag, difficulty_level, " +
                "points, quizzes_played, correct_answers, total_questions, best_score) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, stats.getUserId());
            stmt.setString(2, stats.getLanguageTag());
            stmt.setString(3, stats.getDifficultyLevel().name());
            stmt.setInt(4, stats.getPoints());
            stmt.setInt(5, stats.getQuizzesPlayed());
            stmt.setInt(6, stats.getCorrectAnswers());
            stmt.setInt(7, stats.getTotalQuestions());
            stmt.setInt(8, stats.getBestScore());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(UserLanguageStats stats) {
        String sql = "UPDATE user_language_stats SET difficulty_level = ?, points = ?, " +
                "quizzes_played = ?, correct_answers = ?, total_questions = ?, " +
                "best_score = ?, last_played = CURRENT_TIMESTAMP " +
                "WHERE user_id = ? AND language_tag = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, stats.getDifficultyLevel().name());
            stmt.setInt(2, stats.getPoints());
            stmt.setInt(3, stats.getQuizzesPlayed());
            stmt.setInt(4, stats.getCorrectAnswers());
            stmt.setInt(5, stats.getTotalQuestions());
            stmt.setInt(6, stats.getBestScore());
            stmt.setInt(7, stats.getUserId());
            stmt.setString(8, stats.getLanguageTag());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateDifficulty(int userId, String languageTag, DifficultyLevel newLevel) {
        String sql = "UPDATE user_language_stats SET difficulty_level = ? " +
                "WHERE user_id = ? AND language_tag = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newLevel.name());
            stmt.setInt(2, userId);
            stmt.setString(3, languageTag);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean addPoints(int userId, String languageTag, int points) {
        String sql = "UPDATE user_language_stats SET points = points + ? " +
                "WHERE user_id = ? AND language_tag = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, points);
            stmt.setInt(2, userId);
            stmt.setString(3, languageTag);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateQuizStats(int userId, String languageTag, int correctAnswers, int totalQuestions) {
        String sql = "UPDATE user_language_stats SET " +
                "quizzes_played = quizzes_played + 1, " +
                "correct_answers = correct_answers + ?, " +
                "total_questions = total_questions + ?, " +
                "last_played = CURRENT_TIMESTAMP " +
                "WHERE user_id = ? AND language_tag = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, correctAnswers);
            stmt.setInt(2, totalQuestions);
            stmt.setInt(3, userId);
            stmt.setString(4, languageTag);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int getUniqueLanguageCount(int userId) {
        String sql = "SELECT COUNT(DISTINCT language_tag) FROM user_language_stats WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private UserLanguageStats mapResultSet(ResultSet rs) throws SQLException {
        UserLanguageStats stats = new UserLanguageStats();
        stats.setId(rs.getInt("id"));
        stats.setUserId(rs.getInt("user_id"));
        stats.setLanguageTag(rs.getString("language_tag"));
        stats.setDifficultyLevel(DifficultyLevel.valueOf(rs.getString("difficulty_level")));
        stats.setPoints(rs.getInt("points"));
        stats.setQuizzesPlayed(rs.getInt("quizzes_played"));
        stats.setCorrectAnswers(rs.getInt("correct_answers"));
        stats.setTotalQuestions(rs.getInt("total_questions"));
        stats.setBestScore(rs.getInt("best_score"));
        stats.setLastPlayed(rs.getTimestamp("last_played"));
        stats.setCreatedAt(rs.getTimestamp("created_at"));
        return stats;
    }
}
