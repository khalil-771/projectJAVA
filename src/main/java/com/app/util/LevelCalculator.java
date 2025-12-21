package com.app.util;

public class LevelCalculator {

    // Base XP needed for level 1
    private static final int BASE_XP = 100;

    /**
     * Calculate level based on total XP
     * Formula: Level = 1 + sqrt(XP / 100)
     */
    public static int calculateLevel(int totalXP) {
        if (totalXP < 0)
            return 1;
        return (int) Math.floor(1 + Math.sqrt(totalXP / (double) BASE_XP));
    }

    /**
     * Calculate minimum XP required to reach a specific level
     * Formula: XP = (Level - 1)^2 * 100
     */
    public static int getPointsForLevel(int level) {
        if (level <= 1)
            return 0;
        return (int) (Math.pow(level - 1, 2) * BASE_XP);
    }

    /**
     * Get title for a level
     */
    public static String getLevelTitle(int level) {
        if (level < 5)
            return "Novice";
        if (level < 10)
            return "Apprenti";
        if (level < 20)
            return "Initié";
        if (level < 30)
            return "Expert";
        if (level < 50)
            return "Maître";
        return "Légende";
    }
}
