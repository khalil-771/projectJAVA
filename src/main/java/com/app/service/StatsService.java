package com.app.service;

import com.app.dao.UserStatsDAO;
import com.app.dao.impl.UserStatsDAOImpl;
import com.app.dao.UserLanguageStatsDAO;
import com.app.dao.impl.UserLanguageStatsDAOImpl;
import com.app.model.LevelCalculator;
import com.app.model.UserStats;
import com.app.model.UserLanguageStats;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Optional;

public class StatsService {

    private final UserStatsDAO statsDAO;
    private final UserLanguageStatsDAO languageStatsDAO;

    public StatsService() {
        this.statsDAO = new UserStatsDAOImpl();
        this.languageStatsDAO = new UserLanguageStatsDAOImpl();
    }

    /**
     * Get or create user stats
     */
    public UserStats getUserStats(int userId) {
        Optional<UserStats> statsOpt = statsDAO.findByUserId(userId);

        if (statsOpt.isPresent()) {
            return statsOpt.get();
        } else {
            // Create new stats for user
            UserStats newStats = new UserStats(userId);
            if (statsDAO.create(newStats)) {
                return newStats;
            }
            return null;
        }
    }

    /**
     * Update stats after completing a quiz
     */
    public void updateStatsAfterQuiz(int userId, String languageTag, int pointsEarned, int correctAnswers,
            int totalQuestions, int score) {
        UserStats stats = getUserStats(userId);
        if (stats == null)
            return;

        // Update points
        stats.setTotalPoints(stats.getTotalPoints() + pointsEarned);
        stats.setExperiencePoints(stats.getExperiencePoints() + pointsEarned);

        // Update question stats
        stats.setTotalCorrectAnswers(stats.getTotalCorrectAnswers() + correctAnswers);
        stats.setTotalQuestionsAnswered(stats.getTotalQuestionsAnswered() + totalQuestions);

        // Update quiz count
        stats.setTotalQuizzesPlayed(stats.getTotalQuizzesPlayed() + 1);

        // Update streak
        updateStreakLogic(stats);

        // Check for level up
        int newLevel = LevelCalculator.calculateLevel(stats.getExperiencePoints());
        if (newLevel > stats.getCurrentLevel()) {
            stats.setCurrentLevel(newLevel);
            System.out.println(
                    "🎉 Level up! You are now level " + newLevel + " - " + LevelCalculator.getLevelTitle(newLevel));
        }

        // Update last quiz date
        stats.setLastQuizDate(Date.valueOf(LocalDate.now()));

        // Save to database
        statsDAO.update(stats);

        // Update Language Specific Stats
        if (languageTag != null) {
            updateLanguageStats(userId, languageTag, pointsEarned, correctAnswers, totalQuestions, score);
        }
    }

    private void updateLanguageStats(int userId, String languageTag, int pointsEarned, int correctAnswers,
            int totalQuestions, int score) {
        Optional<UserLanguageStats> langStatsOpt = languageStatsDAO.findByUserAndLanguage(userId, languageTag);
        UserLanguageStats langStats;

        if (langStatsOpt.isPresent()) {
            langStats = langStatsOpt.get();
            langStats.setPoints(langStats.getPoints() + pointsEarned);
            langStats.setQuizzesPlayed(langStats.getQuizzesPlayed() + 1);
            langStats.setCorrectAnswers(langStats.getCorrectAnswers() + correctAnswers);
            langStats.setTotalQuestions(langStats.getTotalQuestions() + totalQuestions);
            if (score > langStats.getBestScore()) {
                langStats.setBestScore(score);
            }
            languageStatsDAO.update(langStats);
        } else {
            langStats = new UserLanguageStats(userId, languageTag);
            langStats.setPoints(pointsEarned);
            langStats.setQuizzesPlayed(1);
            langStats.setCorrectAnswers(correctAnswers);
            langStats.setTotalQuestions(totalQuestions);
            langStats.setBestScore(score);
            languageStatsDAO.create(langStats);
        }
    }

    /**
     * Update streak based on last quiz date
     */
    private void updateStreakLogic(UserStats stats) {
        Date lastQuizDate = stats.getLastQuizDate();
        Date today = Date.valueOf(LocalDate.now());

        if (lastQuizDate == null) {
            // First quiz ever
            stats.setCurrentStreak(1);
            stats.setBestStreak(1);
        } else {
            LocalDate lastDate = lastQuizDate.toLocalDate();
            LocalDate currentDate = today.toLocalDate();
            long daysBetween = ChronoUnit.DAYS.between(lastDate, currentDate);

            if (daysBetween == 0) {
                // Same day, streak stays
                // No change
            } else if (daysBetween == 1) {
                // Consecutive day, increment streak
                int newStreak = stats.getCurrentStreak() + 1;
                stats.setCurrentStreak(newStreak);
                if (newStreak > stats.getBestStreak()) {
                    stats.setBestStreak(newStreak);
                }
            } else {
                // Streak broken, reset to 1
                stats.setCurrentStreak(1);
            }
        }
    }

    /**
     * Add points directly (e.g., from badge rewards)
     */
    public void addPoints(int userId, int points) {
        UserStats stats = getUserStats(userId);
        if (stats == null)
            return;

        stats.setTotalPoints(stats.getTotalPoints() + points);
        stats.setExperiencePoints(stats.getExperiencePoints() + points);

        // Check for level up
        int newLevel = LevelCalculator.calculateLevel(stats.getExperiencePoints());
        if (newLevel > stats.getCurrentLevel()) {
            stats.setCurrentLevel(newLevel);
        }

        statsDAO.update(stats);
    }

    /**
     * Get accuracy rate for a user
     */
    public double getAccuracyRate(int userId) {
        UserStats stats = getUserStats(userId);
        return stats != null ? stats.getAccuracyRate() : 0.0;
    }

    /**
     * Get current streak
     */
    public int getCurrentStreak(int userId) {
        UserStats stats = getUserStats(userId);
        return stats != null ? stats.getCurrentStreak() : 0;
    }
}
