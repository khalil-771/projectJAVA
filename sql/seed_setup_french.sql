-- Setup file: Initialization des cours et quiz en Français (Tous les langages)
USE quiztests;

-- Ensure difficulty column
SET @sql = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'questions' AND COLUMN_NAME = 'difficulty') = 0,
    'ALTER TABLE questions ADD COLUMN difficulty VARCHAR(20) DEFAULT \'BEGINNER\'',
    'SELECT \'Column difficulty already exists\' AS message'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Courses
INSERT INTO courses (title, description, language_tag) VALUES
('Java Basics', 'Concepts Java', 'java'),
('Python Basics', 'Programmation Python', 'python'),
('JavaScript Basics', 'Web JavaScript', 'js'),
('SQL Basics', 'Base de données SQL', 'sql'),
('C++ Basics', 'Programmation C++', 'cpp'),
('C Basics', 'Programmation C', 'c'),
('HTML Basics', 'Structure Web HTML', 'html'),
('CSS Basics', 'Styles Web CSS', 'css'),
('Kotlin Basics', 'Programmation Kotlin', 'kotlin'),
('PHP Basics', 'Scripting PHP', 'php')
ON DUPLICATE KEY UPDATE title=VALUES(title), description=VALUES(description);

-- Get Course IDs
SET @course_java = (SELECT id FROM courses WHERE language_tag='java' LIMIT 1);
SET @course_py = (SELECT id FROM courses WHERE language_tag='python' LIMIT 1);
SET @course_js = (SELECT id FROM courses WHERE language_tag='js' LIMIT 1);
SET @course_sql = (SELECT id FROM courses WHERE language_tag='sql' LIMIT 1);
SET @course_cpp = (SELECT id FROM courses WHERE language_tag='cpp' LIMIT 1);
SET @course_c = (SELECT id FROM courses WHERE language_tag='c' LIMIT 1);
SET @course_html = (SELECT id FROM courses WHERE language_tag='html' LIMIT 1);
SET @course_css = (SELECT id FROM courses WHERE language_tag='css' LIMIT 1);
SET @course_kt = (SELECT id FROM courses WHERE language_tag='kotlin' LIMIT 1);
SET @course_php = (SELECT id FROM courses WHERE language_tag='php' LIMIT 1);

-- Quizzes (3 levels per language)
INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) VALUES 
-- Java
(@course_java, 'Java: Quiz Débutant', FALSE, 70), (@course_java, 'Java: Quiz Intermédiaire', FALSE, 75), (@course_java, 'Java: Quiz Avancé', FALSE, 80),
-- Python
(@course_py, 'Python: Quiz Débutant', FALSE, 70), (@course_py, 'Python: Quiz Intermédiaire', FALSE, 75), (@course_py, 'Python: Quiz Avancé', FALSE, 80),
-- JS
(@course_js, 'JavaScript: Quiz Débutant', FALSE, 70), (@course_js, 'JavaScript: Quiz Intermédiaire', FALSE, 75), (@course_js, 'JavaScript: Quiz Avancé', FALSE, 80),
-- SQL
(@course_sql, 'SQL: Quiz Débutant', FALSE, 70), (@course_sql, 'SQL: Quiz Intermédiaire', FALSE, 75), (@course_sql, 'SQL: Quiz Avancé', FALSE, 80),
-- C++
(@course_cpp, 'C++: Quiz Débutant', FALSE, 70), (@course_cpp, 'C++: Quiz Intermédiaire', FALSE, 75), (@course_cpp, 'C++: Quiz Avancé', FALSE, 80),
-- C
(@course_c, 'C: Quiz Débutant', FALSE, 70), (@course_c, 'C: Quiz Intermédiaire', FALSE, 75), (@course_c, 'C: Quiz Avancé', FALSE, 80),
-- HTML
(@course_html, 'HTML: Quiz Débutant', FALSE, 70), (@course_html, 'HTML: Quiz Intermédiaire', FALSE, 75), (@course_html, 'HTML: Quiz Avancé', FALSE, 80),
-- CSS
(@course_css, 'CSS: Quiz Débutant', FALSE, 70), (@course_css, 'CSS: Quiz Intermédiaire', FALSE, 75), (@course_css, 'CSS: Quiz Avancé', FALSE, 80),
-- Kotlin
(@course_kt, 'Kotlin: Quiz Débutant', FALSE, 70), (@course_kt, 'Kotlin: Quiz Intermédiaire', FALSE, 75), (@course_kt, 'Kotlin: Quiz Avancé', FALSE, 80),
-- PHP
(@course_php, 'PHP: Quiz Débutant', FALSE, 70), (@course_php, 'PHP: Quiz Intermédiaire', FALSE, 75), (@course_php, 'PHP: Quiz Avancé', FALSE, 80)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title=VALUES(title);

-- Clean questions/answers to start fresh
DELETE FROM answers;
DELETE FROM questions;
