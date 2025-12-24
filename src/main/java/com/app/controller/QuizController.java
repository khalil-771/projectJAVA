package com.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.app.model.Answer;
import com.app.model.Badge;
import com.app.model.Question;
import com.app.model.Quiz;
import com.app.service.AuthenticationService;
import com.app.service.BadgeService;
import com.app.service.QuizService;
import com.app.service.StatsService;

import javafx.animation.FadeTransition;
import javafx.animation.ScaleTransition;
import javafx.fxml.FXML;
import javafx.scene.control.CheckBox;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Control;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.ToggleGroup;
import javafx.scene.layout.VBox;
import javafx.util.Duration;

public class QuizController {

    @FXML
    private Label quizTitleLabel;
    @FXML
    private VBox questionsContainer;
    @FXML
    private Label resultLabel;
    @FXML
    private Label pointsLabel; // New: Shows points earned
    @FXML
    private VBox badgesContainer; // New: Shows newly earned badges

    private final QuizService quizService = new QuizService();
    private final StatsService statsService = new StatsService();
    private final BadgeService badgeService = new BadgeService();

    private Quiz currentQuiz;

    // Map<QuestionId, List<CheckBox/RadioButton>>
    private final Map<Integer, List<Control>> answerControls = new HashMap<>();

    public void loadQuiz(int quizId) {
        currentQuiz = quizService.getQuiz(quizId);
        if (currentQuiz == null)
            return;

        quizTitleLabel.setText(currentQuiz.getTitle());
        buildQuizUI();
    }

    private void buildQuizUI() {
        questionsContainer.getChildren().clear();
        answerControls.clear();

        if (pointsLabel != null) {
            pointsLabel.setText("");
        }
        if (badgesContainer != null) {
            badgesContainer.getChildren().clear();
        }

        System.out.println("Number of questions in quiz: " + currentQuiz.getQuestions().size());

        int index = 1;
<<<<<<< Updated upstream
=======
        String selectedDifficulty = (difficultyCombo != null && difficultyCombo.getValue() != null)
                ? difficultyCombo.getValue() : "All";


>>>>>>> Stashed changes
        for (Question q : currentQuiz.getQuestions()) {
            VBox questionBox = new VBox(5);
            questionBox.setStyle("-fx-padding: 10; -fx-border-color: #ddd; -fx-border-width: 0 0 1 0;");

            Label qLabel = new Label(index + ". " + q.getQuestionText());
            qLabel.setStyle("-fx-font-weight: bold; -fx-font-size: 14px;");
            questionBox.getChildren().add(qLabel);

            List<Control> controls = new ArrayList<>();
            ToggleGroup group = new ToggleGroup();

            for (Answer a : q.getAnswers()) {
                if (q.getType() == Question.QuestionType.SINGLE_CHOICE
                        || q.getType() == Question.QuestionType.TRUE_FALSE) {
                    RadioButton rb = new RadioButton(a.getAnswerText());
                    rb.setUserData(a.getId());
                    rb.setToggleGroup(group);
                    questionBox.getChildren().add(rb);
                    controls.add(rb);
                } else {
                    CheckBox cb = new CheckBox(a.getAnswerText());
                    cb.setUserData(a.getId());
                    questionBox.getChildren().add(cb);
                    controls.add(cb);
                }
            }
            answerControls.put(q.getId(), controls);
            questionsContainer.getChildren().add(questionBox);
            index++;
        }
    }

    @FXML
    public void submitQuiz() {
        Map<Integer, List<Integer>> userAnswers = new HashMap<>();

        for (Map.Entry<Integer, List<Control>> entry : answerControls.entrySet()) {
            int qId = entry.getKey();
            List<Integer> selectedIds = new ArrayList<>();

            for (Control c : entry.getValue()) {
                if (c instanceof RadioButton) {
                    if (((RadioButton) c).isSelected()) {
                        selectedIds.add((Integer) c.getUserData());
                    }
                } else if (c instanceof CheckBox) {
                    if (((CheckBox) c).isSelected()) {
                        selectedIds.add((Integer) c.getUserData());
                    }
                }
            }
            userAnswers.put(qId, selectedIds);
        }

        // Calculate score and detailed results
        int score = quizService.calculateScore(currentQuiz, userAnswers);
        int correctCount = quizService.countCorrectAnswers(currentQuiz, userAnswers);
        int totalQuestions = currentQuiz.getQuestions().size();
        boolean isPerfect = (score == 100);

        // Calculate points earned (base on difficulty and performance)
        int pointsEarned = calculatePoints(score, totalQuestions);

        // Update user stats
        int userId = AuthenticationService.getCurrentUser().getId();
        statsService.updateStatsAfterQuiz(userId, pointsEarned, correctCount, totalQuestions);

        // Check for newly earned badges
        List<Badge> newBadges = badgeService.checkQuizAchievements(userId, score, 100, isPerfect);

        // Save quiz result
        quizService.saveResult(AuthenticationService.getCurrentUser(), currentQuiz, score);

        // Show results with gamification
        showResult(score, pointsEarned, newBadges);
    }

    /**
     * Calculate points based on score and question count
     */
    private int calculatePoints(int score, int questionCount) {
        // Base points: 10 per question
        int basePoints = questionCount * 10;

        // Multiply by score percentage
        int earnedPoints = (int) (basePoints * (score / 100.0));

        // Bonus for perfect score
        if (score == 100) {
            earnedPoints += 50;
        }

        return Math.max(earnedPoints, 10); // Minimum 10 points
    }

    private void showResult(int score, int pointsEarned, List<Badge> newBadges) {
        String msg = "Your Score: " + score + "%";
        if (score >= currentQuiz.getPassingScore()) {
            msg += " - PASSED! 🎉";
            resultLabel.setStyle("-fx-text-fill: green; -fx-font-size: 18px; -fx-font-weight: bold;");
        } else {
            msg += " - Keep practicing! 💪";
            resultLabel.setStyle("-fx-text-fill: orange; -fx-font-size: 18px; -fx-font-weight: bold;");
        }
        resultLabel.setText(msg);

        // Animate result label
        animateFadeIn(resultLabel);

        // Show points earned
        if (pointsLabel != null) {
            pointsLabel.setText("+" + pointsEarned + " XP");
            pointsLabel.setStyle("-fx-text-fill: #4CAF50; -fx-font-size: 24px; -fx-font-weight: bold;");
            animatePoints(pointsLabel);
        }

        // Show newly earned badges
        if (badgesContainer != null && !newBadges.isEmpty()) {
            badgesContainer.getChildren().clear();

            Label badgeHeader = new Label("🏆 New Badges Earned!");
            badgeHeader.setStyle("-fx-font-size: 16px; -fx-font-weight: bold; -fx-text-fill: #FF9800;");
            badgesContainer.getChildren().add(badgeHeader);

            for (Badge badge : newBadges) {
                Label badgeLabel = new Label("• " + badge.getName() + " (+" + badge.getPointsReward() + " XP)");
                badgeLabel.setStyle("-fx-font-size: 14px; -fx-text-fill: #333; -fx-padding: 5;");
                badgesContainer.getChildren().add(badgeLabel);
                animateFadeIn(badgeLabel);
            }
        }
    }

    private void animateFadeIn(Label label) {
        FadeTransition fade = new FadeTransition(Duration.millis(800), label);
        fade.setFromValue(0.0);
        fade.setToValue(1.0);
        fade.play();
    }

    private void animatePoints(Label label) {
        // Fade in
        FadeTransition fade = new FadeTransition(Duration.millis(600), label);
        fade.setFromValue(0.0);
        fade.setToValue(1.0);

        // Scale up
        ScaleTransition scale = new ScaleTransition(Duration.millis(400), label);
        scale.setFromX(0.5);
        scale.setFromY(0.5);
        scale.setToX(1.2);
        scale.setToY(1.2);
        scale.setAutoReverse(true);
        scale.setCycleCount(2);

        fade.play();
        scale.play();
    }
}
