package com.app.controller;

import com.app.App;
import com.app.model.User;
import com.app.roomquiz.Room;
import com.app.roomquiz.RoomManager;
import com.app.service.AuthenticationService;
import com.app.network.NetworkManager;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.StackPane;

import java.io.IOException;

public class MultiplayerJoinController {

    @FXML
    private TextField hostIpField;
    @FXML
    private TextField roomCodeField;

    private StackPane contentArea;
    private final RoomManager roomManager = RoomManager.getInstance();

    public void setContentArea(StackPane contentArea) {
        this.contentArea = contentArea;
    }

    @FXML
    private void handleJoin() {
        String code = roomCodeField.getText().trim();
        String hostIp = hostIpField.getText().trim();

        if (code.isEmpty()) {
            showError("Veuillez entrer le code de la salle.");
            return;
        }

        Room room = null;
        if (hostIp.isEmpty()) {
            room = roomManager.getRoom(code);
            if (room != null) {
                hostIp = room.getHostIp();
            }
        }

        if (hostIp == null || hostIp.isEmpty()) {
            showError("Salle introuvable localement. Veuillez entrer l'adresse IP de l'hôte.");
            return;
        }

        final String finalHostIp = hostIp;
        final Room localRoom = room;

        // Disable UI
        roomCodeField.setDisable(true);
        hostIpField.setDisable(true);
        if (roomCodeField.getScene() != null) {
            roomCodeField.getScene().getRoot().setDisable(true);
        }

        new Thread(() -> {
            System.out.println("🌐 Attempting to connect to host: " + finalHostIp);
            boolean connected = NetworkManager.getInstance().joinHost(finalHostIp, 8888, 5000);

            Platform.runLater(() -> {
                if (connected) {
                    User currentUser = AuthenticationService.getCurrentUser();
                    if (localRoom != null) {
                        joinExistingRoom(code, currentUser, localRoom);
                    } else {
                        requestRoomInfoAndJoin(code, currentUser);
                    }
                } else {
                    showError("Impossible de se connecter à l'hôte (" + finalHostIp
                            + ").\nVérifiez l'IP et le Pare-feu.");
                    resetUI();
                }
            });
        }).start();
    }

    private void joinExistingRoom(String code, User user, Room room) {
        boolean joined = roomManager.joinRoom(code, String.valueOf(user.getId()), user.getUsername());
        if (joined) {
            NetworkManager.getInstance().sendMessage("JOIN", user.getUsername(), user);
            navigateToRoom(room);
        } else {
            showError("Impossible de rejoindre la salle (Salle pleine).");
            resetUI();
        }
    }

    private void requestRoomInfoAndJoin(String code, User user) {
        NetworkManager.getInstance().getClient().setMessageHandler(msg -> {
            if ("ROOM_INFO".equals(msg.getType())) {
                Platform.runLater(() -> {
                    try {
                        com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
                        Room receivedRoom = mapper.readValue(msg.getContent(), Room.class);
                        roomManager.syncRoomLocally(receivedRoom);
                        roomManager.joinRoom(code, String.valueOf(user.getId()), user.getUsername());
                        navigateToRoom(receivedRoom);
                    } catch (Exception e) {
                        e.printStackTrace();
                        showError("Erreur lors de la réception des données de la salle.");
                        resetUI();
                    }
                });
            }
        });
        NetworkManager.getInstance().sendMessage("JOIN", user.getUsername(), user);
    }

    private void resetUI() {
        roomCodeField.setDisable(false);
        hostIpField.setDisable(false);
        if (roomCodeField.getScene() != null) {
            roomCodeField.getScene().getRoot().setDisable(false);
        }
    }

    @FXML
    private void handleCancel() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/multiplayer_menu.fxml"));
            contentArea.getChildren().setAll((javafx.scene.Node) loader.load());
            MultiplayerMenuController controller = loader.getController();
            controller.setContentArea(contentArea);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void navigateToRoom(Room room) {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/room_view.fxml"));
            BorderPane roomView = loader.load();
            RoomController controller = loader.getController();
            controller.setRoom(room);
            controller.setContentArea(contentArea);

            // CRITICAL: Re-enable the scene root that was disabled during connection
            if (contentArea.getScene() != null) {
                contentArea.getScene().getRoot().setDisable(false);
            }

            contentArea.getChildren().setAll(roomView);
        } catch (IOException e) {
            e.printStackTrace();
            showError("Échec du chargement de la salle.");
        }
    }

    private void showError(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setContentText(message);
        alert.show();
    }
}
