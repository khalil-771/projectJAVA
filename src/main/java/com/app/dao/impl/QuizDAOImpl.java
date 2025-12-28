package com.app.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.app.dao.QuizDAO;
import com.app.model.Answer;
import com.app.model.Question;
import com.app.model.Quiz;
import com.app.util.DatabaseConnection;

public class QuizDAOImpl implements QuizDAO {

    @Override
    public List<Quiz> findQuizzesByCourseId(int courseId) {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM quizzes WHERE course_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    quizzes.add(mapRowToQuiz(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quizzes;
    }

    @Override
    public Optional<Quiz> findQuizById(int quizId) {
        String sql = "SELECT * FROM quizzes WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRowToQuiz(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public Quiz getFullQuiz(int quizId) {
        Optional<Quiz> quizOpt = findQuizById(quizId);
        if (quizOpt.isEmpty())
            return null;

        Quiz quiz = quizOpt.get();

        // Fetch Questions
        String qSql = "SELECT * FROM questions WHERE quiz_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(qSql)) {
            stmt.setInt(1, quizId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Question q = new Question();
                    q.setId(rs.getInt("id"));
                    q.setQuizId(rs.getInt("quiz_id"));
                    q.setQuestionText(rs.getString("question_text"));
                    q.setType(Question.QuestionType.valueOf(rs.getString("question_type")));
                    q.setExplanation(rs.getString("explanation"));
                    q.setDifficulty(rs.getString("difficulty"));

                    // Fetch Answers for this question
                    q.setAnswers(getAnswersForQuestion(q.getId()));

                    quiz.addQuestion(q);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return quiz;
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

    private Quiz mapRowToQuiz(ResultSet rs) throws SQLException {
        Quiz q = new Quiz();
        q.setId(rs.getInt("id"));
        q.setCourseId(rs.getInt("course_id"));
        q.setTitle(rs.getString("title"));
        q.setFinalExam(rs.getBoolean("is_final_exam"));
        q.setPassingScore(rs.getInt("passing_score"));
        return q;
    }

    @Override
    public List<Question> findQuestionsByCourseAndDifficulty(int courseId, String difficulty) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT q.* FROM questions q " +
                "JOIN quizzes qu ON q.quiz_id = qu.id " +
                "WHERE qu.course_id = ? AND q.difficulty = ?";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
            stmt.setString(2, difficulty);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Question q = new Question();
                    q.setId(rs.getInt("id"));
                    q.setQuizId(rs.getInt("quiz_id"));
                    q.setQuestionText(rs.getString("question_text"));
                    q.setType(Question.QuestionType.valueOf(rs.getString("question_type")));
                    q.setExplanation(rs.getString("explanation"));
                    q.setDifficulty(rs.getString("difficulty"));
                    q.setAnswers(getAnswersForQuestion(q.getId()));
                    questions.add(q);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }

    @Override
    public boolean saveQuizResult(int userId, int quizId, int score, boolean passed) {
        String sql = "INSERT INTO user_quiz_results (user_id, quiz_id, score, passed) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, quizId);
            stmt.setInt(3, score);
            stmt.setBoolean(4, passed);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
