package com.app.dao;

import com.app.model.LeaderboardEntry;
import com.app.model.LeaderboardEntry.LeaderboardType;

import java.sql.Date;
import java.util.List;

public interface LeaderboardDAO {

    /**
     * Get leaderboard entries for a specific type and period
     */
    List<LeaderboardEntry> getLeaderboard(LeaderboardType type, String languageTag, Date periodStart, int limit);

    /**
     * Get current daily leaderboard (today)
     */
    List<LeaderboardEntry> getDailyLeaderboard(String languageTag, int limit);

    /**
     * Get current weekly leaderboard (this week)
     */
    List<LeaderboardEntry> getWeeklyLeaderboard(String languageTag, int limit);

    /**
     * Get global (all-time) leaderboard
     */
    List<LeaderboardEntry> getGlobalLeaderboard(String languageTag, int limit);

    /**
     * Get user's rank in a specific leaderboard
     */
    int getUserRank(int userId, LeaderboardType type, String languageTag);

    /**
     * Save/update leaderboard entry
     */
    boolean saveEntry(LeaderboardEntry entry);

    /**
     * Clear old leaderboard entries (cleanup)
     */
    boolean clearOldEntries(Date beforeDate);
}
