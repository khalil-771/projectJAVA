package com.app.model;

import java.sql.Timestamp;

public class UserBadge {
    private int id;
    private int userId;
    private int badgeId;
    private Badge badge; // For joined queries
    private Timestamp earnedAt;

    // Constructors
    public UserBadge() {
    }

    public UserBadge(int userId, int badgeId) {
        this.userId = userId;
        this.badgeId = badgeId;
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

    public int getBadgeId() {
        return badgeId;
    }

    public void setBadgeId(int badgeId) {
        this.badgeId = badgeId;
    }

    public Badge getBadge() {
        return badge;
    }

    public void setBadge(Badge badge) {
        this.badge = badge;
    }

    public Timestamp getEarnedAt() {
        return earnedAt;
    }

    public void setEarnedAt(Timestamp earnedAt) {
        this.earnedAt = earnedAt;
    }

    @Override
    public String toString() {
        return "UserBadge{" +
                "userId=" + userId +
                ", badgeId=" + badgeId +
                ", earnedAt=" + earnedAt +
                '}';
    }
}
