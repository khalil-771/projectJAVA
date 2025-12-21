package com.app.model;

import java.sql.Timestamp;

public class UserLanguageStats {
    private int id;
    private int userId;
    private String languageTag;
    private DifficultyLevel difficultyLevel;
    private int points;
    private int quizzesPlayed;
    private int correctAnswers;
    private int totalQuestions;
    private int bestScore;
    private Timestamp lastPlayed;
    private Timestamp createdAt;

    // Constructors
    public UserLanguageStats() {
    }

    public UserLanguageStats(int userId, String languageTag) {
        this.userId = userId;
        this.languageTag = languageTag;
        this.difficultyLevel = DifficultyLevel.BEGINNER;
        this.points = 0;
        this.quizzesPlayed = 0;
        this.correctAnswers = 0;
        this.totalQuestions = 0;
        this.bestScore = 0;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getLanguageTag() {
        return languageTag;
    }

    public void setLanguageTag(String languageTag) {
        this.languageTag = languageTag;
    }

    public DifficultyLevel getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(DifficultyLevel difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getQuizzesPlayed() {
        return quizzesPlayed;
    }

    public void setQuizzesPlayed(int quizzesPlayed) {
        this.quizzesPlayed = quizzesPlayed;
    }

    public int getCorrectAnswers() {
        return correctAnswers;
    }

    public void setCorrectAnswers(int correctAnswers) {
        this.correctAnswers = correctAnswers;
    }

    public int getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(int totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public int getBestScore() {
        return bestScore;
    }

    public void setBestScore(int bestScore) {
        this.bestScore = bestScore;
    }

    public Timestamp getLastPlayed() {
        return lastPlayed;
    }

    public void setLastPlayed(Timestamp lastPlayed) {
        this.lastPlayed = lastPlayed;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Calculated properties
    public double getAccuracyRate() {
        return totalQuestions > 0
                ? (double) correctAnswers / totalQuestions * 100.0
                : 0.0;
    }

    public ProgrammingLanguage getLanguage() {
        return ProgrammingLanguage.fromTag(languageTag);
    }

    @Override
    public String toString() {
        return "UserLanguageStats{" +
                "language=" + languageTag +
                ", difficulty=" + difficultyLevel +
                ", accuracy=" + String.format("%.1f%%", getAccuracyRate()) +
                ", quizzes=" + quizzesPlayed +
                '}';
    }
}
