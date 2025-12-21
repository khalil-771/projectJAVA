package com.app.model;

/**
 * Badge rules and conditions
 */
public class BadgeRules {

    // Achievement badges
    public static final String FIRST_QUIZ = "total_quizzes >= 1";
    public static final String QUIZ_ENTHUSIAST = "total_quizzes >= 10";
    public static final String QUIZ_MASTER = "total_quizzes >= 50";
    public static final String QUIZ_LEGEND = "total_quizzes >= 100";

    // Performance badges
    public static final String PERFECT_SCORE = "perfect_score == true";
    public static final String SPEED_DEMON = "speed_answers >= 10";
    public static final String ACCURACY_EXPERT = "accuracy >= 90 AND total_quizzes >= 20";

    // Streak badges
    public static final String STREAK_3 = "best_streak >= 3";
    public static final String STREAK_7 = "best_streak >= 7";
    public static final String STREAK_30 = "best_streak >= 30";

    // Level badges
    public static final String LEVEL_5 = "current_level >= 5";
    public static final String LEVEL_10 = "current_level >= 10";
    public static final String LEVEL_20 = "current_level >= 20";
    public static final String LEVEL_50 = "current_level >= 50";

    // Language mastery badges
    public static final String JAVA_BEGINNER = "language:java,level:BEGINNER,count:5";
    public static final String JAVA_INTERMEDIATE = "language:java,level:INTERMEDIATE,count:10";
    public static final String JAVA_MASTER = "language:java,level:ADVANCED,count:20";

    public static final String PYTHON_BEGINNER = "language:python,level:BEGINNER,count:5";
    public static final String PYTHON_MASTER = "language:python,level:ADVANCED,count:20";

    public static final String HTML_MASTER = "language:html,level:ADVANCED,count:10";
    public static final String CSS_MASTER = "language:css,level:ADVANCED,count:10";
    public static final String JS_MASTER = "language:javascript,level:ADVANCED,count:10";

    // Special badges
    public static final String POLYGLOT = "unique_languages >= 5";
    public static final String POLYGLOT_MASTER = "unique_languages >= 10";

    // Leaderboard badges
    public static final String TOP_10 = "leaderboard_rank <= 10";
    public static final String TOP_3 = "leaderboard_rank <= 3";
    public static final String CHAMPION = "leaderboard_rank == 1";

    /**
     * Check if a condition is met
     */
    public static boolean evaluateCondition(String condition, Object value) {
        // Simple evaluation logic
        if (condition.contains(">=")) {
            String[] parts = condition.split(">=");
            int required = Integer.parseInt(parts[1].trim());
            return (int) value >= required;
        }
        if (condition.contains("==")) {
            String[] parts = condition.split("==");
            if (parts[1].trim().equals("true")) {
                return (boolean) value;
            }
            int required = Integer.parseInt(parts[1].trim());
            return (int) value == required;
        }
        return false;
    }
}
