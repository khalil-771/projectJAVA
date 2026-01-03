package com.app.controller;

import com.app.App;
import com.app.dao.QuestionDAO;
import com.app.dao.impl.QuestionDAOImpl;
import com.app.model.User;
import com.app.roomquiz.Room;
import com.app.roomquiz.RoomManager;
import com.app.service.AuthenticationService;
import com.app.service.CourseService;
import com.app.network.NetworkManager;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Alert;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.StackPane;

import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

public class MultiplayerCreateController {

    @FXML
    private TextField roomNameField;
    @FXML
    private TextField hostIpField;
    @FXML
    private ComboBox<String> languageCombo;
    @FXML
    private ComboBox<String> difficultyCombo;

    private StackPane contentArea;
    private final RoomManager roomManager = RoomManager.getInstance();
    private final CourseService courseService = new CourseService();
    private final QuestionDAO questionDAO = new QuestionDAOImpl();

    @FXML
    public void initialize() {
        // Detect local IP automatically
        hostIpField.setText(getLocalIpAddress());
        hostIpField.setEditable(true); // Allow user to correct it if wrong

        // Set default values immediately for instant page display
        // Set default values immediately for instant page display
        javafx.collections.ObservableList<String> difficulties = FXCollections.observableArrayList();
        for (com.app.model.DifficultyLevel level : com.app.model.DifficultyLevel.values()) {
            difficulties.add(level.getDisplayName());
        }
        difficultyCombo.setItems(difficulties);
        difficultyCombo.setValue(com.app.model.DifficultyLevel.BEGINNER.getDisplayName());

        // Defer language loading until AFTER the page is displayed
        javafx.application.Platform.runLater(() -> {
            loadLanguagesFromDatabase();
        });
    }

    private void loadLanguagesFromDatabase() {
        // Use the defined ProgrammingLanguage enum to ensure ALL languages are
        // available
        // regardless of whether there are questions for them in the database yet
        javafx.collections.ObservableList<String> languages = FXCollections.observableArrayList();
        languages.add("Tous les langages");

        for (com.app.model.ProgrammingLanguage lang : com.app.model.ProgrammingLanguage.values()) {
            languages.add(lang.getDisplayName());
        }

        languageCombo.setItems(languages);
        languageCombo.setValue("Tous les langages");
    }

    public void setContentArea(StackPane contentArea) {
        this.contentArea = contentArea;
    }

    @FXML
    private void handleCreate() {
        String name = roomNameField.getText();
        String ip = hostIpField.getText();
        String language = languageCombo.getValue();
        String difficulty = difficultyCombo.getValue();

        if (name == null || name.trim().isEmpty() || ip == null || ip.trim().isEmpty()) {
            showError("Veuillez remplir tous les champs.");
            return;
        }

        User currentUser = AuthenticationService.getCurrentUser();

        // Start Hosting (Socket Server)
        NetworkManager.getInstance().startHosting(8888);

        // Create Room in DB/Manager
        Room room = roomManager.createRoom(name, String.valueOf(currentUser.getId()), ip, language, difficulty, 4);

        if (room != null) {
            // Store room info for direct connect guests
            NetworkManager.getInstance().setActiveRoom(room);

            // Join our own room
            boolean joined = roomManager.joinRoom(room.getRoomId(), String.valueOf(currentUser.getId()),
                    currentUser.getUsername());
            if (joined) {
                navigateToRoom(room);
            }
        } else {
            showError("Échec de la création de la salle.");
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

    private String getLocalIpAddress() {
        try {
            Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
            while (interfaces.hasMoreElements()) {
                NetworkInterface iface = interfaces.nextElement();
                if (iface.isLoopback() || !iface.isUp())
                    continue;

                Enumeration<InetAddress> addresses = iface.getInetAddresses();
                while (addresses.hasMoreElements()) {
                    InetAddress addr = addresses.nextElement();
                    if (addr instanceof java.net.Inet4Address) {
                        return addr.getHostAddress();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "127.0.0.1";
    }

    private void showError(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setContentText(message);
        alert.show();
    }
}
