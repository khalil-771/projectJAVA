package com.app.controller;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import com.app.App;
import com.app.model.Chapter;
import com.app.model.Course;
import com.app.model.Lesson;
import com.app.model.Quiz;
import com.app.service.CourseService;
import com.app.service.QuizService;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceDialog;
import javafx.scene.control.Label;
import javafx.scene.control.TreeCell;
import javafx.scene.control.TreeItem;
import javafx.scene.control.TreeView;
import javafx.scene.web.WebView;
import javafx.stage.Stage;

public class CourseBrowserController {

    @FXML
    private Label courseTitleLabel;
    @FXML
    private TreeView<Object> hierarchyTree;
    @FXML
    private WebView lessonWebView;
    @FXML
    private Button tryItButton;

    private final CourseService courseService = new CourseService();
    private Course currentCourse;
    private Lesson currentLesson;

    public void loadCourse(int courseId) {
        currentCourse = courseService.getCourseWithContent(courseId);
        if (currentCourse != null) {
            courseTitleLabel.setText(currentCourse.getTitle());
            buildTree();
        }
    }

    private void buildTree() {
        TreeItem<Object> root = new TreeItem<>(currentCourse);
        root.setExpanded(true);

        if (currentCourse != null) {
            for (Chapter chapter : currentCourse.getChapters()) {
                TreeItem<Object> chapterItem = new TreeItem<>(chapter);
                chapterItem.setExpanded(true);

                for (Lesson lesson : chapter.getLessons()) {
                    TreeItem<Object> lessonItem = new TreeItem<>(lesson);
                    chapterItem.getChildren().add(lessonItem);
                }
                root.getChildren().add(chapterItem);
            }
        }

        hierarchyTree.setRoot(root);
        hierarchyTree.setShowRoot(false);

        hierarchyTree.getSelectionModel().selectedItemProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null && newVal.getValue() instanceof Lesson) {
                displayLesson((Lesson) newVal.getValue());
            }
        });

        hierarchyTree.setCellFactory(p -> new TreeCell<>() {
            @Override
            protected void updateItem(Object item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null) {
                    setText(null);
                } else {
                    setText(item.toString());
                }
            }
        });
    }

    private void displayLesson(Lesson lesson) {
        this.currentLesson = lesson;
        String htmlContent = "<html><head><style>body { font-family: sans-serif; padding: 20px; }</style></head><body>"
                + "<h2>" + lesson.getTitle() + "</h2>"
                + (lesson.getContentHtml() != null ? lesson.getContentHtml() : "")
                + "</body></html>";

        lessonWebView.getEngine().loadContent(htmlContent);
    }

    @FXML
    public void openEditor() {
        if (currentLesson == null || currentLesson.getExampleCode() == null)
            return;

        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/code_editor.fxml"));
            Parent root = loader.load();

            CodeEditorController editor = loader.getController();
            editor.setInitialCode(currentLesson.getExampleCode());

            Stage stage = new Stage();
            stage.setTitle("Try It Editor - " + currentLesson.getTitle());
            stage.setScene(new Scene(root, 800, 600));
            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private final QuizService quizService = new QuizService();

    @FXML
    public void openQuiz() {
        if (currentCourse == null)
            return;

        List<Quiz> quizzes = quizService.getQuizzesForCourse(currentCourse.getId());
        if (quizzes.isEmpty()) {
            System.out.println("No quizzes for this course.");
            return;
        }

        // Create difficulty selection dialog
        ChoiceDialog<String> dialog = new ChoiceDialog<>("BEGINNER", "BEGINNER", "INTERMEDIATE", "ADVANCED");
        dialog.setTitle("Select Difficulty");
        dialog.setHeaderText("Choose quiz difficulty level");
        dialog.setContentText("Difficulty:");

        Optional<String> result = dialog.showAndWait();
        if (result.isPresent()) {
            String selectedDifficulty = result.get();

            // Map selected difficulty to keyword in quiz title
            String keyword = getDifficultyKeyword(selectedDifficulty);

            // Find quiz matching the difficulty
            Quiz selectedQuiz = null;
            for (Quiz quiz : quizzes) {
                if (quiz.getTitle().toLowerCase().contains(keyword.toLowerCase())) {
                    selectedQuiz = quiz;
                    break;
                }
            }

            if (selectedQuiz == null) {
                System.out.println("No quiz found for difficulty: " + selectedDifficulty);
                return;
            }

            try {
                FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/quiz_view.fxml"));
                Parent root = loader.load();

                QuizController controller = loader.getController();
                controller.loadQuiz(selectedQuiz.getId());

                Stage stage = new Stage();
                stage.setTitle("Quiz: " + selectedQuiz.getTitle());
                stage.setScene(new Scene(root, 600, 500));
                stage.show();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private String getDifficultyKeyword(String difficulty) {
        // Convert to title case: BEGINNER -> Beginner, INTERMEDIATE -> Intermediate, etc.
        if (difficulty == null || difficulty.isEmpty()) return difficulty;
        return difficulty.substring(0, 1).toUpperCase() + difficulty.substring(1).toLowerCase();
    }
}
