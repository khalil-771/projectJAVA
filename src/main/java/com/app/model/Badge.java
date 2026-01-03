package com.app.model;

import java.sql.Timestamp;

public class Badge {

    public enum BadgeType {
        ACHIEVEMENT,
        MILESTONE,
        MASTERY,
        STREAK,
        SCORE,
        LEVEL,
        COURSE_COMPLETION,
        SPECIAL
    }

    private int id;
    private String name;
    private String description;
    private String iconPath;
    private BadgeType badgeType;
    private int pointsReward;
    private String ruleCondition;
    private Timestamp createdAt;

    // Constructors
    public Badge() {
    }

    public Badge(String name, String description, BadgeType badgeType, int pointsReward) {
        this.name = name;
        this.description = description;
        this.badgeType = badgeType;
        this.pointsReward = pointsReward;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIconPath() {
        return iconPath;
    }

    public void setIconPath(String iconPath) {
        this.iconPath = iconPath;
    }

    public BadgeType getBadgeType() {
        return badgeType;
    }

    public void setBadgeType(BadgeType badgeType) {
        this.badgeType = badgeType;
    }

    public int getPointsReward() {
        return pointsReward;
    }

    public void setPointsReward(int pointsReward) {
        this.pointsReward = pointsReward;
    }

    public String getRuleCondition() {
        return ruleCondition;
    }

    public void setRuleCondition(String ruleCondition) {
        this.ruleCondition = ruleCondition;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Badge{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type=" + badgeType +
                ", points=" + pointsReward +
                '}';
    }
}
