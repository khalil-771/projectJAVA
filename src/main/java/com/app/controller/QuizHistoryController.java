package com.app.controller;

import com.app.model.QuizHistory;
import com.app.service.AuthenticationService;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller for quiz history view
 */
public class QuizHistoryController {

    @FXML
    private TableView<QuizHistory> historyTable;
    @FXML
    private Label totalQuizzesLabel;
    @FXML
    private Label averageScoreLabel;
    @FXML
    private Label bestScoreLabel;
    @FXML
    private ComboBox<String> filterCombo;

    @FXML
    public void initialize() {
        setupTable();
        setupFilter();
        loadHistory();
    }

    private void setupTable() {
        TableColumn<QuizHistory, String> dateCol = new TableColumn<>("Date");
        dateCol.setCellValueFactory(new PropertyValueFactory<>("completedAt"));
        dateCol.setPrefWidth(150);

        TableColumn<QuizHistory, String> quizCol = new TableColumn<>("Quiz");
        quizCol.setCellValueFactory(new PropertyValueFactory<>("quizTitle"));
        quizCol.setPrefWidth(200);

        TableColumn<QuizHistory, String> langCol = new TableColumn<>("Language");
        langCol.setCellValueFactory(new PropertyValueFactory<>("languageTag"));
        langCol.setPrefWidth(100);

        TableColumn<QuizHistory, Integer> scoreCol = new TableColumn<>("Score");
        scoreCol.setCellValueFactory(new PropertyValueFactory<>("score"));
        scoreCol.setPrefWidth(80);

        TableColumn<QuizHistory, String> gradeCol = new TableColumn<>("Grade");
        gradeCol.setCellValueFactory(new PropertyValueFactory<>("grade"));
        gradeCol.setPrefWidth(70);

        TableColumn<QuizHistory, Integer> pointsCol = new TableColumn<>("XP");
        pointsCol.setCellValueFactory(new PropertyValueFactory<>("pointsEarned"));
        pointsCol.setPrefWidth(80);

        TableColumn<QuizHistory, String> timeCol = new TableColumn<>("Time");
        timeCol.setCellValueFactory(new PropertyValueFactory<>("formattedTime"));
        timeCol.setPrefWidth(80);

        historyTable.getColumns().addAll(dateCol, quizCol, langCol, scoreCol, gradeCol, pointsCol, timeCol);
    }

    private void setupFilter() {
        filterCombo.setItems(FXCollections.observableArrayList(
                "All Quizzes", "Last 7 Days", "Last 30 Days", "This Month"));
        filterCombo.setValue("All Quizzes");
        filterCombo.setOnAction(e -> loadHistory());
    }

    private void loadHistory() {
        // TODO: Load from database
        List<QuizHistory> history = new ArrayList<>();

        // Mock data for demonstration
        historyTable.setItems(FXCollections.observableArrayList(history));

        updateStats(history);
    }

    private void updateStats(List<QuizHistory> history) {
        totalQuizzesLabel.setText(String.valueOf(history.size()));

        if (!history.isEmpty()) {
            double avgScore = history.stream()
                    .mapToInt(QuizHistory::getScore)
                    .average()
                    .orElse(0.0);
            averageScoreLabel.setText(String.format("%.1f%%", avgScore));

            int bestScore = history.stream()
                    .mapToInt(QuizHistory::getScore)
                    .max()
                    .orElse(0);
            bestScoreLabel.setText(bestScore + "%");
        } else {
            averageScoreLabel.setText("0%");
            bestScoreLabel.setText("0%");
        }
    }

    @FXML
    private void refreshHistory() {
        loadHistory();
    }
}
