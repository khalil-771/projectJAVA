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
    private final java.util.Map<String, String> languageMap = new java.util.HashMap<>();

    @FXML
    public void initialize() {
        setupTables();
        setupLanguageFilter();

        // Defer data loading until AFTER the page is displayed
        // This allows the page to appear instantly
        javafx.application.Platform.runLater(() -> {
            loadLeaderboards();
        });
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
        languageMap.put("All Languages", null);

        for (ProgrammingLanguage lang : ProgrammingLanguage.values()) {
            languages.add(lang.toString());
            languageMap.put(lang.toString(), lang.getTag());
        }

        languageFilter.setItems(languages);
        languageFilter.setValue("All Languages");

        languageFilter.setOnAction(e -> {
            String selected = languageFilter.getValue();
            if (selected != null) {
                selectedLanguage = languageMap.get(selected);
                loadLeaderboards();
            }
        });
    }

    // RE-WRITING THE WHOLE METHOD CORRECTLY BELOW

    private void loadLeaderboards() {
        loadDailyLeaderboard();
        loadWeeklyLeaderboard();
        loadGlobalLeaderboard();
        updateUserRank();
    }

    private void loadDailyLeaderboard() {
        // Show loading indicator
        dailyTable.setPlaceholder(new javafx.scene.control.ProgressIndicator());

        javafx.concurrent.Task<List<LeaderboardEntry>> loadTask = new javafx.concurrent.Task<>() {
            @Override
            protected List<LeaderboardEntry> call() throws Exception {
                return leaderboardService.getDailyLeaderboard(selectedLanguage);
            }
        };

        loadTask.setOnSucceeded(event -> {
            List<LeaderboardEntry> entries = loadTask.getValue();
            dailyTable.setItems(FXCollections.observableArrayList(entries));
            dailyTable.setPlaceholder(new Label("Aucune donnée disponible"));
        });

        loadTask.setOnFailed(event -> {
            dailyTable.setPlaceholder(new Label("Erreur de chargement"));
            event.getSource().getException().printStackTrace();
        });

        new Thread(loadTask).start();
    }

    private void loadWeeklyLeaderboard() {
        // Show loading indicator
        weeklyTable.setPlaceholder(new javafx.scene.control.ProgressIndicator());

        javafx.concurrent.Task<List<LeaderboardEntry>> loadTask = new javafx.concurrent.Task<>() {
            @Override
            protected List<LeaderboardEntry> call() throws Exception {
                return leaderboardService.getWeeklyLeaderboard(selectedLanguage);
            }
        };

        loadTask.setOnSucceeded(event -> {
            List<LeaderboardEntry> entries = loadTask.getValue();
            weeklyTable.setItems(FXCollections.observableArrayList(entries));
            weeklyTable.setPlaceholder(new Label("Aucune donnée disponible"));
        });

        loadTask.setOnFailed(event -> {
            weeklyTable.setPlaceholder(new Label("Erreur de chargement"));
            event.getSource().getException().printStackTrace();
        });

        new Thread(loadTask).start();
    }

    private void loadGlobalLeaderboard() {
        // Show loading indicator
        globalTable.setPlaceholder(new javafx.scene.control.ProgressIndicator());

        javafx.concurrent.Task<List<LeaderboardEntry>> loadTask = new javafx.concurrent.Task<>() {
            @Override
            protected List<LeaderboardEntry> call() throws Exception {
                return leaderboardService.getGlobalLeaderboard(selectedLanguage);
            }
        };

        loadTask.setOnSucceeded(event -> {
            List<LeaderboardEntry> entries = loadTask.getValue();
            globalTable.setItems(FXCollections.observableArrayList(entries));
            globalTable.setPlaceholder(new Label("Aucune donnée disponible"));
        });

        loadTask.setOnFailed(event -> {
            globalTable.setPlaceholder(new Label("Erreur de chargement"));
            event.getSource().getException().printStackTrace();
        });

        new Thread(loadTask).start();
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
            String langText = selectedLanguage != null ? " en " + selectedLanguage.toUpperCase() : "";
            userRankLabel.setText("#" + rank + langText);
            userRankLabel.setStyle("-fx-font-size: 16px; -fx-font-weight: bold; -fx-text-fill: #2196F3;");
        } else {
            userRankLabel.setText("Complétez des quiz pour être classé !");
            userRankLabel.setStyle("-fx-font-size: 14px; -fx-text-fill: #999;");
        }
    }

    @FXML
    private void refreshLeaderboards() {
        loadLeaderboards();
    }
}
