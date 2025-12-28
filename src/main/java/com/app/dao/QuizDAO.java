package com.app.dao;

import java.util.List;
import java.util.Optional;

import com.app.model.Question;
import com.app.model.Quiz;

public interface QuizDAO {
    List<Quiz> findQuizzesByCourseId(int courseId);

    Optional<Quiz> findQuizById(int quizId);

    Quiz getFullQuiz(int quizId); // Fetch questions and answers

    List<Question> findQuestionsByCourseAndDifficulty(int courseId, String difficulty);

    boolean saveQuizResult(int userId, int quizId, int score, boolean passed);
}
