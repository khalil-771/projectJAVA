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
            if (client != null) {
                client.sendMessage(message);
            }
        }
    }

    private class ClientHandler implements Runnable {
        private Socket socket;
        private ObjectOutputStream out;
        private ObjectInputStream in;

        public ClientHandler(Socket socket) {
            this.socket = socket;
        }

        @Override
        public void run() {
            try {
                out = new ObjectOutputStream(socket.getOutputStream());
                out.flush();
                in = new ObjectInputStream(socket.getInputStream());

                while (running) {

                    NetworkMessage msg = (NetworkMessage) in.readObject();
                    if (msg == null)
                        break;

                    System.out.println("📩 Received: " + msg.getType() + " from " + msg.getSender());

                    // Relay message or process it
                    broadcast(msg);

                    // If it's a JOIN, also send current Room data back to the new player
                    if ("JOIN".equals(msg.getType())) {
                        com.app.roomquiz.Room activeRoom = NetworkManager.getInstance().getActiveRoom();
                        if (activeRoom != null) {
                            try {
                                com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
                                String roomJson = mapper.writeValueAsString(activeRoom);
                                sendMessage(new NetworkMessage("ROOM_INFO", "SERVER", roomJson));
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    }

                }
            } catch (java.io.EOFException | java.net.SocketException e) {
                System.out.println("👤 Client disconnected: " + socket.getInetAddress());
            } catch (Exception e) {
                System.out.println("❌ Error in ClientHandler for " + socket.getInetAddress() + ": " + e.getMessage());
                e.printStackTrace();
            } finally {
                clients.remove(this);
                close();
            }
        }

        public synchronized void sendMessage(NetworkMessage msg) {
            try {
                if (out != null) {
                    out.writeObject(msg);
                    out.flush();
                }
            } catch (IOException e) {
                System.err.println("Failed to send message to " + socket.getInetAddress() + ": " + e.getMessage());
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