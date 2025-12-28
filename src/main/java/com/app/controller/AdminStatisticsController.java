package com.app.controller;

import com.app.dao.AdminDAO;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;

import java.net.URL;
import java.util.Map;
import java.util.ResourceBundle;

public class AdminStatisticsController implements Initializable {

    @FXML
    private Label totalUsersLabel;
    @FXML
    private Label totalQuizzesLabel;
    @FXML
    private Label avgScoreLabel;
    @FXML
    private Label totalRoomsLabel;
    @FXML
    private Label popularLangLabel;
    @FXML
    private Label totalQuestionsLabel;

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        // Defer loading to ensure UI renders first
        javafx.application.Platform.runLater(this::refreshStats);
    }

    @FXML
    public void refreshStats() {
        // Use a background task to fetch statistics
        javafx.concurrent.Task<Map<String, Object>> task = new javafx.concurrent.Task<>() {
            @Override
            protected Map<String, Object> call() throws Exception {
                return adminDAO.getGlobalStatistics();
            }
        };

        task.setOnSucceeded(e -> {
            Map<String, Object> stats = task.getValue();

            totalUsersLabel.setText(String.valueOf(stats.getOrDefault("totalUsers", 0)));
            totalQuizzesLabel.setText(String.valueOf(stats.getOrDefault("totalSoloQuizzes", 0)));

            double avg = (double) stats.getOrDefault("averageScore", 0.0);
            avgScoreLabel.setText(String.format("%.1f%%", avg));

            totalRoomsLabel.setText(String.valueOf(stats.getOrDefault("totalRooms", 0)));
            popularLangLabel.setText(String.valueOf(stats.getOrDefault("popularLanguage", "N/A")));
            totalQuestionsLabel.setText(String.valueOf(stats.getOrDefault("totalQuestions", 0)));
        });

        task.setOnFailed(e -> {
            Throwable ex = task.getException();
            System.err.println("❌ Failed to load admin stats: " + ex.getMessage());
            ex.printStackTrace();
        });

        new Thread(task).start();
    }
}
