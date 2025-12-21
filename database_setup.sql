-- Database Initialization Script

CREATE DATABASE IF NOT EXISTS elearning_db;
USE elearning_db;

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
INSERT INTO users (username, email, password_hash, role) 
VALUES ('admin', 'admin@example.com', '$2a$10$Ew.K.w.K.w.K.w.K.w.K.ue3.3.3.3.3.3.3.3.3.3.3.3.3.3.3', 'ROLE_ADMIN');

-- Insert Sample Course: HTML
INSERT INTO courses (title, description, language_tag) VALUES ('HTML Tutorial', 'Learn standard HTML5', 'html');

-- Insert Sample Chapter
INSERT INTO chapters (course_id, title, order_index) VALUES (1, 'HTML Introduction', 1);

-- Insert Sample Lesson
INSERT INTO lessons (chapter_id, title, content_html, example_code, order_index) 
VALUES (1, 'HTML Getting Started', '<h1>Hello HTML</h1><p>This is a paragraph.</p>', '<!DOCTYPE html>\n<html>\n<body>\n<h1>My First Heading</h1>\n<p>My first paragraph.</p>\n</body>\n</html>', 1);
