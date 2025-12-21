package com.app.model;

import java.sql.Timestamp;
import com.app.util.LevelCalculator;

public class UserStats {
    private int userId;
    private int totalPoints;
    private int currentLevel;
    private int experiencePoints;
    private int bestStreak;
    private int currentStreak;
    private int totalQuizzesPlayed;
    private int totalCorrectAnswers;
    private int totalQuestionsAnswered;
    private java.sql.Date lastQuizDate;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructors
    public UserStats() {
    }

    public UserStats(int userId) {
        this.userId = userId;
        this.totalPoints = 0;
        this.currentLevel = 1;
        this.experiencePoints = 0;
        this.bestStreak = 0;
        this.currentStreak = 0;
        this.totalQuizzesPlayed = 0;
        this.totalCorrectAnswers = 0;
        this.totalQuestionsAnswered = 0;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(int totalPoints) {
        this.totalPoints = totalPoints;
    }

    public int getCurrentLevel() {
        return currentLevel;
    }

    public void setCurrentLevel(int currentLevel) {
        this.currentLevel = currentLevel;
    }

    public int getExperiencePoints() {
        return experiencePoints;
    }

    public void setExperiencePoints(int experiencePoints) {
        this.experiencePoints = experiencePoints;
    }

    public int getBestStreak() {
        return bestStreak;
    }

    public void setBestStreak(int bestStreak) {
        this.bestStreak = bestStreak;
    }

    public int getCurrentStreak() {
        return currentStreak;
    }

    public void setCurrentStreak(int currentStreak) {
        this.currentStreak = currentStreak;
    }

    public int getTotalQuizzesPlayed() {
        return totalQuizzesPlayed;
    }

    public void setTotalQuizzesPlayed(int totalQuizzesPlayed) {
        this.totalQuizzesPlayed = totalQuizzesPlayed;
    }

    public int getTotalCorrectAnswers() {
        return totalCorrectAnswers;
    }

    public void setTotalCorrectAnswers(int totalCorrectAnswers) {
        this.totalCorrectAnswers = totalCorrectAnswers;
    }

    public int getTotalQuestionsAnswered() {
        return totalQuestionsAnswered;
    }

    public void setTotalQuestionsAnswered(int totalQuestionsAnswered) {
        this.totalQuestionsAnswered = totalQuestionsAnswered;
    }

    public java.sql.Date getLastQuizDate() {
        return lastQuizDate;
    }

    public void setLastQuizDate(java.sql.Date lastQuizDate) {
        this.lastQuizDate = lastQuizDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Calculated properties
    public double getAccuracyRate() {
        return totalQuestionsAnswered > 0
                ? (double) totalCorrectAnswers / totalQuestionsAnswered * 100.0
                : 0.0;
    }

    public int getPointsToNextLevel() {
        return LevelCalculator.getPointsForLevel(currentLevel + 1) - experiencePoints;
    }

    public double getLevelProgress() {
        int currentLevelPoints = LevelCalculator.getPointsForLevel(currentLevel);
        int nextLevelPoints = LevelCalculator.getPointsForLevel(currentLevel + 1);
        int pointsInCurrentLevel = experiencePoints - currentLevelPoints;
        int pointsNeeded = nextLevelPoints - currentLevelPoints;
        return pointsNeeded > 0 ? (double) pointsInCurrentLevel / pointsNeeded * 100.0 : 0.0;
    }

    @Override
    public String toString() {
        return "UserStats{" +
                "userId=" + userId +
                ", totalPoints=" + totalPoints +
                ", currentLevel=" + currentLevel +
                ", experiencePoints=" + experiencePoints +
                ", accuracy=" + String.format("%.1f%%", getAccuracyRate()) +
                '}';
    }
}
