package com.app.controller;

import com.app.model.Badge;
import com.app.model.Question;
import com.app.service.AdminQuestionService;
import com.app.service.BadgeService;
import javafx.beans.property.SimpleStringProperty;
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
    private TableColumn<Question, String> questionIdCol;
    @FXML
    private TableColumn<Question, String> questionTextCol;
    @FXML
    private TableColumn<Question, String> questionLangCol;
    @FXML
    private TableColumn<Question, String> questionDiffCol;
    @FXML
    private TableView<Badge> badgesTable;
    @FXML
    private TableColumn<Badge, String> badgeNameCol;
    @FXML
    private TableColumn<Badge, String> badgeDescCol;
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

    private final AdminQuestionService questionService = new AdminQuestionService();
    private final BadgeService badgeService = new BadgeService();

    @FXML
    public void initialize() {
        setupLanguageCombo();
        setupDifficultyCombo();
        setupTableColumns();

        // Defer data loading until AFTER the page is displayed
        // This allows the page to appear instantly
        javafx.application.Platform.runLater(() -> {
            loadBadges();
            loadQuestions();
        });
    }

    private void setupLanguageCombo() {
        languageCombo.setItems(FXCollections.observableArrayList(
                "html", "css", "javascript", "java", "python", "cpp", "c", "sql",
                "kotlin", "php", "csharp", "ruby", "swift", "go"));
        languageCombo.setValue("html");
    }

    private void setupDifficultyCombo() {
        difficultyCombo.setItems(FXCollections.observableArrayList(
                "DÉBUTANT", "INTERMÉDIAIRE", "AVANCÉ"));
        difficultyCombo.setValue("DÉBUTANT");
    }

    private void setupTableColumns() {
        // Setup question table columns if they exist
        if (questionIdCol != null) {
            questionIdCol.setCellValueFactory(
                    cellData -> new SimpleStringProperty(String.valueOf(cellData.getValue().getId())));
        }
        if (questionTextCol != null) {
            questionTextCol
                    .setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue().getQuestionText()));
        }
        if (questionLangCol != null) {
            questionLangCol
                    .setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue().getLanguageTag()));
        }
        if (questionDiffCol != null) {
            questionDiffCol
                    .setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue().getDifficulty()));
        }

        // Setup badge table columns if they exist
        if (badgeNameCol != null) {
            badgeNameCol.setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue().getName()));
        }
        if (badgeDescCol != null) {
            badgeDescCol
                    .setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue().getDescription()));
        }
    }

    private void loadBadges() {
        // Load badges asynchronously
        javafx.concurrent.Task<List<Badge>> loadTask = new javafx.concurrent.Task<>() {
            @Override
            protected List<Badge> call() throws Exception {
                return badgeService.getAllBadges();
            }
        };

        loadTask.setOnSucceeded(event -> {
            List<Badge> badges = loadTask.getValue();
            if (badgesTable != null) {
                badgesTable.setItems(FXCollections.observableArrayList(badges));
            }
        });

        loadTask.setOnFailed(event -> {
            Throwable ex = loadTask.getException();
            ex.printStackTrace();
            showStatus("Erreur de chargement des badges: " + ex.getMessage(), false);
        });

        new Thread(loadTask).start();
    }

    private void loadQuestions() {
        // Show loading indicator immediately
        if (questionsTable != null) {
            questionsTable.setPlaceholder(new javafx.scene.control.ProgressIndicator());
        }
        showStatus("Chargement des questions...", true);

        // Load questions asynchronously
        javafx.concurrent.Task<List<Question>> loadTask = new javafx.concurrent.Task<>() {
            @Override
            protected List<Question> call() throws Exception {
                return questionService.getAllQuestions();
            }
        };

        loadTask.setOnSucceeded(event -> {
            List<Question> questions = loadTask.getValue();
            if (questionsTable != null) {
                questionsTable.setItems(FXCollections.observableArrayList(questions));
                questionsTable.setPlaceholder(new Label("Aucune question disponible"));
            }
            showStatus("Chargé " + questions.size() + " questions", true);
        });

        loadTask.setOnFailed(event -> {
            Throwable ex = loadTask.getException();
            ex.printStackTrace();
            if (questionsTable != null) {
                questionsTable.setPlaceholder(new Label("Erreur de chargement"));
            }
            showStatus("Erreur: " + ex.getMessage(), false);
        });

        // Run in background thread
        new Thread(loadTask).start();
    }

    @FXML
    private void addQuestion() {
        String questionText = questionTextArea.getText();
        String language = languageCombo.getValue();
        String difficultySelection = difficultyCombo.getValue();
        // Map French difficulty to English for DB
        String difficulty = "BEGINNER";
        if ("INTERMÉDIAIRE".equals(difficultySelection))
            difficulty = "INTERMEDIATE";
        if ("AVANCÉ".equals(difficultySelection))
            difficulty = "ADVANCED";

        String pointsStr = pointsField.getText();

        if (questionText == null || questionText.trim().isEmpty()) {
            showStatus("Veuillez entrer le texte de la question", false);
            return;
        }

        try {
            int points = Integer.parseInt(pointsStr);

            // Create question object
            Question question = new Question();
            question.setQuizId(1); // Default quiz ID
            question.setQuestionText(questionText);
            question.setType(Question.QuestionType.MULTIPLE_CHOICE);
            question.setExplanation(""); // Can be extended later
            question.setDifficulty(difficulty);
            question.setLanguageTag(language);
            question.setPoints(points);

            // For now, create with empty answers - can be extended with answer inputs
            boolean success = questionService.createQuestion(question, java.util.Collections.emptyList());

            if (success) {
                showStatus("Question ajoutée avec succès !", true);
                questionTextArea.clear();
                loadQuestions(); // Refresh table
            } else {
                showStatus("Échec de l'ajout de la question", false);
            }
        } catch (NumberFormatException e) {
            showStatus("Valeur de points invalide", false);
        } catch (Exception e) {
            e.printStackTrace();
            showStatus("Error: " + e.getMessage(), false);
        }
    }

    @FXML
    private void deleteQuestion() {
        Question selected = questionsTable.getSelectionModel().getSelectedItem();
        if (selected == null) {
            showStatus("Veuillez sélectionner une question à supprimer", false);
            return;
        }

        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("Confirmer la suppression");
        alert.setHeaderText("Supprimer cette question ?");
        alert.setContentText("ID: " + selected.getId());

        alert.showAndWait().ifPresent(response -> {
            if (response == ButtonType.OK) {
                boolean success = questionService.deleteQuestion(selected.getId());
                if (success) {
                    showStatus("Question supprimée avec succès !", true);
                    loadQuestions(); // Refresh table
                } else {
                    showStatus("Échec de la suppression de la question", false);
                }
            }
        });
    }

    @FXML
    private void refreshData() {
        loadBadges();
        loadQuestions();
        showStatus("Données actualisées", true);
    }

    private void showStatus(String message, boolean success) {
        if (statusLabel != null) {
            statusLabel.setText(message);
            statusLabel.setStyle(success ? "-fx-text-fill: green; -fx-font-weight: bold;"
                    : "-fx-text-fill: red; -fx-font-weight: bold;");
        }
    }
}
