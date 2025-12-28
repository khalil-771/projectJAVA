package com.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.app.App;
import com.app.dao.QuestionDAO;
import com.app.dao.impl.QuestionDAOImpl;
import com.app.model.Answer;
import com.app.model.Badge;
import com.app.model.Course;
import com.app.model.Question;
import com.app.model.Quiz;
import com.app.roomquiz.Room;
import com.app.roomquiz.RoomManager;
import com.app.service.AuthenticationService;
import com.app.service.BadgeService;
import com.app.service.CourseService;
import com.app.service.QuizService;
import com.app.service.StatsService;
import com.app.util.Spacer;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.animation.FadeTransition;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Color;
import javafx.util.Duration;

public class QuizController {

    @FXML
    private Label progressLabel;
    @FXML
    private Label timerLabel;
    @FXML
    private Label questionTextLabel;
    @FXML
    private VBox answersContainer;
    @FXML
    private Label feedbackLabel;
    @FXML
    private Button nextButton;
    @FXML
    private VBox multiplayerResultsBox;
    @FXML
    private Label winStatusLabel;
    @FXML
    private VBox multiplayerLeaderboard;

    private StackPane contentArea;
    private Room currentRoom;

    public void setContentArea(StackPane contentArea) {
        this.contentArea = contentArea;
    }

    public void setRoom(Room room) {
        this.currentRoom = room;
    }

    // Result views
    @FXML
    private VBox questionView;
    @FXML
    private VBox resultsView;
    @FXML
    private Label resultLabel;
    @FXML
    private Label pointsLabel;
    @FXML
    private VBox badgesContainer;

    private final QuizService quizService = new QuizService();
    private final StatsService statsService = new StatsService();
    private final BadgeService badgeService = new BadgeService();
    private final CourseService courseService = new CourseService();
    private final QuestionDAO questionDAO = new QuestionDAOImpl();

    private Quiz currentQuiz;
    private List<Question> filteredQuestions;
    private int currentQuestionIndex = 0;
    private Map<Integer, List<Integer>> userAnswers = new HashMap<>();
    private int totalTimeTaken = 0;
    private Timeline timer;
    private int timeSeconds = 30; // Default time per question
    private boolean isReviewMode = false;
    private int courseId;
    private String currentLanguage;
    private String currentDifficulty;

    public void loadQuiz(int quizId) {
        currentQuiz = quizService.getQuiz(quizId);
        if (currentQuiz == null)
            return;

        this.courseId = currentQuiz.getCourseId();

        // Get language from course
        Course course = courseService.getCourse(this.courseId);
        if (course != null) {
            this.currentLanguage = course.getLanguageTag();
        }

        // Initial setup - load random questions from database
        filterQuestions();
        startQuiz();
    }

    public void setInitialDifficulty(String difficulty) {
        // Map French UI terms to DB Enum consistency
        if (difficulty.equalsIgnoreCase("Débutant"))
            difficulty = "BEGINNER";
        else if (difficulty.equalsIgnoreCase("Intermédiaire"))
            difficulty = "INTERMEDIATE";
        else if (difficulty.equalsIgnoreCase("Avancé"))
            difficulty = "ADVANCED";

        this.currentDifficulty = difficulty.equals("All") ? null : difficulty.toUpperCase();
        reloadQuizByDifficulty(difficulty);
    }

    private void reloadQuizByDifficulty(String difficulty) {
        if (difficulty.equals("All")) {
            this.currentDifficulty = null;
        } else {
            this.currentDifficulty = difficulty.toUpperCase();
            List<Quiz> quizzes = quizService.getQuizzesForCourse(this.courseId);
            for (Quiz q : quizzes) {
                if (q.getTitle().toLowerCase().contains(difficulty.toLowerCase())) {
                    this.currentQuiz = quizService.getQuiz(q.getId());
                    break;
                }
            }
        }
        filterQuestions();
        startQuiz();
    }

    private void filterQuestions() {
        filteredQuestions = new ArrayList<>();

        // Load random questions from database filtered by language and difficulty
        List<Question> dbQuestions;

        // Check if "Tous les langages" is selected (means load ALL languages)
        if (currentLanguage != null && !currentLanguage.equalsIgnoreCase("tous les langages")) {
            // Load questions from database by specific language
            dbQuestions = questionDAO.findByLanguage(currentLanguage);

            // Filter by difficulty if specified
            if (currentDifficulty != null && !currentDifficulty.isEmpty()) {
                dbQuestions = dbQuestions.stream()
                        .filter(q -> currentDifficulty.equalsIgnoreCase(q.getDifficulty()))
                        .collect(java.util.stream.Collectors.toList());
            }
        } else if (currentLanguage != null && currentLanguage.equalsIgnoreCase("tous les langages")) {
            // Load ALL questions from database (all languages)
            dbQuestions = questionDAO.findAll();

            // Filter by difficulty if specified
            if (currentDifficulty != null && !currentDifficulty.isEmpty()) {
                dbQuestions = dbQuestions.stream()
                        .filter(q -> currentDifficulty.equalsIgnoreCase(q.getDifficulty()))
                        .collect(java.util.stream.Collectors.toList());
            }
        } else {
            // Fallback to quiz questions if no language specified
            dbQuestions = new ArrayList<>(currentQuiz.getQuestions());
        }

        // Shuffle for randomization
        java.util.Collections.shuffle(dbQuestions);

        // Take up to 20 questions
        int count = 0;
        for (Question q : dbQuestions) {
            filteredQuestions.add(q);
            count++;
            if (count >= 20)
                break;
        }

        if (filteredQuestions.isEmpty()) {
            questionTextLabel.setText("Aucune question trouvée pour ce niveau/langage.");
            answersContainer.getChildren().clear();
            nextButton.setDisable(true);
        }
    }

    public void startQuiz() {
        currentQuestionIndex = 0;
        userAnswers.clear();
        totalTimeTaken = 0;
        isReviewMode = false;

        questionView.setVisible(true);
        resultsView.setVisible(false);
        nextButton.setVisible(true);
        nextButton.setDisable(false);
        nextButton.setText("Question Suivante");

        // Hide multiplayer results if visible
        if (multiplayerResultsBox != null) {
            multiplayerResultsBox.setVisible(false);
            multiplayerResultsBox.setManaged(false);
        }

        showQuestion();
    }

    private void showQuestion() {
        if (currentQuestionIndex >= filteredQuestions.size()) {
            finishQuiz();
            return;
        }

        Question q = filteredQuestions.get(currentQuestionIndex);

        // Update UI
        progressLabel.setText("Question " + (currentQuestionIndex + 1) + "/" + filteredQuestions.size());
        questionTextLabel.setText(q.getQuestionText());
        feedbackLabel.setText("");

        answersContainer.getChildren().clear();

        // Logic to choose between RadioButton (Single) and CheckBox (Multi)
        if (q.getType() == com.app.model.Question.QuestionType.MULTIPLE_CHOICE) {
            // Multiple Choice: Use CheckBox
            for (Answer a : q.getAnswers()) {
                CheckBox cb = new CheckBox(a.getAnswerText());
                cb.setUserData(a.getId());
                cb.setStyle("-fx-font-size: 14px;");
                answersContainer.getChildren().add(cb);
            }
        } else {
            // Single Choice or True/False: Use RadioButton with ToggleGroup
            javafx.scene.control.ToggleGroup group = new javafx.scene.control.ToggleGroup();
            for (Answer a : q.getAnswers()) {
                javafx.scene.control.RadioButton rb = new javafx.scene.control.RadioButton(a.getAnswerText());
                rb.setUserData(a.getId());
                rb.setToggleGroup(group);
                rb.setStyle("-fx-font-size: 14px;");
                answersContainer.getChildren().add(rb);
            }
        }

        // Logic for "Next" vs "Finish" button text
        if (currentQuestionIndex == filteredQuestions.size() - 1) {
            nextButton.setText("Terminer le Quiz");
        } else {
            nextButton.setText("Question Suivante");
        }

        startTimer();
    }

    private void startTimer() {
        stopTimer();
        timeSeconds = 30; // reset
        timerLabel.setText("Temps : 00:" + timeSeconds);
        timerLabel.setTextFill(Color.web("#e91e63"));

        timer = new Timeline(new KeyFrame(Duration.seconds(1), e -> {
            timeSeconds--;
            timerLabel.setText(String.format("Temps : 00:%02d", timeSeconds));

            if (timeSeconds <= 10) {
                timerLabel.setTextFill(Color.RED);
            }

            if (timeSeconds <= 0) {
                stopTimer();
                handleTimeout();
            }
        }));
        timer.setCycleCount(Timeline.INDEFINITE);
        timer.play();
    }

    private void stopTimer() {
        if (timer != null) {
            timer.stop();
        }
    }

    private void handleTimeout() {
        feedbackLabel.setText("Temps écoulé ! Question suivante...");
        feedbackLabel.setTextFill(Color.RED);
        // Record as incorrect (empty list)
        Question currentQ = filteredQuestions.get(currentQuestionIndex);
        userAnswers.put(currentQ.getId(), new ArrayList<>());

        // Wait a moment then move on
        Timeline delay = new Timeline(new KeyFrame(Duration.seconds(1.5), e -> handleNext()));
        delay.play();
    }

    @FXML
    public void handleNext() {
        if (!isReviewMode && filteredQuestions != null && currentQuestionIndex < filteredQuestions.size()) {
            totalTimeTaken += (30 - timeSeconds);
        }
        stopTimer();

        // Save answer
        Question currentQ = filteredQuestions.get(currentQuestionIndex);
        List<Integer> selectedIds = new ArrayList<>();

        // Collect selected answers (works for both CheckBox and RadioButton)
        for (javafx.scene.Node node : answersContainer.getChildren()) {
            if (node instanceof CheckBox) {
                if (((CheckBox) node).isSelected())
                    selectedIds.add((Integer) node.getUserData());
            } else if (node instanceof javafx.scene.control.RadioButton) {
                if (((javafx.scene.control.RadioButton) node).isSelected())
                    selectedIds.add((Integer) node.getUserData());
            }
        }

        userAnswers.put(currentQ.getId(), selectedIds);

        currentQuestionIndex++;
        showQuestion();
    }

    private void finishQuiz() {
        stopTimer();
        questionView.setVisible(false);
        resultsView.setVisible(true);
        nextButton.setVisible(false);

        // Calculate
        // We need a dummy quiz object wrapping the filtered questions to use the
        // service calculation correctly?
        // Or just iterate manually logic which is safer given we have partial
        // questions.

        int correctCount = 0;
        for (Question q : filteredQuestions) {
            List<Integer> ans = userAnswers.get(q.getId());
            if (ans != null && q.isCorrect(ans)) {
                correctCount++;
            }
        }

        int totalQuestions = filteredQuestions.size();
        int score = (int) ((((double) correctCount) / totalQuestions) * 100);

        // Basic Points
        int pointsEarned = correctCount * 10;
        if (score == 100)
            pointsEarned += 50;

        // Save
        int userId = AuthenticationService.getCurrentUser().getId();

        // Retrieve language tag from course
        String languageTag = null;
        Course course = courseService.getCourse(this.courseId);
        if (course != null) {
            languageTag = course.getLanguageTag();
        }

        statsService.updateStatsAfterQuiz(userId, languageTag, pointsEarned, correctCount, totalQuestions, score);
        List<Badge> newBadges = badgeService.checkQuizAchievements(userId, score, 100, score == 100);
        quizService.saveResult(AuthenticationService.getCurrentUser(), currentQuiz, score); // Note: this saves to the
                                                                                            // original quiz ID

        // Display
        showResult(score, pointsEarned, newBadges);

        // Multiplayer Logic
        if (currentRoom != null) {
            handleMultiplayerResults(score);
        }
    }

    private void handleMultiplayerResults(int score) {
        String myId = String.valueOf(AuthenticationService.getCurrentUser().getId());

        // 1. Submit score and time to DB
        RoomManager.getInstance().submitFinalScore(currentRoom.getRoomId(), myId, score, totalTimeTaken);

        // 2. Refresh Room data to see others
        Room updatedRoom = RoomManager.getInstance().getRoom(currentRoom.getRoomId());
        if (updatedRoom == null)
            return;

        multiplayerResultsBox.setVisible(true);
        multiplayerResultsBox.setManaged(true);
        multiplayerResultsBox.setOpacity(0);

        FadeTransition ft = new FadeTransition(Duration.millis(800), multiplayerResultsBox);
        ft.setToValue(1.0);
        ft.play();

        updateLeaderboardUI(updatedRoom, myId, score);
    }

    private void updateLeaderboardUI(Room room, String myId, int myScore) {
        multiplayerLeaderboard.getChildren().clear();

        Map<String, Integer> scores = room.getScores();
        Map<String, Integer> times = room.getTimes();

        // Find best player (Single Winner Logic)
        String winnerId = null;
        int maxScore = -1;
        int minTime = Integer.MAX_VALUE;
        boolean isTie = false;

        for (String uid : scores.keySet()) {
            int s = scores.getOrDefault(uid, 0);
            int t = times.getOrDefault(uid, 0);

            if (s > maxScore) {
                maxScore = s;
                minTime = t;
                winnerId = uid;
                isTie = false;
            } else if (s == maxScore && maxScore != -1) {
                if (t < minTime) {
                    minTime = t;
                    winnerId = uid;
                    isTie = false;
                } else if (t == minTime) {
                    isTie = true; // Still a tie
                }
            }
        }

        if (myId.equals(winnerId) && !isTie) {
            winStatusLabel.setText("1ÈRE PLACE ! VOUS AVEZ GAGNÉ 🏆");
            winStatusLabel.setStyle("-fx-text-fill: #4CAF50; -fx-font-size: 24px; -fx-font-weight: bold;");
        } else if (isTie && maxScore > 0) {
            winStatusLabel.setText("MATCH NUL ! ÉGALITÉ PARFAITE 🤝");
            winStatusLabel.setStyle("-fx-text-fill: #FF9800; -fx-font-size: 24px; -fx-font-weight: bold;");
        } else if (maxScore > 0) {
            winStatusLabel.setText("DOMMAGE ! VOUS ÊTES " + (myScore >= maxScore ? "2ÈME" : "PERDANT") + " ❌");
            winStatusLabel.setStyle("-fx-text-fill: #F44336; -fx-font-size: 24px; -fx-font-weight: bold;");
        } else {
            winStatusLabel.setText("QUIZ TERMINÉ");
        }

        final String finalWinnerId = winnerId;
        final boolean finalIsTie = isTie;

        // Sort players by score, then time
        room.getPlayers().values().stream()
                .sorted((p1, p2) -> {
                    int s1 = scores.getOrDefault(p1.getUserId(), 0);
                    int s2 = scores.getOrDefault(p2.getUserId(), 0);
                    if (s1 != s2)
                        return s2 - s1;
                    return times.getOrDefault(p1.getUserId(), 0) - times.getOrDefault(p2.getUserId(), 0);
                })
                .forEach(p -> {
                    HBox row = new HBox(10);
                    row.setAlignment(Pos.CENTER_LEFT);
                    row.setStyle("-fx-padding: 10; -fx-background-color: "
                            + (p.getUserId().equals(myId) ? "#E3F2FD" : "white")
                            + "; -fx-background-radius: 5; -fx-border-color: #eee; -fx-border-width: 1;");

                    Label name = new Label(p.getUsername() + (p.getUserId().equals(myId) ? " (Vous)" : ""));
                    name.setStyle("-fx-font-weight: " + (p.getUserId().equals(finalWinnerId) ? "bold" : "normal"));

                    if (p.getUserId().equals(finalWinnerId) && !finalIsTie) {
                        name.setText("👑 " + name.getText());
                    }

                    int s = scores.getOrDefault(p.getUserId(), 0);
                    int t = times.getOrDefault(p.getUserId(), 0);
                    Label sLabel = new Label(s + "% (" + t + "s)");
                    sLabel.setStyle("-fx-font-weight: bold; -fx-text-fill: #1976D2;");

                    row.getChildren().addAll(name, new Spacer(), sLabel);
                    multiplayerLeaderboard.getChildren().add(row);
                });

    }

    private void showResult(int score, int pointsEarned, List<Badge> newBadges) {
        String msg = "Votre Score : " + score + "%";
        if (score >= 70) {
            msg += " - RÉUSSI ! \uD83C\uDF89";
            resultLabel.setStyle("-fx-text-fill: green; -fx-font-size: 18px; -fx-font-weight: bold;");
        } else {
            msg += " - Continuez à pratiquer ! \uD83D\uDCAA";
            resultLabel.setStyle("-fx-text-fill: orange; -fx-font-size: 18px; -fx-font-weight: bold;");
        }
        resultLabel.setText(msg);

        pointsLabel.setText("+" + pointsEarned + " XP");
        pointsLabel.setStyle("-fx-text-fill: #4CAF50; -fx-font-size: 24px; -fx-font-weight: bold;");

        badgesContainer.getChildren().clear();
        if (!newBadges.isEmpty()) {
            Label badgeHeader = new Label("\uD83C\uDFC6 Nouveaux Badges Gagnés !");
            badgeHeader.setStyle("-fx-font-size: 16px; -fx-font-weight: bold; -fx-text-fill: #FF9800;");
            badgesContainer.getChildren().add(badgeHeader);
            for (Badge b : newBadges) {
                Label lbl = new Label("• " + b.getName());
                badgesContainer.getChildren().add(lbl);
            }
        }
    }

    @FXML
    public void showReview() {
        // Simple review mode: Re-use the question view but show correct answers
        isReviewMode = true;
        currentQuestionIndex = 0;
        questionView.setVisible(true);
        resultsView.setVisible(false);
        nextButton.setVisible(true);
        nextButton.setText("Question Suivante");

        showReviewQuestion(); // Helper for review mode
    }

    private void showReviewQuestion() {
        if (currentQuestionIndex >= filteredQuestions.size()) {
            // End of review -> back to results
            questionView.setVisible(false);
            resultsView.setVisible(true);
            nextButton.setVisible(false);
            return;
        }

        Question q = filteredQuestions.get(currentQuestionIndex);
        progressLabel.setText("Revoir " + (currentQuestionIndex + 1) + "/" + filteredQuestions.size());
        questionTextLabel.setText(q.getQuestionText());
        timerLabel.setText(""); // No timer in review

        answersContainer.getChildren().clear();
        List<Integer> userAns = userAnswers.getOrDefault(q.getId(), new ArrayList<>());

        for (Answer a : q.getAnswers()) {
            Label ansLabel = new Label(a.getAnswerText());
            ansLabel.setStyle("-fx-font-size: 14px; -fx-padding: 5;");
            ansLabel.setMaxWidth(Double.MAX_VALUE);

            if (a.isCorrect()) {
                ansLabel.setStyle(ansLabel.getStyle() + "-fx-background-color: #C8E6C9; -fx-border-color: green;"); // Green
                                                                                                                    // for
                                                                                                                    // correct
            }

            if (userAns.contains(a.getId())) {
                if (a.isCorrect()) {
                    ansLabel.setText("✅ " + a.getAnswerText());
                } else {
                    ansLabel.setStyle(ansLabel.getStyle() + "-fx-background-color: #FFCDD2; -fx-border-color: red;"); // Red
                                                                                                                      // for
                                                                                                                      // wrong
                                                                                                                      // selected
                    ansLabel.setText("❌ " + a.getAnswerText());
                }
            }

            answersContainer.getChildren().add(ansLabel);
        }

        feedbackLabel.setText(q.getExplanation() != null ? q.getExplanation() : "");

        if (currentQuestionIndex == filteredQuestions.size() - 1) {
            nextButton.setText("Retour aux Résultats");
        } else {
            nextButton.setText("Suivant");
        }

        // Hijack next button action for review
        nextButton.setOnAction(e -> {
            currentQuestionIndex++;
            showReviewQuestion();
        });
    }

    @FXML
    public void retryQuiz() {
        startQuiz();
        // Reset next button action just in case it was hijacked
        nextButton.setOnAction(e -> handleNext());
    }

    @FXML
    public void handleBack() {
        stopTimer();
        try {
            if (currentRoom != null) {
                // Return to multiplayer room
                FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/room_view.fxml"));
                javafx.scene.layout.BorderPane view = loader.load();
                com.app.controller.RoomController controller = loader.getController();
                controller.setRoom(currentRoom);
                controller.setContentArea(contentArea);

                contentArea.getChildren().clear();
                contentArea.getChildren().add(view);
            } else {
                // Go back to language selection for solo mode
                FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/language_selection.fxml"));
                VBox view = loader.load();
                com.app.controller.LanguageSelectionController controller = loader.getController();
                controller.setContentArea(contentArea);

                contentArea.getChildren().clear();
                contentArea.getChildren().add(view);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
