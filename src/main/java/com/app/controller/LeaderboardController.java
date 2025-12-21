package com.app.controller;

import com.app.model.LeaderboardEntry;
import com.app.model.LeaderboardEntry.LeaderboardType;
import com.app.model.ProgrammingLanguage;
import com.app.service.AuthenticationService;
import com.app.service.LeaderboardService;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.HBox;

import java.util.List;

public class LeaderboardController {

    @FXML
    private TabPane leaderboardTabs;
    @FXML
    private TableView<LeaderboardEntry> dailyTable;
    @FXML
    private TableView<LeaderboardEntry> weeklyTable;
    @FXML
    private TableView<LeaderboardEntry> globalTable;
    @FXML
    private ComboBox<String> languageFilter;
    @FXML
    private Label userRankLabel;

    private final LeaderboardService leaderboardService = new LeaderboardService();
    private String selectedLanguage = null; // null = global

    @FXML
    public void initialize() {
        setupTables();
        setupLanguageFilter();
        loadLeaderboards();
    }

    private void setupTables() {
        setupTable(dailyTable);
        setupTable(weeklyTable);
        setupTable(globalTable);
    }

    private void setupTable(TableView<LeaderboardEntry> table) {
        // Rank column
        TableColumn<LeaderboardEntry, Integer> rankCol = new TableColumn<>("#");
        rankCol.setCellValueFactory(new PropertyValueFactory<>("rankPosition"));
        rankCol.setPrefWidth(50);
        rankCol.setStyle("-fx-alignment: CENTER;");

        // Username column
        TableColumn<LeaderboardEntry, String> usernameCol = new TableColumn<>("Player");
        usernameCol.setCellValueFactory(new PropertyValueFactory<>("username"));
        usernameCol.setPrefWidth(150);

        // Level column
        TableColumn<LeaderboardEntry, Integer> levelCol = new TableColumn<>("Level");
        levelCol.setCellValueFactory(new PropertyValueFactory<>("userLevel"));
        levelCol.setPrefWidth(70);
        levelCol.setStyle("-fx-alignment: CENTER;");

        // Score column
        TableColumn<LeaderboardEntry, Integer> scoreCol = new TableColumn<>("Score");
        scoreCol.setCellValueFactory(new PropertyValueFactory<>("score"));
        scoreCol.setPrefWidth(100);
        scoreCol.setStyle("-fx-alignment: CENTER;");

        // Badges column
        TableColumn<LeaderboardEntry, Integer> badgesCol = new TableColumn<>("Badges");
        badgesCol.setCellValueFactory(new PropertyValueFactory<>("badgeCount"));
        badgesCol.setPrefWidth(80);
        badgesCol.setStyle("-fx-alignment: CENTER;");

        table.getColumns().addAll(rankCol, usernameCol, levelCol, scoreCol, badgesCol);

        // Highlight current user's row
        table.setRowFactory(tv -> new TableRow<LeaderboardEntry>() {
            @Override
            protected void updateItem(LeaderboardEntry entry, boolean empty) {
                super.updateItem(entry, empty);
                if (empty || entry == null) {
                    setStyle("");
                } else if (entry.getUserId() == AuthenticationService.getCurrentUser().getId()) {
                    setStyle("-fx-background-color: #E3F2FD; -fx-font-weight: bold;");
                } else {
                    setStyle("");
                }
            }
        });
    }

    private void setupLanguageFilter() {
        ObservableList<String> languages = FXCollections.observableArrayList();
        languages.add("All Languages");

        for (ProgrammingLanguage lang : ProgrammingLanguage.values()) {
            languages.add(lang.toString());
        }

        languageFilter.setItems(languages);
        languageFilter.setValue("All Languages");

        languageFilter.setOnAction(e -> {
            String selected = languageFilter.getValue();
            if (selected.equals("All Languages")) {
                selectedLanguage = null;
            } else {
                // Extract tag from "emoji name" format
                for (ProgrammingLanguage lang : ProgrammingLanguage.values()) {
                    if (lang.toString().equals(selected)) {
                        selectedLanguage = lang.getTag();
                        break;
                    }
                }
            }
            loadLeaderboards();
        });
    }

    private void loadLeaderboards() {
        loadDailyLeaderboard();
        loadWeeklyLeaderboard();
        loadGlobalLeaderboard();
        updateUserRank();
    }

    private void loadDailyLeaderboard() {
        List<LeaderboardEntry> entries = leaderboardService.getDailyLeaderboard(selectedLanguage);
        dailyTable.setItems(FXCollections.observableArrayList(entries));
    }

    private void loadWeeklyLeaderboard() {
        List<LeaderboardEntry> entries = leaderboardService.getWeeklyLeaderboard(selectedLanguage);
        weeklyTable.setItems(FXCollections.observableArrayList(entries));
    }

    private void loadGlobalLeaderboard() {
        List<LeaderboardEntry> entries = leaderboardService.getGlobalLeaderboard(selectedLanguage);
        globalTable.setItems(FXCollections.observableArrayList(entries));
    }

    private void updateUserRank() {
        int userId = AuthenticationService.getCurrentUser().getId();

        // Get rank from currently selected tab
        LeaderboardType currentType = LeaderboardType.GLOBAL;
        Tab selectedTab = leaderboardTabs.getSelectionModel().getSelectedItem();
        if (selectedTab != null) {
            String tabText = selectedTab.getText();
            if (tabText.contains("Daily"))
                currentType = LeaderboardType.DAILY;
            else if (tabText.contains("Weekly"))
                currentType = LeaderboardType.WEEKLY;
        }

        int rank = leaderboardService.getUserRank(userId, currentType, selectedLanguage);

        if (rank > 0) {
            String langText = selectedLanguage != null ? " in " + selectedLanguage.toUpperCase() : "";
            userRankLabel.setText("Your Rank: #" + rank + langText);
            userRankLabel.setStyle("-fx-font-size: 16px; -fx-font-weight: bold; -fx-text-fill: #2196F3;");
        } else {
            userRankLabel.setText("Complete quizzes to get ranked!");
            userRankLabel.setStyle("-fx-font-size: 14px; -fx-text-fill: #999;");
        }
    }

    @FXML
    private void refreshLeaderboards() {
        loadLeaderboards();
    }
}
