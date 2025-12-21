package com.app.model;

public class LevelCalculator {

    // XP required for each level (exponential growth)
    private static final int BASE_XP = 100;
    private static final double GROWTH_FACTOR = 1.5;

    /**
     * Calculate the total XP required to reach a specific level
     */
    public static int getPointsForLevel(int level) {
        if (level <= 1)
            return 0;

        int totalXP = 0;
        for (int i = 2; i <= level; i++) {
            totalXP += (int) (BASE_XP * Math.pow(GROWTH_FACTOR, i - 2));
        }
        return totalXP;
    }

    /**
     * Calculate the level based on total XP
     */
    public static int calculateLevel(int experiencePoints) {
        int level = 1;
        while (getPointsForLevel(level + 1) <= experiencePoints) {
            level++;
        }
        return level;
    }

    /**
     * Get XP needed for next level
     */
    public static int getXPForNextLevel(int currentLevel) {
        return getPointsForLevel(currentLevel + 1) - getPointsForLevel(currentLevel);
    }

    /**
     * Get level title/name
     */
    public static String getLevelTitle(int level) {
        if (level >= 50)
            return "Legend";
        if (level >= 40)
            return "Master";
        if (level >= 30)
            return "Expert";
        if (level >= 20)
            return "Advanced";
        if (level >= 10)
            return "Intermediate";
        if (level >= 5)
            return "Apprentice";
        return "Beginner";
    }
}
