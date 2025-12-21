package com.app.dao;

import com.app.model.Quiz;
import java.util.List;
import java.util.Optional;

public interface QuizDAO {
    List<Quiz> findQuizzesByCourseId(int courseId);

    Optional<Quiz> findQuizById(int quizId);

    Quiz getFullQuiz(int quizId); // Fetch questions and answers
}
