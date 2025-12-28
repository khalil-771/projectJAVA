package com.app.controller;

import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

import com.app.App;
import com.app.model.Course;
import com.app.model.User;
import com.app.service.AuthenticationService;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.control.SplitPane;
import javafx.scene.control.ToggleButton;
import javafx.scene.control.ToggleGroup;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.scene.layout.BorderPane;

public class MainController implements Initializable {

    @FXML
    private Label userLabel; // Renamed from usernameLabel to match FXML

    @FXML
    private StackPane contentArea;
    @FXML
    private SplitPane mainSplitPane;
    @FXML
    private VBox adminBox;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        User user = AuthenticationService.getCurrentUser();
        // Fixed: Null check for userLabel
        if (user != null && userLabel != null) {
            userLabel.setText("Utilisateur: " + user.getUsername());
        }

        // Load Dashboard by default
        showDashboard();

        // Check if Admin
        if (user != null && user.getRole() == User.Role.ROLE_ADMIN) {
            if (adminBox != null) {
                adminBox.setVisible(true);
                adminBox.setManaged(true);
            }
        }
    }

    @FXML
    private void showDashboard() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/dashboard.fxml"));
            ScrollPane dashboardView = loader.load();

            contentArea.getChildren().clear();
            contentArea.getChildren().add(dashboardView);
        } catch (IOException e) {
            e.printStackTrace();
            showError("Failed to load dashboard: " + e.getMessage());
        }
    }

    @FXML
    private void showLeaderboard() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/leaderboard.fxml"));
            VBox leaderboardView = loader.load();

            contentArea.getChildren().clear();
            contentArea.getChildren().add(leaderboardView);
        } catch (IOException e) {
            e.printStackTrace();
            showError("Failed to load leaderboard: " + e.getMessage());
        }
    }

    @FXML
    private void showQuizSelection() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/language_selection.fxml"));
            VBox quizSelectionView = loader.load(); // Assuming language_selection.fxml root is VBox

            LanguageSelectionController controller = loader.getController();
            controller.setContentArea(contentArea);

            contentArea.getChildren().clear();
            contentArea.getChildren().add(quizSelectionView);
        } catch (IOException e) {
            e.printStackTrace();
            showError("Failed to load quiz selection: " + e.getMessage());
        }
    }

    @FXML
    private void showQuizRoom() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/multiplayer_menu.fxml"));
            VBox view = loader.load();

            MultiplayerMenuController controller = loader.getController();
            controller.setContentArea(contentArea);

            contentArea.getChildren().clear();
            contentArea.getChildren().add(view);
        } catch (IOException e) {
            e.printStackTrace();
            showError("Failed to load multiplayer lobby: " + e.getMessage());
        }
    }

    @FXML
    private void showProfile() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/profile.fxml"));
            ScrollPane profileView = loader.load();

            contentArea.getChildren().clear();
            contentArea.getChildren().add(profileView);
        } catch (IOException e) {
            e.printStackTrace();
            showError("Failed to load profile: " + e.getMessage());
        }
    }

    @FXML
    private void showAdminStatistics() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/admin_statistics.fxml"));
            VBox view = loader.load();
            contentArea.getChildren().clear();
            contentArea.getChildren().add(view);
        } catch (IOException e) {
            e.printStackTrace();
            showError("Failed to load admin statistics: " + e.getMessage());
        }
    }

    @FXML
    private void showQuestionManagement() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/question_management.fxml"));
            VBox view = loader.load();
            contentArea.getChildren().clear();
            contentArea.getChildren().add(view);
        } catch (IOException e) {
            e.printStackTrace();
            showError("Failed to load question management: " + e.getMessage());
        }
    }

    private void showError(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Error");
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    @FXML
    private void handleLogout() throws IOException {
        AuthenticationService authService = new AuthenticationService();
        authService.logout();
        App.setRoot("login");
    }
}
