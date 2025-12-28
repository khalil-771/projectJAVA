package com.app.dao.impl;

import com.app.dao.QuestionDAO;
import com.app.model.Answer;
import com.app.model.Question;
import com.app.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAOImpl implements QuestionDAO {

    @Override
    public List<Question> findAll() {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions ORDER BY id DESC";
        try (Connection conn = DatabaseConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                questions.add(mapRowToQuestion(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }

    @Override
    public List<Question> findByLanguage(String language) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions WHERE language_tag = ? ORDER BY id DESC";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, language);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                questions.add(mapRowToQuestion(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }

    @Override
    public boolean delete(int questionId) {
        String sql = "DELETE FROM questions WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, questionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int save(Question q) {
        String sql = "INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty, language_tag, points_value) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, q.getQuizId());
            stmt.setString(2, q.getQuestionText());
            stmt.setString(3, q.getType().name());
            stmt.setString(4, q.getExplanation());
            stmt.setString(5, q.getDifficulty());
            stmt.setString(6, q.getLanguageTag());
            stmt.setInt(7, q.getPoints());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int qId = rs.getInt(1);
                        saveAnswers(conn, qId, q.getAnswers());
                        return qId;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public boolean update(Question q) {
        String sql = "UPDATE questions SET question_text = ?, question_type = ?, explanation = ?, difficulty = ?, language_tag = ?, points_value = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, q.getQuestionText());
            stmt.setString(2, q.getType().name());
            stmt.setString(3, q.getExplanation());
            stmt.setString(4, q.getDifficulty());
            stmt.setString(5, q.getLanguageTag());
            stmt.setInt(6, q.getPoints());
            stmt.setInt(7, q.getId());

            boolean updated = stmt.executeUpdate() > 0;
            if (updated) {
                // For simplicity, delete and recreate answers
                deleteAnswers(conn, q.getId());
                saveAnswers(conn, q.getId(), q.getAnswers());
            }
            return updated;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void saveAnswers(Connection conn, int questionId, List<Answer> answers) throws SQLException {
        String sql = "INSERT INTO answers (question_id, answer_text, is_correct) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (Answer a : answers) {
                stmt.setInt(1, questionId);
                stmt.setString(2, a.getAnswerText());
                stmt.setBoolean(3, a.isCorrect());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    private void deleteAnswers(Connection conn, int questionId) throws SQLException {
        String sql = "DELETE FROM answers WHERE question_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, questionId);
            stmt.executeUpdate();
        }
    }

    private Question mapRowToQuestion(ResultSet rs) throws SQLException {
        Question q = new Question();
        q.setId(rs.getInt("id"));
        q.setQuizId(rs.getInt("quiz_id"));
        q.setQuestionText(rs.getString("question_text"));
        q.setType(Question.QuestionType.valueOf(rs.getString("question_type")));
        q.setExplanation(rs.getString("explanation"));
        q.setDifficulty(rs.getString("difficulty"));

        // Handle potential naming difference for language_tag and points
        try {
            q.setLanguageTag(rs.getString("language_tag"));
        } catch (Exception e) {
        }
        try {
            q.setPoints(rs.getInt("points_value"));
        } catch (Exception e) {
            try {
                q.setPoints(rs.getInt("points"));
            } catch (Exception e2) {
            }
        }

        // Load answers
        q.setAnswers(getAnswersForQuestion(q.getId()));
        return q;
    }

    private List<Answer> getAnswersForQuestion(int questionId) {
        List<Answer> answers = new ArrayList<>();
        String sql = "SELECT * FROM answers WHERE question_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, questionId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Answer a = new Answer();
                a.setId(rs.getInt("id"));
                a.setQuestionId(rs.getInt("question_id"));
                a.setAnswerText(rs.getString("answer_text"));
                a.setCorrect(rs.getBoolean("is_correct"));
                answers.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return answers;
    }
}
