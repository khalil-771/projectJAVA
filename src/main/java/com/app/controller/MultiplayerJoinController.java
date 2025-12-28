package com.app.controller;

import com.app.App;
import com.app.model.User;
import com.app.roomquiz.Room;
import com.app.roomquiz.RoomManager;
import com.app.service.AuthenticationService;
import com.app.network.NetworkManager;
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
        String code = roomCodeField.getText();

        if (code == null || code.trim().isEmpty()) {
            showError("Veuillez entrer le code de la salle.");
            return;
        }

        // 1. Fetch Room from DB to get Host IP automatically
        Room room = roomManager.getRoom(code.trim());
        if (room == null) {
            showError("Salle introuvable pour le code: " + code);
            return;
        }

        String hostIp = room.getHostIp();
        if (hostIp == null || hostIp.isEmpty()) {
            showError("Erreur: L'adresse IP de l'hôte n'est pas définie.");
            return;
        }

        // 2. Connect via Socket
        boolean connected = NetworkManager.getInstance().joinHost(hostIp, 8888);

        if (connected) {
            User currentUser = AuthenticationService.getCurrentUser();

            // 3. Join Room logic
            boolean joined = roomManager.joinRoom(code.trim(), String.valueOf(currentUser.getId()),
                    currentUser.getUsername());

            if (joined) {
                NetworkManager.getInstance().sendMessage("JOIN", currentUser.getUsername(), currentUser);
                navigateToRoom(room);
            } else {
                showError("Impossible de rejoindre la salle (Salle pleine).");
            }
        } else {
            showError("Impossible de se connecter à l'hôte (" + hostIp + ").");
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
