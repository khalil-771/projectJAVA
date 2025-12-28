package com.app.network;

import java.io.Serializable;

/**
 * Basic message structure for socket communication
 */
public class NetworkMessage implements Serializable {
    private String type; // e.g., JOIN, START, UPDATE, CHAT
    private String sender;
    private String content; // JSON payload

    public NetworkMessage() {
    }

    public NetworkMessage(String type, String sender, String content) {
        this.type = type;
        this.sender = sender;
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
