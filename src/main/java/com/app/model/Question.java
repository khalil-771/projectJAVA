package com.app.model;

import java.util.ArrayList;
import java.util.List;

public class Question {
    private int id;
    private int quizId;
    private String questionText;
    private QuestionType type;
    private String explanation;
    private String difficulty; // BEGINNER, INTERMEDIATE, ADVANCED
    private String languageTag; // java, python, etc.
    private int points; // Points for this question

    private List<Answer> answers = new ArrayList<>();

    public enum QuestionType {
        SINGLE_CHOICE, MULTIPLE_CHOICE, TRUE_FALSE
    }

    public Question() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public QuestionType getType() {
        return type;
    }

    public void setType(QuestionType type) {
        this.type = type;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public String getLanguageTag() {
        return languageTag;
    }

    public void setLanguageTag(String languageTag) {
        this.languageTag = languageTag;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public boolean isMultipleChoice() {
        return type == QuestionType.MULTIPLE_CHOICE;
    }

    public boolean isCorrect(List<Integer> selectedAnswerIds) {
        // Simple logic: checks if selected IDs match all correct answer IDs
        List<Integer> correctIds = new ArrayList<>();
        for (Answer a : answers) {
            if (a.isCorrect())
                correctIds.add(a.getId());
        }
        return correctIds.containsAll(selectedAnswerIds) && selectedAnswerIds.containsAll(correctIds);
    }
}
