package com.app.service;

import java.util.List;
import java.util.Map;

import com.app.dao.QuizDAO;
import com.app.dao.impl.QuizDAOImpl;
import com.app.model.Question;
import com.app.model.Quiz;
import com.app.model.User;

public class QuizService {

    private final QuizDAO quizDAO;

    public QuizService() {
        this.quizDAO = new QuizDAOImpl();
    }

    public List<Quiz> getQuizzesForCourse(int courseId) {
        return quizDAO.findQuizzesByCourseId(courseId);
    }

    public Quiz getQuiz(int quizId) {
        return quizDAO.getFullQuiz(quizId);
    }

    public int calculateScore(Quiz quiz, Map<Integer, List<Integer>> userAnswers) {
        int totalQuestions = quiz.getQuestions().size();
        if (totalQuestions == 0)
            return 0;

        int correctCount = 0;

        for (Question q : quiz.getQuestions()) {
            List<Integer> selected = userAnswers.getOrDefault(q.getId(), List.of());
            if (q.isCorrect(selected)) {
                correctCount++;
            }
        }

        return (int) ((((double) correctCount) / totalQuestions) * 100);
    }

    public int countCorrectAnswers(Quiz quiz, Map<Integer, List<Integer>> userAnswers) {
        int correctCount = 0;
        for (Question q : quiz.getQuestions()) {
            List<Integer> selected = userAnswers.getOrDefault(q.getId(), List.of());
            if (q.isCorrect(selected)) {
                correctCount++;
            }
        }
        return correctCount;
    }

    public void saveResult(User user, Quiz quiz, int score) {
        // TODO: Implement result saving to DB (Phase 6)
        System.out.println("User " + user.getUsername() + " scored " + score + " on " + quiz.getTitle());
    }

    /**
     * Get answers for a specific question
     */
    public List<com.app.model.Answer> getAnswersForQuestion(int questionId) {
        // Return answers from the question's answers list
        // This is a helper method for the enhanced quiz controller
        return new java.util.ArrayList<>(); // Placeholder - answers are already in Question.getAnswers()
    }

    /**
     * Get questions filtered by course and difficulty
     */
    public List<Question> getQuestionsByCourseAndDifficulty(int courseId, String difficulty) {
        return quizDAO.findQuestionsByCourseAndDifficulty(courseId, difficulty);
    }
}
