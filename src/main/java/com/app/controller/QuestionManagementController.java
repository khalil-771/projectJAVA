package com.app.controller;

import com.app.dao.QuestionDAO;
import com.app.dao.impl.QuestionDAOImpl;
import com.app.model.Answer;
import com.app.model.Question;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.control.*;
import javafx.scene.layout.HBox;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.ResourceBundle;
import java.util.stream.Collectors;

public class QuestionManagementController implements Initializable {

    @FXML
    private TableView<Question> questionTable;
    @FXML
    private TableColumn<Question, String> idCol;
    @FXML
    private TableColumn<Question, String> textCol;
    @FXML
    private TableColumn<Question, String> langCol;
    @FXML
    private TableColumn<Question, String> difficultyCol;
    @FXML
    private TableColumn<Question, String> typeCol;
    @FXML
    private TableColumn<Question, Void> actionsCol;

    @FXML
    private ComboBox<String> languageFilter;
    @FXML
    private ComboBox<String> difficultyFilter;
    @FXML
    private TextField searchField;

    private final QuestionDAO questionDAO = new QuestionDAOImpl();
    private ObservableList<Question> allQuestions = FXCollections.observableArrayList();
    private ObservableList<Question> filteredQuestions = FXCollections.observableArrayList();

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        setupTableColumns();
        setupFilters();

        // Defer data loading until AFTER the page is displayed
        javafx.application.Platform.runLater(() -> {
            loadQuestions();
        });
    }

    private void setupTableColumns() {
        // ID Column
        idCol.setCellValueFactory(cellData -> new SimpleStringProperty(String.valueOf(cellData.getValue().getId())));

        // Text Column
        textCol.setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue().getQuestionText()));

        // Language Column
        langCol.setCellValueFactory(cellData -> {
            String tag = cellData.getValue().getLanguageTag();
            return new SimpleStringProperty(tag != null ? tag.toUpperCase() : "N/A");
        });

        // Difficulty Column
        difficultyCol.setCellValueFactory(cellData -> new SimpleStringProperty(cellData.getValue().getDifficulty()));

        // Type Column
        typeCol.setCellValueFactory(cellData -> {
            var type = cellData.getValue().getType();
            return new SimpleStringProperty(type != null ? type.name() : "UNKNOWN");
        });

        // Actions Column with Edit and Delete buttons
        actionsCol.setCellFactory(param -> new TableCell<>() {
            private final Button editBtn = new Button("✏️");
            private final Button deleteBtn = new Button("🗑️");
            private final HBox pane = new HBox(5, editBtn, deleteBtn);

            {
                pane.setAlignment(Pos.CENTER);
                editBtn.setStyle("-fx-background-color: #2196F3; -fx-text-fill: white; -fx-cursor: hand;");
                deleteBtn.setStyle("-fx-background-color: #F44336; -fx-text-fill: white; -fx-cursor: hand;");

                editBtn.setOnAction(event -> {
                    Question question = getTableView().getItems().get(getIndex());
                    handleEditQuestion(question);
                });

                deleteBtn.setOnAction(event -> {
                    Question question = getTableView().getItems().get(getIndex());
                    handleDeleteQuestion(question);
                });
            }

            @Override
            protected void updateItem(Void item, boolean empty) {
                super.updateItem(item, empty);
                setGraphic(empty ? null : pane);
            }
        });
    }

    private void setupFilters() {
        // Language filter
        languageFilter.setItems(FXCollections.observableArrayList(
                "Tous", "HTML", "CSS", "JavaScript", "Java", "Python",
                "C++", "C", "SQL", "Kotlin", "PHP", "C#", "Ruby", "Swift", "Go"));
        languageFilter.setValue("Tous");

        // Difficulty filter
        difficultyFilter.setItems(FXCollections.observableArrayList(
                "Tous", "BEGINNER", "INTERMEDIATE", "ADVANCED"));
        difficultyFilter.setValue("Tous");
    }

    private void loadQuestions() {
        // Show loading indicator immediately
        questionTable.setPlaceholder(new ProgressIndicator());

        // Load questions asynchronously
        javafx.concurrent.Task<List<Question>> loadTask = new javafx.concurrent.Task<>() {
            @Override
            protected List<Question> call() throws Exception {
                return questionDAO.findAll();
            }
        };

        loadTask.setOnSucceeded(event -> {
            List<Question> questions = loadTask.getValue();
            allQuestions.setAll(questions);
            filteredQuestions.setAll(questions);
            questionTable.setItems(filteredQuestions);
            questionTable.setPlaceholder(new Label("Aucune question disponible"));
            System.out.println("✅ Loaded " + questions.size() + " questions");
        });

        loadTask.setOnFailed(event -> {
            Throwable ex = loadTask.getException();
            ex.printStackTrace();
            questionTable.setPlaceholder(new Label("Erreur de chargement"));
            showError("Erreur lors du chargement des questions: " + ex.getMessage());
        });

        new Thread(loadTask).start();
    }

    @FXML
    private void filterQuestions() {
        String langFilter = languageFilter.getValue();
        String diffFilter = difficultyFilter.getValue();
        String searchText = searchField.getText().toLowerCase().trim();

        List<Question> filtered = allQuestions.stream()
                .filter(q -> {
                    // Language filter
                    boolean langMatch = langFilter.equals("Tous") ||
                            q.getLanguageTag().equalsIgnoreCase(langFilter);

                    // Difficulty filter
                    boolean diffMatch = diffFilter.equals("Tous") ||
                            q.getDifficulty().equalsIgnoreCase(diffFilter);

                    // Search filter
                    boolean searchMatch = searchText.isEmpty() ||
                            q.getQuestionText().toLowerCase().contains(searchText);

                    return langMatch && diffMatch && searchMatch;
                })
                .collect(Collectors.toList());

        filteredQuestions.setAll(filtered);
    }

    @FXML
    private void handleAddQuestion() {
        QuestionDialog dialog = new QuestionDialog(null);
        Optional<QuestionFormData> result = dialog.showAndWait();

        result.ifPresent(data -> {
            try {
                // Create question object
                Question question = new Question();
                question.setQuizId(1); // Default quiz ID for admin-created questions
                question.setQuestionText(data.questionText);
                question.setType(Question.QuestionType.valueOf(data.type));
                question.setExplanation(data.explanation);
                question.setDifficulty(data.difficulty);
                question.setLanguageTag(data.language.toLowerCase());
                question.setPoints(data.points);
                question.setAnswers(data.answers);

                // Save to database
                int newId = questionDAO.save(question);

                if (newId > 0) {
                    showSuccess("Question ajoutée avec succès! (ID: " + newId + ")");
                    loadQuestions(); // Refresh table
                } else {
                    showError("Erreur lors de l'ajout de la question");
                }
            } catch (Exception e) {
                e.printStackTrace();
                showError("Erreur: " + e.getMessage());
            }
        });
    }

    private void handleEditQuestion(Question question) {
        QuestionDialog dialog = new QuestionDialog(question);
        Optional<QuestionFormData> result = dialog.showAndWait();

        result.ifPresent(data -> {
            try {
                // Update question object
                question.setQuestionText(data.questionText);
                question.setType(Question.QuestionType.valueOf(data.type));
                question.setExplanation(data.explanation);
                question.setDifficulty(data.difficulty);
                question.setLanguageTag(data.language.toLowerCase());
                question.setPoints(data.points);
                question.setAnswers(data.answers);

                // Update in database
                boolean success = questionDAO.update(question);

                if (success) {
                    showSuccess("Question mise à jour avec succès!");
                    loadQuestions(); // Refresh table
                } else {
                    showError("Erreur lors de la mise à jour de la question");
                }
            } catch (Exception e) {
                e.printStackTrace();
                showError("Erreur: " + e.getMessage());
            }
        });
    }

    private void handleDeleteQuestion(Question question) {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("Confirmer la suppression");
        alert.setHeaderText("Supprimer cette question?");
        alert.setContentText("Question: " + question.getQuestionText().substring(0,
                Math.min(50, question.getQuestionText().length())) + "...");

        Optional<ButtonType> result = alert.showAndWait();
        if (result.isPresent() && result.get() == ButtonType.OK) {
            try {
                boolean success = questionDAO.delete(question.getId());

                if (success) {
                    showSuccess("Question supprimée avec succès!");
                    loadQuestions(); // Refresh table
                } else {
                    showError("Erreur lors de la suppression de la question");
                }
            } catch (Exception e) {
                e.printStackTrace();
                showError("Erreur: " + e.getMessage());
            }
        }
    }

    private void showSuccess(String message) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle("Succès");
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    private void showError(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Erreur");
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    // Inner class to hold form data
    static class QuestionFormData {
        String questionText;
        String type;
        String explanation;
        String difficulty;
        String language;
        int points;
        List<Answer> answers;
    }

    // Dialog for adding/editing questions
    static class QuestionDialog extends Dialog<QuestionFormData> {
        private final TextField questionField = new TextField();
        private final ComboBox<String> typeCombo = new ComboBox<>();
        private final TextArea explanationArea = new TextArea();
        private final ComboBox<String> difficultyCombo = new ComboBox<>();
        private final ComboBox<String> languageCombo = new ComboBox<>();
        private final Spinner<Integer> pointsSpinner = new Spinner<>(1, 100, 10);

        // Answer fields
        private final TextField answer1 = new TextField();
        private final TextField answer2 = new TextField();
        private final TextField answer3 = new TextField();
        private final TextField answer4 = new TextField();
        private final CheckBox correct1 = new CheckBox("Correcte");
        private final CheckBox correct2 = new CheckBox("Correcte");
        private final CheckBox correct3 = new CheckBox("Correcte");
        private final CheckBox correct4 = new CheckBox("Correcte");

        public QuestionDialog(Question question) {
            setTitle(question == null ? "Ajouter une Question" : "Modifier la Question");
            setHeaderText(question == null ? "Remplissez les détails de la nouvelle question"
                    : "Modifiez les détails de la question");

            // Setup form
            setupForm(question);

            // Buttons
            getDialogPane().getButtonTypes().addAll(ButtonType.OK, ButtonType.CANCEL);

            // Result converter
            setResultConverter(buttonType -> {
                if (buttonType == ButtonType.OK) {
                    return getData();
                }
                return null;
            });
        }

        private void setupForm(Question question) {
            // Type combo - Only SINGLE_CHOICE and MULTIPLE_CHOICE
            typeCombo.setItems(FXCollections.observableArrayList(
                    "SINGLE_CHOICE", "MULTIPLE_CHOICE"));
            typeCombo.setValue("SINGLE_CHOICE");

            // Difficulty combo
            difficultyCombo.setItems(FXCollections.observableArrayList(
                    "BEGINNER", "INTERMEDIATE", "ADVANCED"));
            difficultyCombo.setValue("BEGINNER");

            // Language combo
            languageCombo.setItems(FXCollections.observableArrayList(
                    "html", "css", "javascript", "java", "python", "cpp", "c",
                    "sql", "kotlin", "php", "csharp", "ruby", "swift", "go"));
            languageCombo.setValue("html");

            // Populate if editing
            if (question != null) {
                questionField.setText(question.getQuestionText());
                typeCombo.setValue(question.getType().name());
                explanationArea.setText(question.getExplanation());
                difficultyCombo.setValue(question.getDifficulty());
                languageCombo.setValue(question.getLanguageTag());
                pointsSpinner.getValueFactory().setValue(question.getPoints());

                // Load answers
                List<Answer> answers = question.getAnswers();
                if (answers.size() > 0) {
                    answer1.setText(answers.get(0).getAnswerText());
                    correct1.setSelected(answers.get(0).isCorrect());
                }
                if (answers.size() > 1) {
                    answer2.setText(answers.get(1).getAnswerText());
                    correct2.setSelected(answers.get(1).isCorrect());
                }
                if (answers.size() > 2) {
                    answer3.setText(answers.get(2).getAnswerText());
                    correct3.setSelected(answers.get(2).isCorrect());
                }
                if (answers.size() > 3) {
                    answer4.setText(answers.get(3).getAnswerText());
                    correct4.setSelected(answers.get(3).isCorrect());
                }
            }

            explanationArea.setPrefRowCount(3);

            // Layout
            javafx.scene.layout.GridPane grid = new javafx.scene.layout.GridPane();
            grid.setHgap(10);
            grid.setVgap(10);
            grid.setPadding(new javafx.geometry.Insets(20, 150, 10, 10));

            int row = 0;
            grid.add(new Label("Question:"), 0, row);
            grid.add(questionField, 1, row++);

            grid.add(new Label("Type:"), 0, row);
            grid.add(typeCombo, 1, row++);

            grid.add(new Label("Explication:"), 0, row);
            grid.add(explanationArea, 1, row++);

            grid.add(new Label("Difficulté:"), 0, row);
            grid.add(difficultyCombo, 1, row++);

            grid.add(new Label("Langage:"), 0, row);
            grid.add(languageCombo, 1, row++);

            grid.add(new Label("Points:"), 0, row);
            grid.add(pointsSpinner, 1, row++);

            grid.add(new Label("─── Réponses ───"), 0, row++, 2, 1);

            grid.add(new Label("Réponse 1:"), 0, row);
            HBox h1 = new HBox(5, answer1, correct1);
            grid.add(h1, 1, row++);

            grid.add(new Label("Réponse 2:"), 0, row);
            HBox h2 = new HBox(5, answer2, correct2);
            grid.add(h2, 1, row++);

            grid.add(new Label("Réponse 3:"), 0, row);
            HBox h3 = new HBox(5, answer3, correct3);
            grid.add(h3, 1, row++);

            grid.add(new Label("Réponse 4:"), 0, row);
            HBox h4 = new HBox(5, answer4, correct4);
            grid.add(h4, 1, row++);

            getDialogPane().setContent(grid);
        }

        private QuestionFormData getData() {
            QuestionFormData data = new QuestionFormData();
            data.questionText = questionField.getText();
            data.type = typeCombo.getValue();
            data.explanation = explanationArea.getText();
            data.difficulty = difficultyCombo.getValue();
            data.language = languageCombo.getValue();
            data.points = pointsSpinner.getValue();

            // Build answers list
            data.answers = new ArrayList<>();
            if (!answer1.getText().isEmpty()) {
                Answer a = new Answer();
                a.setAnswerText(answer1.getText());
                a.setCorrect(correct1.isSelected());
                data.answers.add(a);
            }
            if (!answer2.getText().isEmpty()) {
                Answer a = new Answer();
                a.setAnswerText(answer2.getText());
                a.setCorrect(correct2.isSelected());
                data.answers.add(a);
            }
            if (!answer3.getText().isEmpty()) {
                Answer a = new Answer();
                a.setAnswerText(answer3.getText());
                a.setCorrect(correct3.isSelected());
                data.answers.add(a);
            }
            if (!answer4.getText().isEmpty()) {
                Answer a = new Answer();
                a.setAnswerText(answer4.getText());
                a.setCorrect(correct4.isSelected());
                data.answers.add(a);
            }

            return data;
        }
    }
}
