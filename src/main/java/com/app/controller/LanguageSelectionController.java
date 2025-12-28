package com.app.controller;

import java.io.IOException;
import java.util.List;

import com.app.App;
import com.app.model.Course;
import com.app.model.ProgrammingLanguage;
import com.app.model.Quiz;
import com.app.service.CourseService;
import com.app.service.QuizService;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

public class LanguageSelectionController {

    @FXML
    private ListView<ProgrammingLanguage> languageList;
    @FXML
    private ComboBox<String> difficultyCombo;
    @FXML
    private Label selectedLabel;
    @FXML
    private Button startButton;

    private ProgrammingLanguage selectedLanguage;
    private String selectedDifficulty = "DÉBUTANT"; // Default value
    private Stage stage;
    private Runnable onLanguageSelected;
    private StackPane contentArea;
    private final CourseService courseService = new CourseService();
    private final QuizService quizService = new QuizService();

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
                selectedLabel.setText("Sélectionné : " + newVal.toString());
                startButton.setDisable(false);
            }
        });

        // Select first by default
        languageList.getSelectionModel().selectFirst();

        // Setup difficulty combo
        if (difficultyCombo != null) {
            difficultyCombo.setItems(FXCollections.observableArrayList("DÉBUTANT", "INTERMÉDIAIRE", "AVANCÉ"));
            difficultyCombo.setValue("DÉBUTANT");
            selectedDifficulty = "DÉBUTANT";
            difficultyCombo.valueProperty().addListener((obs, oldVal, newVal) -> {
                selectedDifficulty = newVal;
            });
        }
    }

    @FXML
    public void startQuiz() {
        if (selectedLanguage != null) {
            try {
                // Find course for the language
                List<Course> courses = courseService.getAllCourses();
                Course selectedCourse = null;
                for (Course course : courses) {
                    if (course.getLanguageTag().equals(selectedLanguage.getTag())) {
                        selectedCourse = course;
                        break;
                    }
                }

                if (selectedCourse == null) {
                    showError("Aucun cours trouvé pour : " + selectedLanguage.getDisplayName());
                    return;
                }

                // Get quizzes for the course
                List<Quiz> quizzes = quizService.getQuizzesForCourse(selectedCourse.getId());

                if (quizzes.isEmpty()) {
                    showError("Aucun quiz disponible pour " + selectedLanguage.getDisplayName());
                    return;
                }

                // Select quiz based on difficulty
                Quiz selectedQuiz = null;
                // We search for the French keyword in the Title (e.g. " - Débutant")
                String searchKeyword = selectedDifficulty.toLowerCase();

                for (Quiz quiz : quizzes) {
                    if (quiz.getTitle().toLowerCase().contains(searchKeyword)) {
                        selectedQuiz = quiz;
                        break;
                    }
                }

                if (selectedQuiz == null) {
                    // Fallback to first quiz
                    selectedQuiz = quizzes.get(0);
                }

                // Load the selected quiz

                // Load quiz view
                FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/quiz_view.fxml"));
                BorderPane quizView = loader.load();

                com.app.controller.QuizController controller = loader.getController();
                controller.setContentArea(contentArea);
                controller.loadQuiz(selectedQuiz.getId());

                // Set the selected difficulty for Question filtering (needs English Enum)
                String englishDifficulty = getDifficultyKeyword(selectedDifficulty);
                controller.setInitialDifficulty(englishDifficulty);

                if (contentArea != null) {
                    contentArea.getChildren().clear();
                    contentArea.getChildren().add(quizView);
                }

            } catch (IOException e) {
                e.printStackTrace();
                showError("Erreur de chargement du quiz : " + e.getMessage());
            }

            if (onLanguageSelected != null) {
                onLanguageSelected.run();
            }
            if (stage != null) {
                stage.close();
            }
        }
    }

    private String getDifficultyKeyword(String frenchDiff) {
        if (frenchDiff == null)
            return "";
        switch (frenchDiff) {
            case "DÉBUTANT":
                return "Beginner";
            case "INTERMÉDIAIRE":
                return "Intermediate";
            case "AVANCÉ":
                return "Advanced";
            default:
                return frenchDiff;
        }
    }

    @FXML
    public void cancel() {
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

    public void setContentArea(StackPane contentArea) {
        this.contentArea = contentArea;
    }

    private void showError(String message) {
        javafx.scene.control.Alert alert = new javafx.scene.control.Alert(javafx.scene.control.Alert.AlertType.ERROR);
        alert.setTitle("Erreur");
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }
}
