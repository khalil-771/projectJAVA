package com.app.controller;

import com.app.App;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.layout.VBox;
import javafx.scene.layout.StackPane;
import java.io.IOException;

public class MultiplayerMenuController {

    private StackPane contentArea;

    public void setContentArea(StackPane contentArea) {
        this.contentArea = contentArea;
    }

    @FXML
    private void showCreateForm() {
        loadView("/view/multiplayer_create.fxml");
    }

    @FXML
    private void showJoinForm() {
        loadView("/view/multiplayer_join.fxml");
    }

    @FXML
    private void handleBack() {
        // Return to main dashboard or menu?
        // Usually back to whatever was there before.
        // For now, let's just clear.
        if (contentArea != null) {
            contentArea.getChildren().clear();
        }
    }

    private void loadView(String fxmlPath) {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource(fxmlPath));
            VBox view = loader.load();

            // Pass contentArea to the next controller
            Object controller = loader.getController();
            if (controller instanceof MultiplayerCreateController) {
                ((MultiplayerCreateController) controller).setContentArea(contentArea);
            } else if (controller instanceof MultiplayerJoinController) {
                ((MultiplayerJoinController) controller).setContentArea(contentArea);
            }

            contentArea.getChildren().clear();
            contentArea.getChildren().add(view);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
