package com.app.model;

public enum DifficultyLevel {
    BEGINNER("Débutant", 10, "🟢"),
    INTERMEDIATE("Intermédiaire", 20, "🟡"),
    ADVANCED("Avancé", 30, "🔴");

    private final String displayName;
    private final int basePoints;
    private final String emoji;

    DifficultyLevel(String displayName, int basePoints, String emoji) {
        this.displayName = displayName;
        this.basePoints = basePoints;
        this.emoji = emoji;
    }

    public String getDisplayName() {
        return displayName;
    }

    public int getBasePoints() {
        return basePoints;
    }

    public String getEmoji() {
        return emoji;
    }

    @Override
    public String toString() {
        return emoji + " " + displayName;
    }
}
