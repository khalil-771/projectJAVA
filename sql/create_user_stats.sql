CREATE TABLE IF NOT EXISTS user_stats (
    user_id INT PRIMARY KEY,
    total_points INT DEFAULT 0,
    current_level INT DEFAULT 1,
    experience_points INT DEFAULT 0,
    best_streak INT DEFAULT 0,
    current_streak INT DEFAULT 0,
    total_quizzes_played INT DEFAULT 0,
    total_correct_answers INT DEFAULT 0,
    total_questions_answered INT DEFAULT 0,
    last_quiz_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
