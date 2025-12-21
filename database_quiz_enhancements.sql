-- Quiz History Table
CREATE TABLE IF NOT EXISTS quiz_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    quiz_id INT NOT NULL,
    quiz_title VARCHAR(255),
    language_tag VARCHAR(20),
    score INT NOT NULL,
    points_earned INT NOT NULL,
    correct_answers INT NOT NULL,
    total_questions INT NOT NULL,
    difficulty_level VARCHAR(20),
    time_spent BIGINT DEFAULT 0,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_completed (user_id, completed_at),
    INDEX idx_user_language (user_id, language_tag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add explanation column to questions table
ALTER TABLE questions 
ADD COLUMN IF NOT EXISTS explanation TEXT,
ADD COLUMN IF NOT EXISTS resource_link VARCHAR(500),
ADD COLUMN IF NOT EXISTS time_limit INT DEFAULT 60;
