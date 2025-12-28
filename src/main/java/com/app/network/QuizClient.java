package com.app.network;

import java.io.*;
import java.net.*;
import java.util.function.Consumer;

/**
 * Client that connects to the host server
 */
public class QuizClient {
    private Socket socket;
    private ObjectOutputStream out;
    private ObjectInputStream in;
    private boolean connected = false;
    private Consumer<NetworkMessage> messageHandler;

    public boolean connect(String host, int port) {
        try {
            socket = new Socket(host, port);
            out = new ObjectOutputStream(socket.getOutputStream());
            in = new ObjectInputStream(socket.getInputStream());
            connected = true;

            // Start listener thread
            new Thread(this::listen).start();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void listen() {
        try {
            while (connected) {
                NetworkMessage msg = (NetworkMessage) in.readObject();
                if (messageHandler != null) {
                    messageHandler.accept(msg);
                }
            }
        } catch (Exception e) {
            System.out.println("🔌 Connection lost");
            connected = false;
        }
    }

    public void sendMessage(NetworkMessage msg) {
        if (!connected)
            return;
        try {
            out.writeObject(msg);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void setMessageHandler(Consumer<NetworkMessage> handler) {
        this.messageHandler = handler;
    }

    public void disconnect() {
        connected = false;
        try {
            if (socket != null)
                socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean isConnected() {
        return connected;
    }
}
