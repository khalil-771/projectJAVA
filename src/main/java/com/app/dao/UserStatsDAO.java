package com.app.dao;

import com.app.model.UserStats;
import java.util.Optional;

public interface UserStatsDAO {

    /**
     * Get user statistics by user ID
     */
    Optional<UserStats> findByUserId(int userId);

    /**
     * Create initial stats for a new user
     */
    boolean create(UserStats stats);

    /**
     * Update existing user stats
     */
    boolean update(UserStats stats);

    /**
     * Delete user stats
     */
    boolean delete(int userId);

    /**
     * Add points to user (updates total_points and experience_points)
     */
    boolean addPoints(int userId, int points);

    /**
     * Update streak information
     */
    boolean updateStreak(int userId, int newStreak);

    /**
     * Increment quiz count
     */
    boolean incrementQuizCount(int userId);

    /**
     * Update question statistics
     */
    boolean updateQuestionStats(int userId, int correctAnswers, int totalQuestions);
}
