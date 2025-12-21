package com.app.dao;

import com.app.model.QuizHistory;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

public interface QuizHistoryDAO {

    /**
     * Save quiz attempt to history
     */
    boolean save(QuizHistory history);

    /**
     * Get all quiz history for a user
     */
    List<QuizHistory> findByUserId(int userId);

    /**
     * Get quiz history for a user filtered by date range
     */
    List<QuizHistory> findByUserIdAndDateRange(int userId, Date startDate, Date endDate);

    /**
     * Get quiz history for a specific language
     */
    List<QuizHistory> findByUserIdAndLanguage(int userId, String languageTag);

    /**
     * Get recent quiz history (last N attempts)
     */
    List<QuizHistory> findRecentByUserId(int userId, int limit);

    /**
     * Get best score for a specific quiz
     */
    Optional<QuizHistory> findBestScoreForQuiz(int userId, int quizId);

    /**
     * Get average score for user
     */
    double getAverageScore(int userId);

    /**
     * Get total quizzes completed
     */
    int getTotalQuizzesCompleted(int userId);
}
