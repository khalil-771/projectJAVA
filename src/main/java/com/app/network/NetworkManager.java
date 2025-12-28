package com.app.network;

import com.app.roomquiz.Room;
import com.app.roomquiz.Player;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;

/**
 * Singleton to manage networking state
 */
public class NetworkManager {
    private static NetworkManager instance;
    private QuizServer server;
    private QuizClient client;
    private final ObjectMapper mapper = new ObjectMapper();

    private NetworkManager() {
        client = new QuizClient();
    }

    public static synchronized NetworkManager getInstance() {
        if (instance == null) {
            instance = new NetworkManager();
        }
        return instance;
    }

    public void startHosting(int port) {
        if (server != null)
            server.stop();
        server = new QuizServer(port);
        server.start();

        // Host also connects to their own server - with a small retry loop
        new Thread(() -> {
            int retries = 5;
            while (retries > 0) {
                try {
                    Thread.sleep(500); // Wait for server to bind
                    if (client.connect("localhost", port)) {
                        System.out.println("✅ Host client auto-connected to own server.");
                        break;
                    }
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
                retries--;
                System.out.println("⏳ Retrying host client connection... (" + retries + " left)");
            }
        }).start();
    }

    public boolean joinHost(String ip, int port) {
        return client.connect(ip, port);
    }

    public QuizClient getClient() {
        return client;
    }

    public void stopAll() {
        if (server != null)
            server.stop();
        if (client != null)
            client.disconnect();
    }

    public void sendMessage(String type, String sender, Object payload) {
        try {
            String content = mapper.writeValueAsString(payload);
            client.sendMessage(new NetworkMessage(type, sender, content));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
