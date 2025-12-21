package com.app.controller;

import com.app.model.ProgrammingLanguage;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.control.Label;
import javafx.stage.Stage;

public class LanguageSelectionController {

    @FXML
    private ListView<ProgrammingLanguage> languageList;
    @FXML
    private Label selectedLabel;
    @FXML
    private Button startButton;

    private ProgrammingLanguage selectedLanguage;
    private Stage stage;
    private Runnable onLanguageSelected;

    @FXML
    public void initialize() {
        // Populate language list
        languageList.setItems(FXCollections.observableArrayList(ProgrammingLanguage.values()));

        // Custom cell factory for better display
        languageList.setCellFactory(param -> new javafx.scene.control.ListCell<ProgrammingLanguage>() {
            @Override
            protected void updateItem(ProgrammingLanguage lang, boolean empty) {
                super.updateItem(lang, empty);
                if (empty || lang == null) {
                    setText(null);
                    setGraphic(null);
                } else {
                    setText(lang.toString());
                    setStyle("-fx-font-size: 14px; -fx-padding: 10;");
                }
            }
        });

        // Selection listener
        languageList.getSelectionModel().selectedItemProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) {
                selectedLanguage = newVal;
                selectedLabel.setText("Selected: " + newVal.toString());
                startButton.setDisable(false);
            }
        });

        // Select first by default
        languageList.getSelectionModel().selectFirst();
    }

    @FXML
    private void startQuiz() {
        if (selectedLanguage != null) {
            if (onLanguageSelected != null) {
                onLanguageSelected.run();
            }
            if (stage != null) {
                stage.close();
            }
        }
    }

    @FXML
    private void cancel() {
        if (stage != null) {
            stage.close();
        }
    }

    public ProgrammingLanguage getSelectedLanguage() {
        return selectedLanguage;
    }

    public void setStage(Stage stage) {
        this.stage = stage;
    }

    public void setOnLanguageSelected(Runnable callback) {
        this.onLanguageSelected = callback;
    }
}
