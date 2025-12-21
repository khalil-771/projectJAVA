package com.app.service;

import com.app.model.DifficultyLevel;
import com.app.model.UserLanguageStats;
import com.app.dao.UserLanguageStatsDAO;
import com.app.dao.impl.UserLanguageStatsDAOImpl;

/**
 * Engine for adaptive difficulty adjustment based on user performance
 */
public class DifficultyEngine {

    private final UserLanguageStatsDAO languageStatsDAO;

    // Thresholds for difficulty progression
    private static final double ACCURACY_THRESHOLD_UP = 85.0; // Move up if accuracy > 85%
    private static final double ACCURACY_THRESHOLD_DOWN = 50.0; // Move down if accuracy < 50%
    private static final int MIN_QUIZZES_FOR_ADJUSTMENT = 3; // Minimum quizzes before adjusting

    public DifficultyEngine() {
        this.languageStatsDAO = new UserLanguageStatsDAOImpl();
    }

    /**
     * Calculate recommended difficulty for a user in a specific language
     */
    public DifficultyLevel calculateDifficulty(int userId, String languageTag) {
        UserLanguageStats stats = languageStatsDAO.findByUserAndLanguage(userId, languageTag)
                .orElse(null);

        if (stats == null) {
            // New to this language, start at beginner
            return DifficultyLevel.BEGINNER;
        }

        // Not enough data yet
        if (stats.getQuizzesPlayed() < MIN_QUIZZES_FOR_ADJUSTMENT) {
            return stats.getDifficultyLevel();
        }

        double accuracy = stats.getAccuracyRate();
        DifficultyLevel currentLevel = stats.getDifficultyLevel();

        // Determine if we should adjust difficulty
        if (accuracy >= ACCURACY_THRESHOLD_UP && currentLevel != DifficultyLevel.ADVANCED) {
            // User is doing well, increase difficulty
            return getNextDifficulty(currentLevel);
        } else if (accuracy < ACCURACY_THRESHOLD_DOWN && currentLevel != DifficultyLevel.BEGINNER) {
            // User is struggling, decrease difficulty
            return getPreviousDifficulty(currentLevel);
        }

        // Keep current difficulty
        return currentLevel;
    }

    /**
     * Update user's difficulty level for a language
     */
    public boolean updateDifficulty(int userId, String languageTag, DifficultyLevel newLevel) {
        return languageStatsDAO.updateDifficulty(userId, languageTag, newLevel);
    }

    /**
     * Auto-adjust difficulty after quiz completion
     */
    public DifficultyLevel autoAdjustDifficulty(int userId, String languageTag) {
        DifficultyLevel recommended = calculateDifficulty(userId, languageTag);

        UserLanguageStats stats = languageStatsDAO.findByUserAndLanguage(userId, languageTag)
                .orElse(null);

        if (stats != null && recommended != stats.getDifficultyLevel()) {
            // Difficulty changed, update it
            if (updateDifficulty(userId, languageTag, recommended)) {
                System.out.println("📊 Difficulty adjusted to " + recommended + " for " + languageTag);
                return recommended;
            }
        }

        return stats != null ? stats.getDifficultyLevel() : DifficultyLevel.BEGINNER;
    }

    /**
     * Get next difficulty level
     */
    private DifficultyLevel getNextDifficulty(DifficultyLevel current) {
        switch (current) {
            case BEGINNER:
                return DifficultyLevel.INTERMEDIATE;
            case INTERMEDIATE:
                return DifficultyLevel.ADVANCED;
            case ADVANCED:
            default:
                return DifficultyLevel.ADVANCED;
        }
    }

    /**
     * Get previous difficulty level
     */
    private DifficultyLevel getPreviousDifficulty(DifficultyLevel current) {
        switch (current) {
            case ADVANCED:
                return DifficultyLevel.INTERMEDIATE;
            case INTERMEDIATE:
                return DifficultyLevel.BEGINNER;
            case BEGINNER:
            default:
                return DifficultyLevel.BEGINNER;
        }
    }

    /**
     * Get difficulty recommendation message
     */
    public String getDifficultyMessage(int userId, String languageTag) {
        DifficultyLevel recommended = calculateDifficulty(userId, languageTag);
        UserLanguageStats stats = languageStatsDAO.findByUserAndLanguage(userId, languageTag)
                .orElse(null);

        if (stats == null) {
            return "Start with " + recommended.getDisplayName() + " level";
        }

        if (recommended != stats.getDifficultyLevel()) {
            if (recommended.ordinal() > stats.getDifficultyLevel().ordinal()) {
                return "Great progress! Ready for " + recommended.getDisplayName() + " level?";
            } else {
                return "Let's practice " + recommended.getDisplayName() + " level for now";
            }
        }

        return "Continue with " + recommended.getDisplayName() + " level";
    }
}
