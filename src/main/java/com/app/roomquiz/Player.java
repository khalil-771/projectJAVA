package com.app.roomquiz;

/**
 * Player in a room
 */
public class Player {
    private String userId;
    private String username;
    private boolean isReady;

    public Player() {
    }

    public Player(String userId, String username) {
        this.userId = userId;
        this.username = username;
        this.isReady = false;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        this.username = username;
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
