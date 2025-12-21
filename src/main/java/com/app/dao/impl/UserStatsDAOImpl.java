package com.app.dao.impl;

import com.app.dao.UserStatsDAO;
import com.app.model.UserStats;
import com.app.util.DatabaseConnection;

import java.sql.*;
import java.util.Optional;

public class UserStatsDAOImpl implements UserStatsDAO {

    @Override
    public Optional<UserStats> findByUserId(int userId) {
        String sql = "SELECT * FROM user_stats WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return Optional.of(mapResultSetToUserStats(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public boolean create(UserStats stats) {
        String sql = "INSERT INTO user_stats (user_id, total_points, current_level, experience_points, " +
                "best_streak, current_streak, total_quizzes_played, total_correct_answers, " +
                "total_questions_answered, last_quiz_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, stats.getUserId());
            stmt.setInt(2, stats.getTotalPoints());
            stmt.setInt(3, stats.getCurrentLevel());
            stmt.setInt(4, stats.getExperiencePoints());
            stmt.setInt(5, stats.getBestStreak());
            stmt.setInt(6, stats.getCurrentStreak());
            stmt.setInt(7, stats.getTotalQuizzesPlayed());
            stmt.setInt(8, stats.getTotalCorrectAnswers());
            stmt.setInt(9, stats.getTotalQuestionsAnswered());
            stmt.setDate(10, stats.getLastQuizDate());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(UserStats stats) {
        String sql = "UPDATE user_stats SET total_points = ?, current_level = ?, experience_points = ?, " +
                "best_streak = ?, current_streak = ?, total_quizzes_played = ?, " +
                "total_correct_answers = ?, total_questions_answered = ?, last_quiz_date = ? " +
                "WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, stats.getTotalPoints());
            stmt.setInt(2, stats.getCurrentLevel());
            stmt.setInt(3, stats.getExperiencePoints());
            stmt.setInt(4, stats.getBestStreak());
            stmt.setInt(5, stats.getCurrentStreak());
            stmt.setInt(6, stats.getTotalQuizzesPlayed());
            stmt.setInt(7, stats.getTotalCorrectAnswers());
            stmt.setInt(8, stats.getTotalQuestionsAnswered());
            stmt.setDate(9, stats.getLastQuizDate());
            stmt.setInt(10, stats.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int userId) {
        String sql = "DELETE FROM user_stats WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean addPoints(int userId, int points) {
        String sql = "UPDATE user_stats SET total_points = total_points + ?, " +
                "experience_points = experience_points + ? WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, points);
            stmt.setInt(2, points);
            stmt.setInt(3, userId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateStreak(int userId, int newStreak) {
        String sql = "UPDATE user_stats SET current_streak = ?, " +
                "best_streak = GREATEST(best_streak, ?) WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, newStreak);
            stmt.setInt(2, newStreak);
            stmt.setInt(3, userId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean incrementQuizCount(int userId) {
        String sql = "UPDATE user_stats SET total_quizzes_played = total_quizzes_played + 1, " +
                "last_quiz_date = CURDATE() WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateQuestionStats(int userId, int correctAnswers, int totalQuestions) {
        String sql = "UPDATE user_stats SET total_correct_answers = total_correct_answers + ?, " +
                "total_questions_answered = total_questions_answered + ? WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, correctAnswers);
            stmt.setInt(2, totalQuestions);
            stmt.setInt(3, userId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private UserStats mapResultSetToUserStats(ResultSet rs) throws SQLException {
        UserStats stats = new UserStats();
        stats.setUserId(rs.getInt("user_id"));
        stats.setTotalPoints(rs.getInt("total_points"));
        stats.setCurrentLevel(rs.getInt("current_level"));
        stats.setExperiencePoints(rs.getInt("experience_points"));
        stats.setBestStreak(rs.getInt("best_streak"));
        stats.setCurrentStreak(rs.getInt("current_streak"));
        stats.setTotalQuizzesPlayed(rs.getInt("total_quizzes_played"));
        stats.setTotalCorrectAnswers(rs.getInt("total_correct_answers"));
        stats.setTotalQuestionsAnswered(rs.getInt("total_questions_answered"));
        stats.setLastQuizDate(rs.getDate("last_quiz_date"));
        stats.setCreatedAt(rs.getTimestamp("created_at"));
        stats.setUpdatedAt(rs.getTimestamp("updated_at"));
        return stats;
    }
}
