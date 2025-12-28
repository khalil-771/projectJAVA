package com.app.controller;

import com.app.model.LevelCalculator;
import com.app.model.UserBadge;
import com.app.model.UserStats;
import com.app.service.AuthenticationService;
import com.app.service.BadgeService;
import com.app.service.StatsService;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressBar;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.VBox;

import java.util.List;

public class DashboardController {

    @FXML
    private Label welcomeLabel;
    @FXML
    private Label levelLabel;
    @FXML
    private Label pointsLabel;
    @FXML
    private Label streakLabel;
    @FXML
    private Label accuracyLabel;
    @FXML
    private Label quizzesLabel; // Renamed from quizCountLabel to match FXML
    @FXML
    private ProgressBar levelProgressBar;
    @FXML
    private Label xpLabel; // Added missing reference for XP label
    @FXML
    private FlowPane badgesContainer; // Renamed from badgesPane to match FXML
    @FXML
    private VBox statsContainer;

    private final StatsService statsService = new StatsService();
    private final BadgeService badgeService = new BadgeService();

    @FXML
    public void initialize() {
        // Add basic null check safety
        try {
            if (welcomeLabel != null)
                loadUserStats();
            if (badgesContainer != null)
                loadUserBadges();
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error initializing dashboard: " + e.getMessage());
        }
    }

    private void loadUserStats() {
        int userId = AuthenticationService.getCurrentUser().getId();
        String username = AuthenticationService.getCurrentUser().getUsername();

        UserStats stats = statsService.getUserStats(userId);
        if (stats == null) {
            welcomeLabel.setText("Welcome, " + username + "!");
            return;
        }

        // Welcome message with level title
        String levelTitle = LevelCalculator.getLevelTitle(stats.getCurrentLevel());
        welcomeLabel.setText("Welcome back, " + username + " the " + levelTitle + "!");
        welcomeLabel.setStyle("-fx-font-size: 24px; -fx-font-weight: bold; -fx-text-fill: #333;");

        // Level info
        levelLabel.setText("Level " + stats.getCurrentLevel());
        levelLabel.setStyle("-fx-font-size: 36px; -fx-font-weight: bold; -fx-text-fill: #4CAF50;");

        // Points
        pointsLabel.setText(stats.getTotalPoints() + " XP");
        pointsLabel.setStyle("-fx-font-size: 20px; -fx-text-fill: #2196F3;");

        // Streak
        String streakEmoji = stats.getCurrentStreak() >= 7 ? "🔥" : "⭐";
        streakLabel.setText(streakEmoji + " " + stats.getCurrentStreak() + " day streak");
        streakLabel.setStyle("-fx-font-size: 16px;");

        // Accuracy
        accuracyLabel.setText(String.format("%.1f%% Accuracy", stats.getAccuracyRate()));
        accuracyLabel.setStyle("-fx-font-size: 16px;");

        // Quiz count
        if (quizzesLabel != null) {
            quizzesLabel.setText(stats.getTotalQuizzesPlayed() + " Quizzes Completed");
            quizzesLabel.setStyle("-fx-font-size: 16px;");
        }

        // Level progress bar
        if (levelProgressBar != null) {
            // UserStats now has getLevelProgress thanks to LevelCalculator import fix
            double progress = stats.getLevelProgress() / 100.0;
            levelProgressBar.setProgress(progress);
            levelProgressBar.setStyle("-fx-accent: #4CAF50;");
        }

        // XP Label
        if (xpLabel != null) {
            int currentXP = stats.getExperiencePoints();
            int currentLevel = stats.getCurrentLevel();

            int currentLevelBaseXP = LevelCalculator.getPointsForLevel(currentLevel);
            int nextLevelBaseXP = LevelCalculator.getPointsForLevel(currentLevel + 1);

            int xpInLevel = currentXP - currentLevelBaseXP;
            int xpNeededForLevel = nextLevelBaseXP - currentLevelBaseXP;

            // Safety check for negative values due to formula changes
            if (xpInLevel < 0)
                xpInLevel = 0;
            if (xpNeededForLevel <= 0)
                xpNeededForLevel = 100;

            xpLabel.setText(xpInLevel + " / " + xpNeededForLevel + " XP");
        }
    }

    private void loadUserBadges() {
        if (badgesContainer == null)
            return;

        int userId = AuthenticationService.getCurrentUser().getId();
        List<UserBadge> userBadges = badgeService.getUserBadges(userId);

        badgesContainer.getChildren().clear();

        if (userBadges.isEmpty()) {
            Label noBadges = new Label("No badges yet. Complete quizzes to earn badges!");
            noBadges.setStyle("-fx-text-fill: #999; -fx-font-style: italic;");
            badgesContainer.getChildren().add(noBadges);
            return;
        }

        // Show latest 6 badges
        int count = Math.min(6, userBadges.size());
        for (int i = 0; i < count; i++) {
            UserBadge userBadge = userBadges.get(i);
            VBox badgeCard = createBadgeCard(userBadge);
            badgesContainer.getChildren().add(badgeCard);
        }

        if (userBadges.size() > 6) {
            Label moreLabel = new Label("+" + (userBadges.size() - 6) + " more...");
            moreLabel.setStyle("-fx-text-fill: #666; -fx-font-size: 12px; -fx-padding: 10;");
            badgesContainer.getChildren().add(moreLabel);
        }
    }

    private VBox createBadgeCard(UserBadge userBadge) {
        VBox card = new VBox(5);
        card.setStyle("-fx-background-color: #FFF3E0; -fx-padding: 10; -fx-border-color: #FFB74D; " +
                "-fx-border-width: 2; -fx-border-radius: 5; -fx-background-radius: 5; " +
                "-fx-min-width: 100; -fx-max-width: 100; -fx-alignment: center;");

        Label icon = new Label("🏆");
        icon.setStyle("-fx-font-size: 32px;");

        Label name = new Label(userBadge.getBadge().getName());
        name.setStyle("-fx-font-size: 11px; -fx-font-weight: bold; -fx-text-alignment: center; -fx-wrap-text: true;");
        name.setMaxWidth(90);

        card.getChildren().addAll(icon, name);
        return card;
    }
}
