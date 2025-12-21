package com.app.service;

import com.app.dao.BadgeDAO;
import com.app.dao.impl.BadgeDAOImpl;
import com.app.model.Badge;
import com.app.model.UserBadge;
import com.app.model.UserStats;

import java.util.ArrayList;
import java.util.List;

public class BadgeService {

    private final BadgeDAO badgeDAO;
    private final StatsService statsService;

    public BadgeService() {
        this.badgeDAO = new BadgeDAOImpl();
        this.statsService = new StatsService();
    }

    /**
     * Check all badge conditions and award any newly earned badges
     * Returns list of newly awarded badges
     */
    public List<Badge> checkAndAwardBadges(int userId) {
        List<Badge> newlyAwarded = new ArrayList<>();
        UserStats stats = statsService.getUserStats(userId);
        if (stats == null)
            return newlyAwarded;

        List<Badge> allBadges = badgeDAO.findAll();

        for (Badge badge : allBadges) {
            // Skip if user already has this badge
            if (badgeDAO.userHasBadge(userId, badge.getId())) {
                continue;
            }

            // Check if user meets the condition
            if (checkBadgeCondition(badge, stats, userId)) {
                if (badgeDAO.awardBadge(userId, badge.getId())) {
                    newlyAwarded.add(badge);

                    // Award points for the badge
                    if (badge.getPointsReward() > 0) {
                        statsService.addPoints(userId, badge.getPointsReward());
                    }

                    System.out.println(
                            "🏆 Badge earned: " + badge.getName() + " (+" + badge.getPointsReward() + " points)");
                }
            }
        }

        return newlyAwarded;
    }

    /**
     * Check if a user meets the condition for a specific badge
     */
    private boolean checkBadgeCondition(Badge badge, UserStats stats, int userId) {
        String condition = badge.getRuleCondition();
        if (condition == null || condition.isEmpty())
            return false;

        try {
            // Parse simple conditions
            if (condition.contains("total_quizzes")) {
                return evaluateNumericCondition(condition, "total_quizzes", stats.getTotalQuizzesPlayed());
            }

            if (condition.contains("best_streak")) {
                return evaluateNumericCondition(condition, "best_streak", stats.getBestStreak());
            }

            if (condition.contains("current_level")) {
                return evaluateNumericCondition(condition, "current_level", stats.getCurrentLevel());
            }

            if (condition.contains("accuracy")) {
                return evaluateNumericCondition(condition, "accuracy", (int) stats.getAccuracyRate());
            }

            // Special conditions
            if (condition.equals("perfect_score == true")) {
                // This would need to be checked in the quiz result context
                // For now, we'll handle it separately
                return false;
            }

            if (condition.startsWith("language:")) {
                // Language-specific badges (e.g., "language:java,level:BEGINNER,count:5")
                // This requires checking user_language_stats table
                // We'll implement this when we have UserLanguageStatsDAO
                return false;
            }

            if (condition.contains("unique_languages")) {
                // Check number of unique languages played
                // Requires language stats
                return false;
            }

            if (condition.contains("leaderboard_rank")) {
                // Check leaderboard position
                // Requires leaderboard service
                return false;
            }

        } catch (Exception e) {
            System.err.println("Error evaluating badge condition: " + condition);
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Evaluate numeric conditions like "total_quizzes >= 10"
     */
    private boolean evaluateNumericCondition(String condition, String variable, int actualValue) {
        if (condition.contains(variable + " >= ")) {
            int requiredValue = Integer.parseInt(condition.split(">=")[1].trim());
            return actualValue >= requiredValue;
        }
        if (condition.contains(variable + " > ")) {
            int requiredValue = Integer.parseInt(condition.split(">")[1].trim());
            return actualValue > requiredValue;
        }
        if (condition.contains(variable + " == ")) {
            int requiredValue = Integer.parseInt(condition.split("==")[1].trim());
            return actualValue == requiredValue;
        }
        return false;
    }

    /**
     * Get all badges earned by a user
     */
    public List<UserBadge> getUserBadges(int userId) {
        return badgeDAO.findUserBadges(userId);
    }

    /**
     * Get all available badges
     */
    public List<Badge> getAllBadges() {
        return badgeDAO.findAll();
    }

    /**
     * Get count of badges for a user
     */
    public int getUserBadgeCount(int userId) {
        return badgeDAO.getUserBadgeCount(userId);
    }

    /**
     * Check for specific achievement badges after quiz
     */
    public List<Badge> checkQuizAchievements(int userId, int score, int maxScore, boolean isPerfect) {
        List<Badge> newBadges = new ArrayList<>();

        // Check for perfect score badge
        if (isPerfect) {
            Badge perfectBadge = badgeDAO.findByName("Perfect Score").orElse(null);
            if (perfectBadge != null && !badgeDAO.userHasBadge(userId, perfectBadge.getId())) {
                if (badgeDAO.awardBadge(userId, perfectBadge.getId())) {
                    newBadges.add(perfectBadge);
                    statsService.addPoints(userId, perfectBadge.getPointsReward());
                }
            }
        }

        // Check general badges
        newBadges.addAll(checkAndAwardBadges(userId));

        return newBadges;
    }
}
