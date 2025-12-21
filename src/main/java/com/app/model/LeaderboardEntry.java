package com.app.model;

import java.sql.Date;
import java.sql.Timestamp;

public class LeaderboardEntry {

    public enum LeaderboardType {
        DAILY, WEEKLY, GLOBAL
    }

    private int id;
    private int userId;
    private String username; // For display
    private LeaderboardType leaderboardType;
    private String languageTag;
    private int rankPosition;
    private int score;
    private Date periodStart;
    private Date periodEnd;
    private Timestamp createdAt;

    // Additional user info for display
    private int userLevel;
    private int badgeCount;

    // Constructors
    public LeaderboardEntry() {
    }

    public LeaderboardEntry(int userId, LeaderboardType type, int score) {
        this.userId = userId;
        this.leaderboardType = type;
        this.score = score;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public LeaderboardType getLeaderboardType() {
        return leaderboardType;
    }

    public void setLeaderboardType(LeaderboardType leaderboardType) {
        this.leaderboardType = leaderboardType;
    }

    public String getLanguageTag() {
        return languageTag;
    }

    public void setLanguageTag(String languageTag) {
        this.languageTag = languageTag;
    }

    public int getRankPosition() {
        return rankPosition;
    }

    public void setRankPosition(int rankPosition) {
        this.rankPosition = rankPosition;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Date getPeriodStart() {
        return periodStart;
    }

    public void setPeriodStart(Date periodStart) {
        this.periodStart = periodStart;
    }

    public Date getPeriodEnd() {
        return periodEnd;
    }

    public void setPeriodEnd(Date periodEnd) {
        this.periodEnd = periodEnd;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getUserLevel() {
        return userLevel;
    }

    public void setUserLevel(int userLevel) {
        this.userLevel = userLevel;
    }

    public int getBadgeCount() {
        return badgeCount;
    }

    public void setBadgeCount(int badgeCount) {
        this.badgeCount = badgeCount;
    }

    @Override
    public String toString() {
        return "LeaderboardEntry{" +
                "rank=" + rankPosition +
                ", username='" + username + '\'' +
                ", score=" + score +
                ", type=" + leaderboardType +
                '}';
    }
}
