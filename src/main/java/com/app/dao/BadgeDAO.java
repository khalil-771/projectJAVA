package com.app.dao;

import com.app.model.Badge;
import com.app.model.UserBadge;

import java.util.List;
import java.util.Optional;

public interface BadgeDAO {

    /**
     * Get all available badges
     */
    List<Badge> findAll();

    /**
     * Get badge by ID
     */
    Optional<Badge> findById(int badgeId);

    /**
     * Get badge by name
     */
    Optional<Badge> findByName(String name);

    /**
     * Get all badges earned by a user
     */
    List<UserBadge> findUserBadges(int userId);

    /**
     * Check if user has a specific badge
     */
    boolean userHasBadge(int userId, int badgeId);

    /**
     * Award a badge to a user
     */
    boolean awardBadge(int userId, int badgeId);

    /**
     * Get count of badges for a user
     */
    int getUserBadgeCount(int userId);

    /**
     * Create a new badge (admin)
     */
    boolean createBadge(Badge badge);
}
