package com.app.model;

import java.sql.Timestamp;

/**
 * Quiz history entry for tracking user's quiz attempts
 */
public class QuizHistory {
    private int id;
    private int userId;
    private int quizId;
    private String quizTitle;
    private String languageTag;
    private int score;
    private int pointsEarned;
    private int correctAnswers;
    private int totalQuestions;
    private String difficultyLevel;
    private long timeSpent; // in seconds
    private Timestamp completedAt;

    // Constructors
    public QuizHistory() {
    }

    public QuizHistory(int userId, int quizId, String quizTitle, String languageTag,
            int score, int pointsEarned, int correctAnswers, int totalQuestions,
            String difficultyLevel, long timeSpent) {
        this.userId = userId;
        this.quizId = quizId;
        this.quizTitle = quizTitle;
        this.languageTag = languageTag;
        this.score = score;
        this.pointsEarned = pointsEarned;
        this.correctAnswers = correctAnswers;
        this.totalQuestions = totalQuestions;
        this.difficultyLevel = difficultyLevel;
        this.timeSpent = timeSpent;
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

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuizTitle() {
        return quizTitle;
    }

    public void setQuizTitle(String quizTitle) {
        this.quizTitle = quizTitle;
    }

    public String getLanguageTag() {
        return languageTag;
    }

    public void setLanguageTag(String languageTag) {
        this.languageTag = languageTag;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getPointsEarned() {
        return pointsEarned;
    }

    public void setPointsEarned(int pointsEarned) {
        this.pointsEarned = pointsEarned;
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

    public String getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(String difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public long getTimeSpent() {
        return timeSpent;
    }

    public void setTimeSpent(long timeSpent) {
        this.timeSpent = timeSpent;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    // Calculated properties
    public double getAccuracy() {
        return totalQuestions > 0 ? (correctAnswers * 100.0 / totalQuestions) : 0.0;
    }

    public String getFormattedTime() {
        long minutes = timeSpent / 60;
        long seconds = timeSpent % 60;
        return String.format("%d:%02d", minutes, seconds);
    }

    public String getGrade() {
        if (score >= 90)
            return "A";
        if (score >= 80)
            return "B";
        if (score >= 70)
            return "C";
        if (score >= 60)
            return "D";
        return "F";
    }

    @Override
    public String toString() {
        return quizTitle + " - " + score + "% (" + getGrade() + ")";
    }
}
