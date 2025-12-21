-- Gamification Database Extensions
-- Run this after database_setup.sql

USE elearning_db;

-- ============================================
-- USER STATISTICS & PROGRESSION
-- ============================================

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

-- ============================================
-- BADGES SYSTEM
-- ============================================

CREATE TABLE IF NOT EXISTS badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon_path VARCHAR(255),
    badge_type ENUM('ACHIEVEMENT', 'MILESTONE', 'MASTERY', 'SPECIAL') DEFAULT 'ACHIEVEMENT',
    points_reward INT DEFAULT 0,
    rule_condition VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    badge_id INT NOT NULL,
    earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (badge_id) REFERENCES badges(id) ON DELETE CASCADE,
    UNIQUE(user_id, badge_id)
);

-- ============================================
-- LANGUAGE-SPECIFIC STATISTICS
-- ============================================

CREATE TABLE IF NOT EXISTS user_language_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    language_tag VARCHAR(20) NOT NULL,
    difficulty_level ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') DEFAULT 'BEGINNER',
    points INT DEFAULT 0,
    quizzes_played INT DEFAULT 0,
    correct_answers INT DEFAULT 0,
    total_questions INT DEFAULT 0,
    best_score INT DEFAULT 0,
    last_played TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(user_id, language_tag),
    INDEX idx_language (language_tag),
    INDEX idx_user_lang (user_id, language_tag)
);

-- ============================================
-- LEADERBOARD SYSTEM
-- ============================================

CREATE TABLE IF NOT EXISTS leaderboard_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    leaderboard_type ENUM('DAILY', 'WEEKLY', 'GLOBAL') NOT NULL,
    language_tag VARCHAR(20),
    rank_position INT NOT NULL,
    score INT NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_leaderboard (leaderboard_type, language_tag, period_start),
    INDEX idx_user_leaderboard (user_id, leaderboard_type)
);

-- ============================================
-- EXTEND EXISTING TABLES
-- ============================================

-- Add columns to questions table for multi-language and difficulty
ALTER TABLE questions 
ADD COLUMN IF NOT EXISTS language_tag VARCHAR(20) DEFAULT 'html',
ADD COLUMN IF NOT EXISTS difficulty_level ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') DEFAULT 'BEGINNER',
ADD COLUMN IF NOT EXISTS points_value INT DEFAULT 10;

-- Add performance metrics to quiz results
ALTER TABLE user_quiz_results
ADD COLUMN IF NOT EXISTS time_taken_seconds INT,
ADD COLUMN IF NOT EXISTS correct_count INT DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_questions INT DEFAULT 0,
ADD COLUMN IF NOT EXISTS points_earned INT DEFAULT 0,
ADD COLUMN IF NOT EXISTS difficulty_level ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED'),
ADD COLUMN IF NOT EXISTS language_tag VARCHAR(20);

-- ============================================
-- SEED INITIAL BADGES
-- ============================================

INSERT INTO badges (name, description, icon_path, badge_type, points_reward, rule_condition) VALUES
('First Steps', 'Complete your first quiz', '/icons/badges/first_quiz.png', 'ACHIEVEMENT', 50, 'total_quizzes >= 1'),
('Quiz Enthusiast', 'Complete 10 quizzes', '/icons/badges/10_quizzes.png', 'MILESTONE', 100, 'total_quizzes >= 10'),
('Quiz Master', 'Complete 50 quizzes', '/icons/badges/50_quizzes.png', 'MILESTONE', 500, 'total_quizzes >= 50'),
('Perfect Score', 'Get 100% on any quiz', '/icons/badges/perfect.png', 'ACHIEVEMENT', 200, 'perfect_score == true'),
('Speed Demon', 'Answer 10 questions in under 5 seconds each', '/icons/badges/speed.png', 'ACHIEVEMENT', 150, 'speed_answers >= 10'),
('Streak Master', 'Maintain a 7-day streak', '/icons/badges/streak.png', 'ACHIEVEMENT', 300, 'best_streak >= 7'),
('Java Beginner', 'Complete 5 Java quizzes at beginner level', '/icons/badges/java_beginner.png', 'MASTERY', 100, 'language:java,level:BEGINNER,count:5'),
('Python Beginner', 'Complete 5 Python quizzes at beginner level', '/icons/badges/python_beginner.png', 'MASTERY', 100, 'language:python,level:BEGINNER,count:5'),
('HTML Master', 'Complete 10 HTML quizzes at advanced level', '/icons/badges/html_master.png', 'MASTERY', 500, 'language:html,level:ADVANCED,count:10'),
('Polyglot', 'Complete quizzes in 5 different languages', '/icons/badges/polyglot.png', 'SPECIAL', 1000, 'unique_languages >= 5'),
('Top 10', 'Reach top 10 in any leaderboard', '/icons/badges/top10.png', 'ACHIEVEMENT', 250, 'leaderboard_rank <= 10'),
('Champion', 'Reach #1 in any leaderboard', '/icons/badges/champion.png', 'SPECIAL', 1000, 'leaderboard_rank == 1'),
('Level 5', 'Reach level 5', '/icons/badges/level5.png', 'MILESTONE', 200, 'current_level >= 5'),
('Level 10', 'Reach level 10', '/icons/badges/level10.png', 'MILESTONE', 500, 'current_level >= 10'),
('Accuracy Expert', 'Maintain 90% accuracy over 20 quizzes', '/icons/badges/accuracy.png', 'ACHIEVEMENT', 400, 'accuracy >= 90 AND total_quizzes >= 20');

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

CREATE INDEX idx_questions_language_difficulty ON questions(language_tag, difficulty_level);
CREATE INDEX idx_quiz_results_user_date ON user_quiz_results(user_id, taken_at);
CREATE INDEX idx_user_stats_points ON user_stats(total_points DESC);
CREATE INDEX idx_user_stats_level ON user_stats(current_level DESC);

-- ============================================
-- INITIAL DATA FOR TESTING
-- ============================================

-- Add some sample questions for different languages
INSERT INTO questions (quiz_id, question_text, question_type, language_tag, difficulty_level, points_value, explanation) VALUES
-- Java questions
(1, 'What is the correct way to declare a variable in Java?', 'SINGLE_CHOICE', 'java', 'BEGINNER', 10, 'In Java, variables are declared with type followed by name.'),
(1, 'Which keyword is used for inheritance in Java?', 'SINGLE_CHOICE', 'java', 'BEGINNER', 10, 'The extends keyword is used for class inheritance.'),
(1, 'What is polymorphism in Java?', 'SINGLE_CHOICE', 'java', 'INTERMEDIATE', 20, 'Polymorphism allows objects to take many forms.'),

-- Python questions  
(1, 'How do you create a list in Python?', 'SINGLE_CHOICE', 'python', 'BEGINNER', 10, 'Lists in Python are created using square brackets []'),
(1, 'What is a lambda function in Python?', 'SINGLE_CHOICE', 'python', 'INTERMEDIATE', 20, 'Lambda functions are anonymous functions defined with lambda keyword'),

-- HTML questions
(1, 'What does HTML stand for?', 'SINGLE_CHOICE', 'html', 'BEGINNER', 10, 'HTML stands for HyperText Markup Language'),
(1, 'Which tag is used for the largest heading?', 'SINGLE_CHOICE', 'html', 'BEGINNER', 10, 'The <h1> tag creates the largest heading'),

-- CSS questions
(1, 'What property is used to change text color in CSS?', 'SINGLE_CHOICE', 'css', 'BEGINNER', 10, 'The color property changes text color'),
(1, 'What is the CSS box model?', 'SINGLE_CHOICE', 'css', 'INTERMEDIATE', 20, 'The box model consists of margin, border, padding, and content');

-- Add corresponding answers (simplified - you'll need to add proper answers)
INSERT INTO answers (question_id, answer_text, is_correct) VALUES
-- For question 1 (Java variable declaration)
(1, 'int x = 5;', true),
(1, 'var x = 5;', false),
(1, 'x = 5;', false),
(1, 'integer x = 5;', false);

COMMIT;
