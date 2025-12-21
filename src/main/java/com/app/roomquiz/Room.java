package com.app.roomquiz;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Room for multiplayer quiz battles
 */
public class Room {
    private String roomId;
    private String roomName;
    private String hostUserId;
    private int maxPlayers;
    private RoomStatus status;
    private Map<String, Player> players;
    private Quiz currentQuiz;
    private int currentQuestionIndex;
    private Map<String, Integer> scores;

    public enum RoomStatus {
        WAITING, // Waiting for players
        STARTING, // Countdown before start
        IN_PROGRESS, // Quiz in progress
        FINISHED // Quiz completed
    }

    public Room(String roomId, String roomName, String hostUserId, int maxPlayers) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.hostUserId = hostUserId;
        this.maxPlayers = maxPlayers;
        this.status = RoomStatus.WAITING;
        this.players = new ConcurrentHashMap<>();
        this.scores = new ConcurrentHashMap<>();
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
        return true;
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
            return false; // Need at least 2 players
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

    @Override
    public String toString() {
        return roomName + " (" + players.size() + "/" + maxPlayers + ") - " + status;
    }
}

/**
 * Player in a room
 */
class Player {
    private String userId;
    private String username;
    private boolean isReady;

    public Player(String userId, String username) {
        this.userId = userId;
        this.username = username;
        this.isReady = false;
    }

    public String getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public boolean isReady() {
        return isReady;
    }

    public void setReady(boolean ready) {
        isReady = ready;
    }
}

/**
 * Quiz for multiplayer (simplified)
 */
class Quiz {
    private int id;
    private String title;
    private List<Question> questions;

    public Quiz(int id, String title, List<Question> questions) {
        this.id = id;
        this.title = title;
        this.questions = questions;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public List<Question> getQuestions() {
        return questions;
    }
}

/**
 * Question for multiplayer (simplified)
 */
class Question {
    private int id;
    private String text;

    public Question(int id, String text) {
        this.id = id;
        this.text = text;
    }

    public int getId() {
        return id;
    }

    public String getText() {
        return text;
    }
}
