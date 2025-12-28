package com.app.service;

import com.app.dao.QuestionDAO;
import com.app.dao.impl.QuestionDAOImpl;
import com.app.model.Question;
import com.app.model.Answer;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for admin question management
 */
public class AdminQuestionService {

    private final QuestionDAO questionDAO;

    public AdminQuestionService() {
        this.questionDAO = new QuestionDAOImpl();
    }

    /**
     * Create a new question
     */
    public boolean createQuestion(Question question, List<Answer> answers) {
        try {
            question.setAnswers(answers);
            int id = questionDAO.save(question);
            if (id > 0) {
                System.out.println("✅ Question created with ID: " + id);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("❌ Error creating question: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update existing question
     */
    public boolean updateQuestion(Question question, List<Answer> answers) {
        try {
            question.setAnswers(answers);
            boolean success = questionDAO.update(question);
            if (success) {
                System.out.println("✅ Question updated: " + question.getId());
            }
            return success;
        } catch (Exception e) {
            System.err.println("❌ Error updating question: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete question
     */
    public boolean deleteQuestion(int questionId) {
        try {
            boolean success = questionDAO.delete(questionId);
            if (success) {
                System.out.println("✅ Question deleted: " + questionId);
            }
            return success;
        } catch (Exception e) {
            System.err.println("❌ Error deleting question: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get all questions
     */
    public List<Question> getAllQuestions() {
        try {
            return questionDAO.findAll();
        } catch (Exception e) {
            System.err.println("❌ Error fetching all questions: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Get questions by language
     */
    public List<Question> getQuestionsByLanguage(String languageTag) {
        try {
            return questionDAO.findByLanguage(languageTag);
        } catch (Exception e) {
            System.err.println("❌ Error fetching questions by language: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Get questions by difficulty
     */
    public List<Question> getQuestionsByDifficulty(String difficulty) {
        try {
            List<Question> allQuestions = questionDAO.findAll();
            return allQuestions.stream()
                    .filter(q -> q.getDifficulty().equalsIgnoreCase(difficulty))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            System.err.println("❌ Error fetching questions by difficulty: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Search questions
     */
    public List<Question> searchQuestions(String keyword) {
        try {
            List<Question> allQuestions = questionDAO.findAll();
            return allQuestions.stream()
                    .filter(q -> q.getQuestionText().toLowerCase().contains(keyword.toLowerCase()))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            System.err.println("❌ Error searching questions: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Get question count
     */
    public int getQuestionCount() {
        try {
            return questionDAO.findAll().size();
        } catch (Exception e) {
            System.err.println("❌ Error getting question count: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Bulk import questions from CSV
     */
    public int bulkImportQuestions(List<Question> questions) {
        int successCount = 0;
        try {
            for (Question question : questions) {
                int id = questionDAO.save(question);
                if (id > 0) {
                    successCount++;
                }
            }
            System.out.println(
                    "✅ Bulk import completed: " + successCount + "/" + questions.size() + " questions imported");
        } catch (Exception e) {
            System.err.println("❌ Error during bulk import: " + e.getMessage());
            e.printStackTrace();
        }
        return successCount;
    }
}
