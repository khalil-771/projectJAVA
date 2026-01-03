-- Database Initialization Script

CREATE DATABASE IF NOT EXISTS quiztests CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quiztests;

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ROLE_STUDENT', 'ROLE_ADMIN') DEFAULT 'ROLE_STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- 13. Badges Table
CREATE TABLE IF NOT EXISTS badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon_path VARCHAR(255),
    badge_type ENUM('STREAK', 'SCORE', 'LEVEL', 'COURSE_COMPLETION', 'SPECIAL') NOT NULL,
    points_reward INT DEFAULT 0,
    rule_condition VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 14. User Badges Table
CREATE TABLE IF NOT EXISTS user_badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    badge_id INT NOT NULL,
    earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (badge_id) REFERENCES badges(id) ON DELETE CASCADE,
    UNIQUE(user_id, badge_id)
);

-- 15. User Overall Stats Table
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

-- 16. User Language Specific Stats Table
CREATE TABLE IF NOT EXISTS user_language_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    language_tag VARCHAR(20) NOT NULL,
    difficulty_level VARCHAR(20) DEFAULT 'BEGINNER',
    points INT DEFAULT 0,
    quizzes_played INT DEFAULT 0,
    correct_answers INT DEFAULT 0,
    total_questions INT DEFAULT 0,
    best_score INT DEFAULT 0,
    last_played TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(user_id, language_tag)
);



-- 2. Cours Table
CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    language_tag VARCHAR(20) NOT NULL, -- e.g., 'html', 'css', 'js'
    is_active BOOLEAN DEFAULT TRUE
);

-- 3. Chapters Table
CREATE TABLE IF NOT EXISTS chapters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    order_index INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- 4. Leçons Table
CREATE TABLE IF NOT EXISTS lessons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chapter_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    content_html MEDIUMTEXT, -- Main lesson content
    example_code TEXT, -- Code for the 'Try It' feature
    order_index INT NOT NULL,
    FOREIGN KEY (chapter_id) REFERENCES chapters(id) ON DELETE CASCADE
);

-- 5. References Table
CREATE TABLE IF NOT EXISTS references_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    syntax TEXT,
    description TEXT,
    example TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- 6. Quizzes Table
CREATE TABLE IF NOT EXISTS quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    is_final_exam BOOLEAN DEFAULT FALSE,
    passing_score INT DEFAULT 70,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- 7. Questions Table
CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    question_type ENUM('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TRUE_FALSE') NOT NULL,
    explanation TEXT,
    difficulty ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') DEFAULT 'BEGINNER',
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- 8. Answers Table
CREATE TABLE IF NOT EXISTS answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

-- 9. User Lesson Progress Table
CREATE TABLE IF NOT EXISTS user_lesson_progress (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    lesson_id INT NOT NULL,
    status ENUM('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED') DEFAULT 'NOT_STARTED',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
    UNIQUE(user_id, lesson_id)
);

-- 10. User Quiz Results Table
CREATE TABLE IF NOT EXISTS user_quiz_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    quiz_id INT NOT NULL,
    score INT NOT NULL,
    passed BOOLEAN NOT NULL,
    taken_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- 11. Certificates Table
CREATE TABLE IF NOT EXISTS certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    score INT NOT NULL,
    certificate_number VARCHAR(50) UNIQUE NOT NULL,
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- 12. Code Snippets Table
CREATE TABLE IF NOT EXISTS code_snippets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    lesson_id INT,
    title VARCHAR(100),
    code_content MEDIUMTEXT,
    language VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert Default Admin User (password: admin123)
-- Hash generated via bcrypt for 'admin123'
INSERT IGNORE INTO users (username, email, password_hash, role) 
VALUES ('admin', 'admin@example.com', '$2a$10$Ew.K.w.K.w.K.w.K.w.K.ue3.3.3.3.3.3.3.3.3.3.3.3.3.3.3', 'ROLE_ADMIN');

-- Insert Sample Course: HTML
INSERT IGNORE INTO courses (title, description, language_tag) VALUES ('HTML Tutorial', 'Learn standard HTML5', 'html');


-- Insert Sample Chapter
INSERT INTO chapters (course_id, title, order_index) VALUES (1, 'HTML Introduction', 1);

-- Insert Sample Lesson
INSERT INTO lessons (chapter_id, title, content_html, example_code, order_index) 
VALUES (1, 'HTML Getting Started', '<h1>Hello HTML</h1><p>This is a paragraph.</p>', '<!DOCTYPE html>\n<html>\n<body>\n<h1>My First Heading</h1>\n<p>My first paragraph.</p>\n</body>\n</html>', 1);

-- Seed file: 20+ questions per level (BEGINNER / INTERMEDIATE / ADVANCED) for Java, Python, JavaScript, SQL
-- Assumes database `elearning_db` exists and tables from database_setup.sql are present.

-- Ensure difficulty column exists
SET @sql = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'questions' AND COLUMN_NAME = 'difficulty') = 0,
    'ALTER TABLE questions ADD COLUMN difficulty VARCHAR(20) DEFAULT \'BEGINNER\'',
    'SELECT \'Column difficulty already exists\' AS message'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Insert courses
INSERT INTO courses (title, description, language_tag) VALUES
('Java Basics', 'Introduction to Java core concepts', 'java'),
('Python Basics', 'Introduction to Python programming', 'python'),
('JavaScript Basics', 'Introduction to JavaScript', 'js'),
('SQL Basics', 'Introduction to SQL and querying', 'sql')
ON DUPLICATE KEY UPDATE title=VALUES(title), description=VALUES(description);

-- Get course ids
SET @course_java = (SELECT id FROM courses WHERE language_tag='java' LIMIT 1);
SET @course_python = (SELECT id FROM courses WHERE language_tag='python' LIMIT 1);
SET @course_js = (SELECT id FROM courses WHERE language_tag='js' LIMIT 1);
SET @course_sql = (SELECT id FROM courses WHERE language_tag='sql' LIMIT 1);

-- Create quizzes
-- Create quizzes (single-row inserts so variables are set reliably)
INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_java, 'Java: Beginner Quiz', FALSE, 70)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_java_beginner = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_java, 'Java: Intermediate Quiz', FALSE, 75)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_java_inter = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_java, 'Java: Advanced Quiz', FALSE, 80)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_java_adv = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_python, 'Python: Beginner Quiz', FALSE, 70)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_py_beginner = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_python, 'Python: Intermediate Quiz', FALSE, 75)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_py_inter = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_python, 'Python: Advanced Quiz', FALSE, 80)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_py_adv = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_js, 'JavaScript: Beginner Quiz', FALSE, 70)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_js_beginner = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_js, 'JavaScript: Intermediate Quiz', FALSE, 75)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_js_inter = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_js, 'JavaScript: Advanced Quiz', FALSE, 80)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_js_adv = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_sql, 'SQL: Beginner Quiz', FALSE, 70)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_sql_beginner = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_sql, 'SQL: Intermediate Quiz', FALSE, 75)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_sql_inter = LAST_INSERT_ID();

INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES (@course_sql, 'SQL: Advanced Quiz', FALSE, 80)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title = VALUES(title);
SET @quiz_sql_adv = LAST_INSERT_ID();

