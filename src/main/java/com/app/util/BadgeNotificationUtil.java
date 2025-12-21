package com.app.util;

import com.app.controller.BadgeNotificationController;
import com.app.model.Badge;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.io.IOException;

/**
 * Utility to show badge notification popups
 */
public class BadgeNotificationUtil {

    public static void showBadgeNotification(Badge badge, Stage ownerStage) {
        try {
            FXMLLoader loader = new FXMLLoader(
                    BadgeNotificationUtil.class.getResource("/view/badge_notification.fxml"));
            VBox root = loader.load();

            BadgeNotificationController controller = loader.getController();

            Stage popupStage = new Stage();
            popupStage.initStyle(StageStyle.TRANSPARENT);
            popupStage.initModality(Modality.NONE);
            popupStage.initOwner(ownerStage);

            Scene scene = new Scene(root);
            scene.setFill(javafx.scene.paint.Color.TRANSPARENT);
            popupStage.setScene(scene);

            controller.setStage(popupStage);
            controller.setBadge(badge);

            // Position at top center
            if (ownerStage != null) {
                popupStage.setX(ownerStage.getX() + (ownerStage.getWidth() - 350) / 2);
                popupStage.setY(ownerStage.getY() + 50);
            }

            popupStage.show();

        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Failed to show badge notification: " + e.getMessage());
        }
    }
}
