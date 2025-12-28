package com.app.network;

import java.io.*;
import java.net.*;
import java.util.*;
import java.util.concurrent.*;

/**
 * Server that runs on the host machine to coordinate a multiplayer room
 */
public class QuizServer {
    private int port;
    private ServerSocket serverSocket;
    private List<ClientHandler> clients = new CopyOnWriteArrayList<>();
    private boolean running = false;

    public QuizServer(int port) {
        this.port = port;
    }

    public void start() {
        new Thread(() -> {
            try {
                serverSocket = new ServerSocket(port);
                running = true;
                System.out.println("🚀 Quiz Server started on port " + port);

                while (running) {
                    Socket clientSocket = serverSocket.accept();
                    System.out.println("👤 New client connected: " + clientSocket.getInetAddress());
                    ClientHandler handler = new ClientHandler(clientSocket);
                    clients.add(handler);
                    new Thread(handler).start();
                }
            } catch (IOException e) {
                if (running)
                    e.printStackTrace();
            }
        }).start();
    }

    public void stop() {
        running = false;
        try {
            if (serverSocket != null)
                serverSocket.close();
            for (ClientHandler client : clients) {
                client.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void broadcast(NetworkMessage message) {
        for (ClientHandler client : clients) {
            client.sendMessage(message);
        }
    }

    private class ClientHandler implements Runnable {
        private Socket socket;
        private ObjectOutputStream out;
        private ObjectInputStream in;

        public ClientHandler(Socket socket) {
            this.socket = socket;
            try {
                out = new ObjectOutputStream(socket.getOutputStream());
                in = new ObjectInputStream(socket.getInputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        @Override
        public void run() {
            try {
                while (running) {
                    NetworkMessage msg = (NetworkMessage) in.readObject();
                    // Relay message or process it
                    System.out.println("📩 Received: " + msg.getType() + " from " + msg.getSender());

                    // Most messages in this architecture are relayed to everyone
                    broadcast(msg);
                }
            } catch (Exception e) {
                System.out.println("❌ Client disconnected: " + socket.getInetAddress());
            } finally {
                clients.remove(this);
                close();
            }
        }

        public void sendMessage(NetworkMessage msg) {
            try {
                out.writeObject(msg);
                out.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        public void close() {
            try {
                if (socket != null)
                    socket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
