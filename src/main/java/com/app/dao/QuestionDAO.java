package com.app.dao;

import com.app.model.Question;
import java.util.List;

public interface QuestionDAO {
    List<Question> findAll();

    List<Question> findByLanguage(String language);

    boolean delete(int questionId);

    int save(Question question); // Returns generated ID

    boolean update(Question question);
}
