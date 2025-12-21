package com.app.service;

import com.app.dao.LeaderboardDAO;
import com.app.dao.impl.LeaderboardDAOImpl;
import com.app.model.LeaderboardEntry;
import com.app.model.LeaderboardEntry.LeaderboardType;

import java.util.List;

public class LeaderboardService {

    private final LeaderboardDAO leaderboardDAO;

    public LeaderboardService() {
        this.leaderboardDAO = new LeaderboardDAOImpl();
    }

    /**
     * Get daily leaderboard (top players today)
     */
    public List<LeaderboardEntry> getDailyLeaderboard(String languageTag) {
        return leaderboardDAO.getDailyLeaderboard(languageTag, 50);
    }

    /**
     * Get weekly leaderboard (top players this week)
     */
    public List<LeaderboardEntry> getWeeklyLeaderboard(String languageTag) {
        return leaderboardDAO.getWeeklyLeaderboard(languageTag, 50);
    }

    /**
     * Get global leaderboard (all-time top players)
     */
    public List<LeaderboardEntry> getGlobalLeaderboard(String languageTag) {
        return leaderboardDAO.getGlobalLeaderboard(languageTag, 100);
    }

    /**
     * Get top N players for any leaderboard type
     */
    public List<LeaderboardEntry> getTopPlayers(LeaderboardType type, String languageTag, int limit) {
        switch (type) {
            case DAILY:
                return leaderboardDAO.getDailyLeaderboard(languageTag, limit);
            case WEEKLY:
                return leaderboardDAO.getWeeklyLeaderboard(languageTag, limit);
            case GLOBAL:
            default:
                return leaderboardDAO.getGlobalLeaderboard(languageTag, limit);
        }
    }

    /**
     * Get user's current rank
     */
    public int getUserRank(int userId, LeaderboardType type, String languageTag) {
        return leaderboardDAO.getUserRank(userId, type, languageTag);
    }

    /**
     * Get user's position in leaderboard (returns the entry if user is in top N)
     */
    public LeaderboardEntry getUserPosition(int userId, LeaderboardType type, String languageTag) {
        List<LeaderboardEntry> leaderboard = getTopPlayers(type, languageTag, 100);

        for (LeaderboardEntry entry : leaderboard) {
            if (entry.getUserId() == userId) {
                return entry;
            }
        }

        // User not in top 100, calculate rank separately
        int rank = getUserRank(userId, type, languageTag);
        if (rank > 0) {
            LeaderboardEntry entry = new LeaderboardEntry();
            entry.setUserId(userId);
            entry.setRankPosition(rank);
            entry.setLeaderboardType(type);
            entry.setLanguageTag(languageTag);
            return entry;
        }

        return null;
    }
}
