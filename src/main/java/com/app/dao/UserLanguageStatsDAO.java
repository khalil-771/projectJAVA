package com.app.dao;

import com.app.model.UserLanguageStats;
import com.app.model.DifficultyLevel;

import java.util.List;
import java.util.Optional;

public interface UserLanguageStatsDAO {

    /**
     * Get stats for a specific user and language
     */
    Optional<UserLanguageStats> findByUserAndLanguage(int userId, String languageTag);

    /**
     * Get all language stats for a user
     */
    List<UserLanguageStats> findByUserId(int userId);

    /**
     * Create new language stats
     */
    boolean create(UserLanguageStats stats);

    /**
     * Update existing language stats
     */
    boolean update(UserLanguageStats stats);

    /**
     * Update difficulty level for a language
     */
    boolean updateDifficulty(int userId, String languageTag, DifficultyLevel newLevel);

    /**
     * Add points for a specific language
     */
    boolean addPoints(int userId, String languageTag, int points);

    /**
     * Update quiz statistics
     */
    boolean updateQuizStats(int userId, String languageTag, int correctAnswers, int totalQuestions);

    /**
     * Get count of unique languages played by user
     */
    int getUniqueLanguageCount(int userId);
}
