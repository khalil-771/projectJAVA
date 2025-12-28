package com.app.controller;

import com.app.model.Badge;
import com.app.model.LevelCalculator;
import com.app.model.UserBadge;
import com.app.model.UserStats;
import com.app.service.AuthenticationService;
import com.app.service.BadgeService;
import com.app.service.StatsService;
import javafx.fxml.FXML;
import javafx.geometry.Pos;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressBar;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.VBox;

import java.util.List;

public class ProfileController {

    @FXML
    private Label usernameLabel;
    @FXML
    private Label emailLabel;
    @FXML
    private Label levelLabel;
    @FXML
    private Label levelTitleLabel;
    @FXML
    private ProgressBar levelProgressBar;
    @FXML
    private Label experienceLabel;
    @FXML
    private Label totalPointsLabel;
    @FXML
    private Label streakLabel;
    @FXML
    private Label bestStreakLabel;
    @FXML
    private Label accuracyLabel;
    @FXML
    private Label quizzesLabel;
    @FXML
    private Label badgeCountLabel;
    @FXML
    private FlowPane allBadgesPane;

    private final StatsService statsService = new StatsService();
    private final BadgeService badgeService = new BadgeService();

    @FXML
    public void initialize() {
        try {
            loadProfile();
        } catch (Exception e) {
            System.err.println("Erreur lors du chargement du profil: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void loadProfile() {
        int userId = AuthenticationService.getCurrentUser().getId();
        String username = AuthenticationService.getCurrentUser().getUsername();

        // Set user info
        if (usernameLabel != null) {
            usernameLabel.setText(username != null ? username : "Utilisateur");
        }
        if (emailLabel != null) {
            String email = AuthenticationService.getCurrentUser().getEmail();
            emailLabel.setText(email != null ? email : "Aucun email");
        }

        // Load stats
        UserStats stats = statsService.getUserStats(userId);

        if (stats != null) {
            // Level and XP
            if (levelLabel != null) {
                levelLabel.setText(String.valueOf(stats.getCurrentLevel()));
            }
            if (levelTitleLabel != null) {
                levelTitleLabel.setText(LevelCalculator.getLevelTitle(stats.getCurrentLevel()));
            }

            if (experienceLabel != null && levelProgressBar != null) {
                int currentXP = stats.getExperiencePoints();
                int currentLevel = stats.getCurrentLevel();

                int currentLevelBaseXP = LevelCalculator.getPointsForLevel(currentLevel);
                int nextLevelBaseXP = LevelCalculator.getPointsForLevel(currentLevel + 1);

                int xpInLevel = currentXP - currentLevelBaseXP;
                int xpNeededForLevel = nextLevelBaseXP - currentLevelBaseXP;

                if (xpNeededForLevel <= 0)
                    xpNeededForLevel = 100;

                experienceLabel.setText(xpInLevel + " / " + xpNeededForLevel + " XP");
                levelProgressBar.setProgress((double) xpInLevel / xpNeededForLevel);
            }

            if (totalPointsLabel != null) {
                totalPointsLabel.setText(stats.getTotalPoints() + " XP");
            }

            // Streak
            if (streakLabel != null) {
                streakLabel.setText(stats.getCurrentStreak() + " jours");
            }
            if (bestStreakLabel != null) {
                bestStreakLabel.setText(stats.getBestStreak() + " jours");
            }

            // Accuracy
            if (accuracyLabel != null) {
                accuracyLabel.setText(String.format("%.1f%%", stats.getAccuracyRate()));
            }

            // Quizzes
            if (quizzesLabel != null) {
                quizzesLabel.setText(String.valueOf(stats.getTotalQuizzesPlayed()));
            }
        }

        // Load badges
        loadBadges(userId);
    }

    private void loadBadges(int userId) {
        if (allBadgesPane == null)
            return;

        allBadgesPane.getChildren().clear();

        List<Badge> allBadges = badgeService.getAllBadges();
        List<UserBadge> earnedBadges = badgeService.getUserBadges(userId);

        if (badgeCountLabel != null) {
            badgeCountLabel.setText(earnedBadges.size() + " badges gagnés");
        }

        if (allBadges.isEmpty()) {
            Label noBadges = new Label("Aucun badge disponible");
            noBadges.setStyle("-fx-text-fill: #999;");
            allBadgesPane.getChildren().add(noBadges);
            return;
        }

        for (Badge badge : allBadges) {
            boolean isEarned = earnedBadges.stream()
                    .anyMatch(b -> b.getBadgeId() == badge.getId());

            VBox badgeCard = createBadgeCard(badge, isEarned);
            allBadgesPane.getChildren().add(badgeCard);
        }
    }

    private VBox createBadgeCard(Badge badge, boolean isEarned) {
        VBox card = new VBox(10);
        card.setAlignment(Pos.CENTER);
        card.setStyle(
                "-fx-background-color: " + (isEarned ? "white" : "#f5f5f5") + ";" +
                        "-fx-padding: 15;" +
                        "-fx-background-radius: 10;" +
                        "-fx-border-color: " + (isEarned ? "#4CAF50" : "#ddd") + ";" +
                        "-fx-border-width: 2;" +
                        "-fx-border-radius: 10;" +
                        "-fx-min-width: 150;" +
                        "-fx-max-width: 150;" +
                        "-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.1), 5, 0, 0, 2);");

        // Icon
        Label icon = new Label(isEarned ? "🏆" : "🔒");
        icon.setStyle("-fx-font-size: 36px;");

        // Name
        Label name = new Label(badge.getName());
        name.setStyle(
                "-fx-font-size: 14px;" +
                        "-fx-font-weight: bold;" +
                        "-fx-text-fill: " + (isEarned ? "#333" : "#999") + ";" +
                        "-fx-wrap-text: true;" +
                        "-fx-text-alignment: center;");
        name.setMaxWidth(130);
        name.setWrapText(true);

        // Description
        Label desc = new Label(badge.getDescription());
        desc.setStyle(
                "-fx-font-size: 11px;" +
                        "-fx-text-fill: #666;" +
                        "-fx-wrap-text: true;" +
                        "-fx-text-alignment: center;");
        desc.setMaxWidth(130);
        desc.setWrapText(true);

        card.getChildren().addAll(icon, name, desc);
        return card;
    }
}
