package com.app.controller;

import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

import com.app.App;
import com.app.model.Course;
import com.app.model.User;
import com.app.service.AuthenticationService;
import com.app.service.CourseService;

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

public class MainController implements Initializable {

    @FXML
    private Label userLabel; // Renamed from usernameLabel to match FXML
    @FXML
    private VBox courseListContainer;
    @FXML
    private StackPane contentArea;
    @FXML
    private SplitPane mainSplitPane;

    private final CourseService courseService = new CourseService();

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        User user = AuthenticationService.getCurrentUser();
        // Fixed: Null check for userLabel
        if (user != null && userLabel != null) {
            userLabel.setText("Utilisateur: " + user.getUsername());
        }

        loadCourses();

        // Load Course Browser by default if courses exist
        // or a welcome screen
    }

    private void loadCourses() {
        // Fixed: Check if container exists before trying to add children
        if (courseListContainer == null) {
            // System.out.println("Warning: courseListContainer is null, skipping dynamic
            // course loading.");
            return;
        }

        List<Course> courses = courseService.getAllCourses();
        ToggleGroup courseGroup = new ToggleGroup();

        for (Course course : courses) {
            ToggleButton btn = new ToggleButton(course.getTitle());
            btn.setToggleGroup(courseGroup);
            btn.setMaxWidth(Double.MAX_VALUE);
            btn.getStyleClass().add("course-button");

            btn.setOnAction(e -> {
                if (btn.isSelected()) {
                    loadCourseContent(course.getId());
                }
            });
            courseListContainer.getChildren().add(btn);
        }
    }

    private void loadCourseContent(int courseId) {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/course_browser.fxml"));
            StackPane courseView = loader.load();

            CourseBrowserController controller = loader.getController();
            controller.loadCourse(courseId);

            contentArea.getChildren().clear();
            contentArea.getChildren().add(courseView);
        } catch (IOException e) {
            e.printStackTrace();
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
        // Placeholder for Multiplayer Room
        showError("Fonctionnalité 'Salle Multijoueur' en cours de développement !");
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
