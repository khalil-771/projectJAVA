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
        return connect(host, port, 0); // Default no timeout
    }

    public boolean connect(String host, int port, int timeout) {
        try {
            // Ensure any previous connection is closed
            disconnect();

            socket = new Socket();
            socket.connect(new InetSocketAddress(host, port), timeout);

            out = new ObjectOutputStream(socket.getOutputStream());
            out.flush(); // Send header immediately
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
                if (msg != null && messageHandler != null) {
                    messageHandler.accept(msg);
                }
            }
        } catch (java.io.EOFException | java.net.SocketException e) {
            System.out.println("🔌 Connection closed by server.");
            connected = false;
        } catch (Exception e) {
            System.out.println("🔌 Connection lost: " + e.getMessage());
            e.printStackTrace();
            connected = false;
        }
    }

    public synchronized void sendMessage(NetworkMessage msg) {
        if (!connected || out == null)
            return;
        try {
            out.writeObject(msg);
            out.flush();
        } catch (IOException e) {
            System.err.println("Client failed to send message: " + e.getMessage());
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