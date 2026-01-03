package com.app.roomquiz;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

import com.app.model.Quiz;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Room for multiplayer quiz battles
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Room {
    private String roomId;
    private String roomName;
    private String hostUserId;
    private String hostIp;
    private String language;
    private String difficulty;
    private int maxPlayers;
    private RoomStatus status;
    private Map<String, Player> players;
    private Quiz currentQuiz;
    private int currentQuestionIndex;
    private Map<String, Integer> scores;
    private Map<String, Integer> times; // Time in seconds
    private int currentQuizId; // ID of the quiz being played (synced from DB)

    public enum RoomStatus {
        WAITING, // Waiting for players
        STARTING, // Countdown before start
        IN_PROGRESS, // Quiz in progress
        FINISHED // Quiz completed
    }

    public Room() {
        this.players = new ConcurrentHashMap<>();
        this.scores = new ConcurrentHashMap<>();
        this.times = new ConcurrentHashMap<>();
        this.status = RoomStatus.WAITING;
        this.currentQuestionIndex = 0;
    }

    public Room(String roomId, String roomName, String hostUserId, String hostIp, String language, String difficulty,

            int maxPlayers) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.hostUserId = hostUserId;
        this.hostIp = hostIp;
        this.language = language;
        this.difficulty = difficulty;
        this.maxPlayers = maxPlayers;
        this.status = RoomStatus.WAITING;
        this.players = new ConcurrentHashMap<>();
        this.scores = new ConcurrentHashMap<>();
        this.times = new ConcurrentHashMap<>();
        this.currentQuestionIndex = 0;
    }

    /**
     * Add player to room
     */
    public boolean addPlayer(Player player) {
        if (players.size() >= maxPlayers) {
            return false;
        }

        if (status != RoomStatus.WAITING) {
            return false;
        }

        players.put(player.getUserId(), player);
        scores.put(player.getUserId(), 0);
        times.put(player.getUserId(), 0);
        return true;
    }

    /**
     * Internal use: add player when loading from DB (bypass status check)
     */
    public void addPlayerFromDB(Player player, int score, int time) {
        players.put(player.getUserId(), player);
        scores.put(player.getUserId(), score);
        times.put(player.getUserId(), time);
    }

    /**
     * Remove player from room
     */
    public void removePlayer(String userId) {
        players.remove(userId);
        scores.remove(userId);

        // If host leaves, assign new host
        if (userId.equals(hostUserId) && !players.isEmpty()) {
            hostUserId = players.keySet().iterator().next();
        }
    }

    /**
     * Start quiz
     */
    public boolean startQuiz(Quiz quiz) {
        if (players.size() < 2) {
            // Allow 1 player for testing/offline feel if needed, but rule says
            // "Multiplayer"
            // Let's relax it to 1 for testing if user is alone
            // return false;
        }

        this.currentQuiz = quiz;
        this.status = RoomStatus.IN_PROGRESS;
        this.currentQuestionIndex = 0;
        return true;
    }

    /**
     * Submit answer for a player
     */
    public void submitAnswer(String userId, int questionId, List<Integer> answerIds, boolean isCorrect) {
        if (isCorrect) {
            int currentScore = scores.getOrDefault(userId, 0);
            scores.put(userId, currentScore + 10);
        }
    }

    /**
     * Move to next question
     */
    public boolean nextQuestion() {
        currentQuestionIndex++;
        return currentQuestionIndex < currentQuiz.getQuestions().size();
    }

    /**
     * Get current leaderboard
     */
    public List<Map.Entry<String, Integer>> getLeaderboard() {
        List<Map.Entry<String, Integer>> leaderboard = new ArrayList<>(scores.entrySet());
        leaderboard.sort((a, b) -> b.getValue().compareTo(a.getValue()));
        return leaderboard;
    }

    /**
     * Check if room is full
     */
    public boolean isFull() {
        return players.size() >= maxPlayers;
    }

    /**
     * Get player count
     */
    public int getPlayerCount() {
        return players.size();
    }

    // Getters and Setters
    public String getRoomId() {
        return roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public String getHostUserId() {
        return hostUserId;
    }

    public int getMaxPlayers() {
        return maxPlayers;
    }

    public String getLanguage() {
        return language;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public String getHostIp() {
        return hostIp;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public void setHostUserId(String hostUserId) {
        this.hostUserId = hostUserId;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public void setMaxPlayers(int maxPlayers) {
        this.maxPlayers = maxPlayers;
    }

    public RoomStatus getStatus() {
        return status;
    }

    public void setStatus(RoomStatus status) {
        this.status = status;
    }

    public Map<String, Player> getPlayers() {
        return players;
    }

    public Quiz getCurrentQuiz() {
        return currentQuiz;
    }

    public int getCurrentQuestionIndex() {
        return currentQuestionIndex;
    }

    public Map<String, Integer> getScores() {
        return scores;
    }

    public Map<String, Integer> getTimes() {
        return times;
    }

    public int getCurrentQuizId() {
        return currentQuizId;
    }

    public void setCurrentQuizId(int currentQuizId) {
        this.currentQuizId = currentQuizId;
    }

    @Override
    public String toString() {
        return roomName + " (" + players.size() + "/" + maxPlayers + ") - " + status;
    }
}
