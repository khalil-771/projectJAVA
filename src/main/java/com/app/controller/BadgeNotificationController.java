package com.app.controller;

import com.app.model.Badge;
import javafx.animation.FadeTransition;
import javafx.animation.TranslateTransition;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.util.Duration;

public class BadgeNotificationController {

    @FXML
    private VBox notificationBox;
    @FXML
    private Label badgeNameLabel;
    @FXML
    private Label badgeDescLabel;
    @FXML
    private Label pointsLabel;
    @FXML
    private Label iconLabel;

    private Stage stage;

    public void setBadge(Badge badge) {
        iconLabel.setText("🏆");
        badgeNameLabel.setText(badge.getName());
        badgeDescLabel.setText(badge.getDescription());
        pointsLabel.setText("+" + badge.getPointsReward() + " XP");

        // Animate entrance
        animateEntrance();

        // Auto-close after 4 seconds
        javafx.animation.PauseTransition pause = new javafx.animation.PauseTransition(Duration.seconds(4));
        pause.setOnFinished(e -> closeNotification());
        pause.play();
    }

    private void animateEntrance() {
        // Slide down from top
        TranslateTransition slide = new TranslateTransition(Duration.millis(500), notificationBox);
        slide.setFromY(-200);
        slide.setToY(0);

        // Fade in
        FadeTransition fade = new FadeTransition(Duration.millis(500), notificationBox);
        fade.setFromValue(0.0);
        fade.setToValue(1.0);

        slide.play();
        fade.play();
    }

    @FXML
    private void closeNotification() {
        // Fade out
        FadeTransition fade = new FadeTransition(Duration.millis(300), notificationBox);
        fade.setFromValue(1.0);
        fade.setToValue(0.0);
        fade.setOnFinished(e -> {
            if (stage != null) {
                stage.close();
            }
        });
        fade.play();
    }

    public void setStage(Stage stage) {
        this.stage = stage;
    }
}
