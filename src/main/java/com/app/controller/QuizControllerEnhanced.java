package com.app.controller;

import com.app.dao.QuizHistoryDAO;
import com.app.dao.impl.QuizHistoryDAOImpl;
import com.app.model.*;
import com.app.service.AuthenticationService;
import com.app.service.BadgeService;
import com.app.service.CourseService;
import com.app.service.QuizService;
import com.app.service.StatsService;
import com.app.util.BadgeNotificationUtil;
import javafx.animation.*;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.util.Duration;

import java.util.*;

public class QuizControllerEnhanced {

    @FXML
    private Label quizTitleLabel;
    @FXML
    private Label timerLabel;
    @FXML
    private ProgressBar timerProgressBar;
    @FXML
    private VBox questionsContainer;
    @FXML
    private Label resultLabel;
    @FXML
    private Label pointsLabel;
    @FXML
    private VBox badgesContainer;
    @FXML
    private Button submitButton;

    private final QuizService quizService = new QuizService();
    private final StatsService statsService = new StatsService();
    private final BadgeService badgeService = new BadgeService();
    private final CourseService courseService = new CourseService();
    private final QuizHistoryDAO historyDAO = new QuizHistoryDAOImpl();

    private Quiz currentQuiz;
    private final Map<Integer, List<Control>> answerControls = new HashMap<>();

    // Timer variables
    private Timeline questionTimer;
    private int timeRemaining;
    private int totalTimeLimit = 60; // seconds per question
    private long quizStartTime;
    private int fastAnswerCount = 0; // For speed bonus
    private static final int FAST_ANSWER_THRESHOLD = 10; // seconds

    public void loadQuiz(int quizId) {
        currentQuiz = quizService.getQuiz(quizId);
        if (currentQuiz == null)
            return;

        quizTitleLabel.setText(currentQuiz.getTitle());
        questionsContainer.getChildren().clear();
        answerControls.clear();

        quizStartTime = System.currentTimeMillis();

        displayQuestions();
        startQuizTimer();
    }

    private void displayQuestions() {
        List<Question> questions = currentQuiz.getQuestions();

        for (int i = 0; i < questions.size(); i++) {
            Question question = questions.get(i);

            VBox questionBox = new VBox(10);
            questionBox.setStyle("-fx-padding: 15; -fx-background-color: white; -fx-background-radius: 5;");

            // Question header with difficulty
            HBox headerBox = new HBox(10);
            Label questionLabel = new Label((i + 1) + ". " + question.getQuestionText());
            questionLabel.setWrapText(true);
            questionLabel.setStyle("-fx-font-size: 14px; -fx-font-weight: bold;");

            // Difficulty indicator
            Label difficultyLabel = new Label(getDifficultyEmoji(question.getDifficulty()));
            difficultyLabel.setStyle("-fx-font-size: 16px;");

            headerBox.getChildren().addAll(questionLabel, difficultyLabel);
            questionBox.getChildren().add(headerBox);

            List<Answer> answers = quizService.getAnswersForQuestion(question.getId());
            List<Control> controls = new ArrayList<>();

            if (question.isMultipleChoice()) {
                // Multiple choice - checkboxes
                for (Answer answer : answers) {
                    CheckBox checkBox = new CheckBox(answer.getAnswerText());
                    checkBox.setUserData(answer);
                    controls.add(checkBox);
                    questionBox.getChildren().add(checkBox);
                }
            } else {
                // Single choice - radio buttons
                ToggleGroup group = new ToggleGroup();
                for (Answer answer : answers) {
                    RadioButton radioButton = new RadioButton(answer.getAnswerText());
                    radioButton.setToggleGroup(group);
                    radioButton.setUserData(answer);
                    controls.add(radioButton);
                    questionBox.getChildren().add(radioButton);
                }
            }

            answerControls.put(question.getId(), controls);
            questionsContainer.getChildren().add(questionBox);
        }
    }

    private String getDifficultyEmoji(String difficulty) {
        if (difficulty == null)
            return "⭐";
        switch (difficulty.toUpperCase()) {
            case "BEGINNER":
                return "🟢";
            case "INTERMEDIATE":
                return "🟡";
            case "ADVANCED":
                return "🔴";
            default:
                return "⭐";
        }
    }

    private void startQuizTimer() {
        timeRemaining = totalTimeLimit;
        updateTimerDisplay();

        questionTimer = new Timeline(new KeyFrame(Duration.seconds(1), e -> {
            timeRemaining--;
            updateTimerDisplay();

            // Update progress bar
            double progress = (double) timeRemaining / totalTimeLimit;
            timerProgressBar.setProgress(progress);

            // Change color based on time
            if (timeRemaining <= 10) {
                timerLabel.setStyle("-fx-text-fill: #F44336; -fx-font-size: 24px; -fx-font-weight: bold;");
            } else if (timeRemaining <= 30) {
                timerLabel.setStyle("-fx-text-fill: #FF9800; -fx-font-size: 20px; -fx-font-weight: bold;");
            }

            if (timeRemaining == 0) {
                autoSubmitQuiz();
            }
        }));
        questionTimer.setCycleCount(Timeline.INDEFINITE);
        questionTimer.play();
    }

    private void updateTimerDisplay() {
        int minutes = timeRemaining / 60;
        int seconds = timeRemaining % 60;
        timerLabel.setText(String.format("⏱️ %d:%02d", minutes, seconds));
    }

    @FXML
    private void submitQuiz() {
        if (questionTimer != null) {
            questionTimer.stop();
        }

        long quizEndTime = System.currentTimeMillis();
        long totalTimeSpent = (quizEndTime - quizStartTime) / 1000; // in seconds

        Map<Integer, List<Integer>> userAnswers = collectUserAnswers();

        int score = quizService.calculateScore(currentQuiz, userAnswers);
        int correctCount = quizService.countCorrectAnswers(currentQuiz, userAnswers);
        int totalQuestions = currentQuiz.getQuestions().size();
        boolean isPerfect = (score == 100);

        // Calculate points with speed bonus
        int basePoints = calculatePoints(score, totalQuestions);
        int speedBonus = calculateSpeedBonus(totalTimeSpent, totalQuestions);
        int totalPoints = basePoints + speedBonus;

        // Update stats
        int userId = AuthenticationService.getCurrentUser().getId();
        String languageTag = null;
        Course course = courseService.getCourse(currentQuiz.getCourseId());
        if (course != null) {
            languageTag = course.getLanguageTag();
        }
        statsService.updateStatsAfterQuiz(userId, languageTag, totalPoints, correctCount, totalQuestions, score);

        // Check badges
        List<Badge> newBadges = badgeService.checkQuizAchievements(userId, score, 100, isPerfect);

        // Save to history
        saveQuizHistory(userId, score, totalPoints, correctCount, totalQuestions, totalTimeSpent);

        // Save result
        quizService.saveResult(AuthenticationService.getCurrentUser(), currentQuiz, score);

        // Show results
        showResult(score, totalPoints, speedBonus, newBadges);

        // Show badge notifications
        for (Badge badge : newBadges) {
            BadgeNotificationUtil.showBadgeNotification(badge, (Stage) submitButton.getScene().getWindow());
        }
    }

    private void autoSubmitQuiz() {
        Platform.runLater(() -> {
            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Time's Up!");
            alert.setHeaderText("Quiz time expired");
            alert.setContentText("Your quiz will be submitted automatically.");
            alert.showAndWait();

            submitQuiz();
        });
    }

    private int calculateSpeedBonus(long totalTimeSpent, int totalQuestions) {
        double avgTimePerQuestion = (double) totalTimeSpent / totalQuestions;

        if (avgTimePerQuestion < FAST_ANSWER_THRESHOLD) {
            // Speed bonus: 10% of base points
            int bonus = (int) (totalQuestions * 10 * 0.1);
            System.out.println("⚡ Speed Bonus: +" + bonus + " XP (avg " + String.format("%.1f", avgTimePerQuestion)
                    + "s per question)");
            return bonus;
        }

        return 0;
    }

    private void saveQuizHistory(int userId, int score, int points, int correct, int total, long timeSpent) {
        QuizHistory history = new QuizHistory();
        history.setUserId(userId);
        history.setQuizId(currentQuiz.getId());
        history.setQuizTitle(currentQuiz.getTitle());
        history.setLanguageTag("java"); // TODO: Get from quiz
        history.setScore(score);
        history.setPointsEarned(points);
        history.setCorrectAnswers(correct);
        history.setTotalQuestions(total);
        history.setDifficultyLevel("BEGINNER"); // TODO: Get from quiz
        history.setTimeSpent(timeSpent);

        historyDAO.save(history);
    }

    private Map<Integer, List<Integer>> collectUserAnswers() {
        Map<Integer, List<Integer>> userAnswers = new HashMap<>();

        for (Map.Entry<Integer, List<Control>> entry : answerControls.entrySet()) {
            Integer questionId = entry.getKey();
            List<Integer> selectedAnswerIds = new ArrayList<>();

            for (Control control : entry.getValue()) {
                if (control instanceof CheckBox) {
                    CheckBox checkBox = (CheckBox) control;
                    if (checkBox.isSelected()) {
                        Answer answer = (Answer) checkBox.getUserData();
                        selectedAnswerIds.add(answer.getId());
                    }
                } else if (control instanceof RadioButton) {
                    RadioButton radioButton = (RadioButton) control;
                    if (radioButton.isSelected()) {
                        Answer answer = (Answer) radioButton.getUserData();
                        selectedAnswerIds.add(answer.getId());
                    }
                }
            }

            userAnswers.put(questionId, selectedAnswerIds);
        }

        return userAnswers;
    }

    private int calculatePoints(int score, int totalQuestions) {
        int basePoints = totalQuestions * 10;
        int earnedPoints = (int) (basePoints * (score / 100.0));

        if (score == 100) {
            earnedPoints += 50; // Perfect score bonus
        }

        return Math.max(10, earnedPoints);
    }

    private void showResult(int score, int totalPoints, int speedBonus, List<Badge> newBadges) {
        String message = score >= 70 ? "PASSED! 🎉" : "Keep practicing! 💪";
        resultLabel.setText("Your Score: " + score + "% - " + message);
        resultLabel.setStyle(score >= 70 ? "-fx-text-fill: #4CAF50; -fx-font-size: 20px; -fx-font-weight: bold;"
                : "-fx-text-fill: #FF9800; -fx-font-size: 20px; -fx-font-weight: bold;");

        // Show points with speed bonus
        if (pointsLabel != null) {
            String pointsText = "+" + totalPoints + " XP";
            if (speedBonus > 0) {
                pointsText += " (⚡ +" + speedBonus + " speed bonus!)";
            }
            pointsLabel.setText(pointsText);
            pointsLabel.setStyle("-fx-text-fill: #4CAF50; -fx-font-size: 24px; -fx-font-weight: bold;");
            animatePoints(pointsLabel);
        }

        // Show badges
        if (badgesContainer != null && !newBadges.isEmpty()) {
            badgesContainer.getChildren().clear();
            Label badgeHeader = new Label("🏆 New Badges Earned!");
            badgeHeader.setStyle("-fx-font-size: 18px; -fx-font-weight: bold; -fx-text-fill: #FF9800;");
            badgesContainer.getChildren().add(badgeHeader);

            for (Badge badge : newBadges) {
                Label badgeLabel = new Label("• " + badge.getName() + " (+" + badge.getPointsReward() + " XP)");
                badgeLabel.setStyle("-fx-font-size: 14px; -fx-text-fill: #666;");
                badgesContainer.getChildren().add(badgeLabel);
            }
        }

        submitButton.setDisable(true);
    }

    private void animatePoints(Label label) {
        FadeTransition fade = new FadeTransition(Duration.millis(500), label);
        fade.setFromValue(0.0);
        fade.setToValue(1.0);

        ScaleTransition scale = new ScaleTransition(Duration.millis(500), label);
        scale.setFromX(0.5);
        scale.setFromY(0.5);
        scale.setToX(1.0);
        scale.setToY(1.0);

        ParallelTransition parallel = new ParallelTransition(fade, scale);
        parallel.play();
    }
}
