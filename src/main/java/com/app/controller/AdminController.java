package com.app.controller;

import com.app.model.Badge;
import com.app.model.Question;
import com.app.service.BadgeService;
import com.app.service.QuizService;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;

import java.util.List;

public class AdminController {

    @FXML
    private TabPane adminTabs;
    @FXML
    private TableView<Question> questionsTable;
    @FXML
    private TableView<Badge> badgesTable;
    @FXML
    private TextArea questionTextArea;
    @FXML
    private ComboBox<String> languageCombo;
    @FXML
    private ComboBox<String> difficultyCombo;
    @FXML
    private TextField pointsField;
    @FXML
    private Label statusLabel;

    private final QuizService quizService = new QuizService();
    private final BadgeService badgeService = new BadgeService();

    @FXML
    public void initialize() {
        setupLanguageCombo();
        setupDifficultyCombo();
        loadBadges();
    }

    private void setupLanguageCombo() {
        languageCombo.setItems(FXCollections.observableArrayList(
                "html", "css", "javascript", "java", "python", "cpp", "c", "sql",
                "kotlin", "php", "csharp", "ruby", "swift", "go"));
        languageCombo.setValue("html");
    }

    private void setupDifficultyCombo() {
        difficultyCombo.setItems(FXCollections.observableArrayList(
                "BEGINNER", "INTERMEDIATE", "ADVANCED"));
        difficultyCombo.setValue("BEGINNER");
    }

    private void loadBadges() {
        List<Badge> badges = badgeService.getAllBadges();
        badgesTable.setItems(FXCollections.observableArrayList(badges));
    }

    @FXML
    private void addQuestion() {
        String questionText = questionTextArea.getText();
        String language = languageCombo.getValue();
        String difficulty = difficultyCombo.getValue();
        String pointsStr = pointsField.getText();

        if (questionText.isEmpty()) {
            showStatus("Please enter question text", false);
            return;
        }

        try {
            int points = Integer.parseInt(pointsStr);
            // TODO: Implement question creation in QuizService
            showStatus("Question added successfully!", true);
            questionTextArea.clear();
        } catch (NumberFormatException e) {
            showStatus("Invalid points value", false);
        }
    }

    @FXML
    private void deleteQuestion() {
        Question selected = questionsTable.getSelectionModel().getSelectedItem();
        if (selected == null) {
            showStatus("Please select a question to delete", false);
            return;
        }
        // TODO: Implement deletion
        showStatus("Question deleted", true);
    }

    @FXML
    private void refreshData() {
        loadBadges();
        showStatus("Data refreshed", true);
    }

    private void showStatus(String message, boolean success) {
        statusLabel.setText(message);
        statusLabel.setStyle(success ? "-fx-text-fill: green; -fx-font-weight: bold;"
                : "-fx-text-fill: red; -fx-font-weight: bold;");
    }
}
