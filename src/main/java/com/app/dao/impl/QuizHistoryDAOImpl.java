package com.app.dao.impl;

import com.app.dao.QuizHistoryDAO;
import com.app.model.QuizHistory;
import com.app.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class QuizHistoryDAOImpl implements QuizHistoryDAO {

    @Override
    public boolean save(QuizHistory history) {
        String sql = "INSERT INTO quiz_history (user_id, quiz_id, quiz_title, language_tag, " +
                "score, points_earned, correct_answers, total_questions, difficulty_level, " +
                "time_spent, completed_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, history.getUserId());
            stmt.setInt(2, history.getQuizId());
            stmt.setString(3, history.getQuizTitle());
            stmt.setString(4, history.getLanguageTag());
            stmt.setInt(5, history.getScore());
            stmt.setInt(6, history.getPointsEarned());
            stmt.setInt(7, history.getCorrectAnswers());
            stmt.setInt(8, history.getTotalQuestions());
            stmt.setString(9, history.getDifficultyLevel());
            stmt.setLong(10, history.getTimeSpent());
            stmt.setTimestamp(11, new Timestamp(System.currentTimeMillis()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<QuizHistory> findByUserId(int userId) {
        List<QuizHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM quiz_history WHERE user_id = ? ORDER BY completed_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                history.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return history;
    }

    @Override
    public List<QuizHistory> findByUserIdAndDateRange(int userId, Date startDate, Date endDate) {
        List<QuizHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM quiz_history WHERE user_id = ? " +
                "AND completed_at BETWEEN ? AND ? ORDER BY completed_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setDate(2, startDate);
            stmt.setDate(3, endDate);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                history.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return history;
    }

    @Override
    public List<QuizHistory> findByUserIdAndLanguage(int userId, String languageTag) {
        List<QuizHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM quiz_history WHERE user_id = ? AND language_tag = ? " +
                "ORDER BY completed_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, languageTag);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                history.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return history;
    }

    @Override
    public List<QuizHistory> findRecentByUserId(int userId, int limit) {
        List<QuizHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM quiz_history WHERE user_id = ? " +
                "ORDER BY completed_at DESC LIMIT ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                history.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return history;
    }

    @Override
    public Optional<QuizHistory> findBestScoreForQuiz(int userId, int quizId) {
        String sql = "SELECT * FROM quiz_history WHERE user_id = ? AND quiz_id = ? " +
                "ORDER BY score DESC LIMIT 1";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, quizId);
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
    public double getAverageScore(int userId) {
        String sql = "SELECT AVG(score) as avg_score FROM quiz_history WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("avg_score");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0.0;
    }

    @Override
    public int getTotalQuizzesCompleted(int userId) {
        String sql = "SELECT COUNT(*) as total FROM quiz_history WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    private QuizHistory mapResultSet(ResultSet rs) throws SQLException {
        QuizHistory history = new QuizHistory();
        history.setId(rs.getInt("id"));
        history.setUserId(rs.getInt("user_id"));
        history.setQuizId(rs.getInt("quiz_id"));
        history.setQuizTitle(rs.getString("quiz_title"));
        history.setLanguageTag(rs.getString("language_tag"));
        history.setScore(rs.getInt("score"));
        history.setPointsEarned(rs.getInt("points_earned"));
        history.setCorrectAnswers(rs.getInt("correct_answers"));
        history.setTotalQuestions(rs.getInt("total_questions"));
        history.setDifficultyLevel(rs.getString("difficulty_level"));
        history.setTimeSpent(rs.getLong("time_spent"));
        history.setCompletedAt(rs.getTimestamp("completed_at"));
        return history;
    }
}
