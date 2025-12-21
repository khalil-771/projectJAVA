package com.app.model;

import java.util.ArrayList;
import java.util.List;

public class Quiz {
    private int id;
    private int courseId;
    private String title;
    private boolean isFinalExam;
    private int passingScore;

    private List<Question> questions = new ArrayList<>();

    public Quiz() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isFinalExam() {
        return isFinalExam;
    }

    public void setFinalExam(boolean finalExam) {
        isFinalExam = finalExam;
    }

    public int getPassingScore() {
        return passingScore;
    }

    public void setPassingScore(int passingScore) {
        this.passingScore = passingScore;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    public void addQuestion(Question question) {
        this.questions.add(question);
    }
}
