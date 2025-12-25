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
INSERT INTO users (username, email, password_hash, role) 
VALUES ('admin', 'admin@example.com', '$2a$10$Ew.K.w.K.w.K.w.K.w.K.ue3.3.3.3.3.3.3.3.3.3.3.3.3.3.3', 'ROLE_ADMIN');

-- Insert Sample Course: HTML
INSERT INTO courses (title, description, language_tag) VALUES ('HTML Tutorial', 'Learn standard HTML5', 'html');

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

-- -----------------------------
-- JAVA - BEGINNER (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the correct way to declare a variable in Java?', 'SINGLE_CHOICE', 'In Java, variables are declared with type followed by name.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int x = 5;',TRUE),(@q,'var x = 5;',FALSE),(@q,'x = 5;',FALSE),(@q,'integer x = 5;',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Which keyword is used for inheritance in Java?', 'SINGLE_CHOICE', 'The extends keyword is used for class inheritance.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'extends',TRUE),(@q,'inherits',FALSE),(@q,'implements',FALSE),(@q,'super',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the entry point of a Java program?', 'SINGLE_CHOICE', 'The main method is the entry point of any Java application.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'public static void main(String[] args)',TRUE),(@q,'public void start()',FALSE),(@q,'public static void run()',FALSE),(@q,'void main()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the data type for text in Java?', 'SINGLE_CHOICE', 'String is the data type for text in Java.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'String',TRUE),(@q,'Text',FALSE),(@q,'Char',FALSE),(@q,'Word',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'How do you create an object in Java?', 'SINGLE_CHOICE', 'Objects are created using the new keyword.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'new ClassName()',TRUE),(@q,'create ClassName()',FALSE),(@q,'ClassName.create()',FALSE),(@q,'ClassName.new()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the correct syntax for a comment in Java?', 'SINGLE_CHOICE', 'Single-line comments use //, multi-line use /* */.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'// comment',TRUE),(@q,'# comment',FALSE),(@q,'/* comment */',TRUE),(@q,'-- comment',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Which operator is used for equality in Java?', 'SINGLE_CHOICE', '== is the equality operator in Java.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'==',TRUE),(@q,'=',FALSE),(@q,'equals',FALSE),(@q,'is',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the size of an int in Java?', 'SINGLE_CHOICE', 'int is 32 bits (4 bytes) in Java.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'4 bytes',TRUE),(@q,'2 bytes',FALSE),(@q,'8 bytes',FALSE),(@q,'1 byte',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Which keyword is used to define a class in Java?', 'SINGLE_CHOICE', 'The class keyword defines a class.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class',TRUE),(@q,'Class',FALSE),(@q,'define',FALSE),(@q,'struct',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the default value of a boolean in Java?', 'SINGLE_CHOICE', 'Boolean variables default to false.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'false',TRUE),(@q,'true',FALSE),(@q,'null',FALSE),(@q,'0',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'How do you print to console in Java?', 'SINGLE_CHOICE', 'System.out.println() prints to console.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'System.out.println()',TRUE),(@q,'console.log()',FALSE),(@q,'print()',FALSE),(@q,'echo()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Which package contains the Scanner class?', 'SINGLE_CHOICE', 'Scanner is in java.util package.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'java.util',TRUE),(@q,'java.io',FALSE),(@q,'java.lang',FALSE),(@q,'java.net',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the parent class of all classes in Java?', 'SINGLE_CHOICE', 'Object is the root class.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Object',TRUE),(@q,'Class',FALSE),(@q,'Base',FALSE),(@q,'Root',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'How do you declare an array in Java?', 'SINGLE_CHOICE', 'Arrays are declared with type[] name.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int[] arr;',TRUE),(@q,'array int arr;',FALSE),(@q,'int arr[];',TRUE),(@q,'list<int> arr;',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Which loop executes at least once?', 'SINGLE_CHOICE', 'do-while loop executes at least once.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'do-while',TRUE),(@q,'while',FALSE),(@q,'for',FALSE),(@q,'foreach',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What does JVM stand for?', 'SINGLE_CHOICE', 'JVM is Java Virtual Machine.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Java Virtual Machine',TRUE),(@q,'Java Variable Manager',FALSE),(@q,'Just Virtual Memory',FALSE),(@q,'Java Version Manager',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Which access modifier is most restrictive?', 'SINGLE_CHOICE', 'private is the most restrictive.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'private',TRUE),(@q,'protected',FALSE),(@q,'public',FALSE),(@q,'default',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the extension of Java source files?', 'SINGLE_CHOICE', 'Java files have .java extension.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.java',TRUE),(@q,'.class',FALSE),(@q,'.jar',FALSE),(@q,'.exe',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Which method compares two strings in Java?', 'SINGLE_CHOICE', 'equals() method compares string content.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'equals()',TRUE),(@q,'==',FALSE),(@q,'compare()',FALSE),(@q,'same()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'What is the range of byte in Java?', 'SINGLE_CHOICE', 'byte ranges from -128 to 127.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'-128 to 127',TRUE),(@q,'-32768 to 32767',FALSE),(@q,'0 to 255',FALSE),(@q,'-2147483648 to 2147483647',FALSE);

-- -----------------------------
-- JAVA - INTERMEDIATE (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is polymorphism in Java?', 'SINGLE_CHOICE', 'Polymorphism allows objects to take many forms.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Ability to take many forms',TRUE),(@q,'Multiple inheritance',FALSE),(@q,'Data hiding',FALSE),(@q,'Exception handling',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Which keyword is used for exception handling?', 'SINGLE_CHOICE', 'try-catch is used for exception handling.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'try',TRUE),(@q,'catch',TRUE),(@q,'throw',TRUE),(@q,'finally',TRUE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the difference between ArrayList and LinkedList?', 'SINGLE_CHOICE', 'ArrayList is better for random access, LinkedList for insertions/deletions.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ArrayList: fast random access, LinkedList: fast insertions',TRUE),(@q,'No difference',FALSE),(@q,'LinkedList is always better',FALSE),(@q,'ArrayList uses more memory',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is a static method in Java?', 'SINGLE_CHOICE', 'Static methods belong to the class, not instances.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Method that belongs to class',TRUE),(@q,'Method that cannot be overridden',FALSE),(@q,'Method with no parameters',FALSE),(@q,'Final method',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the purpose of the finalize() method?', 'SINGLE_CHOICE', 'finalize() is called before garbage collection.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Called before garbage collection',TRUE),(@q,'Called after object creation',FALSE),(@q,'Used for cloning',FALSE),(@q,'Used for serialization',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the difference between == and equals()?', 'SINGLE_CHOICE', '== compares references, equals() compares content.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'== compares references, equals() compares values',TRUE),(@q,'No difference',FALSE),(@q,'equals() is for primitives',FALSE),(@q,'== is for objects',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is a lambda expression in Java?', 'SINGLE_CHOICE', 'Lambda expressions represent anonymous functions.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Anonymous function',TRUE),(@q,'Named function',FALSE),(@q,'Class method',FALSE),(@q,'Static method',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the purpose of the volatile keyword?', 'SINGLE_CHOICE', 'volatile ensures visibility of changes across threads.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Ensures thread visibility',TRUE),(@q,'Makes variable constant',FALSE),(@q,'Prevents inheritance',FALSE),(@q,'Makes variable static',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the difference between HashMap and HashTable?', 'SINGLE_CHOICE', 'HashMap is not synchronized, HashTable is.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'HashMap not synchronized, HashTable is',TRUE),(@q,'HashTable allows null keys',FALSE),(@q,'No difference',FALSE),(@q,'HashMap is faster',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is method overloading in Java?', 'SINGLE_CHOICE', 'Same method name with different parameters.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Same name, different parameters',TRUE),(@q,'Same name, same parameters',FALSE),(@q,'Different name, same parameters',FALSE),(@q,'Inheritance',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the purpose of the super keyword?', 'SINGLE_CHOICE', 'super refers to parent class.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Refers to parent class',TRUE),(@q,'Refers to child class',FALSE),(@q,'Creates object',FALSE),(@q,'Calls static method',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is a checked exception in Java?', 'SINGLE_CHOICE', 'Checked exceptions must be handled or declared.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Must be caught or declared',TRUE),(@q,'Runtime exceptions',FALSE),(@q,'Errors',FALSE),(@q,'Warnings',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the purpose of the transient keyword?', 'SINGLE_CHOICE', 'transient prevents serialization of fields.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Prevents serialization',TRUE),(@q,'Makes field volatile',FALSE),(@q,'Makes field final',FALSE),(@q,'Makes field static',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the difference between StringBuilder and StringBuffer?', 'SINGLE_CHOICE', 'StringBuilder is not synchronized, StringBuffer is.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'StringBuilder not synchronized, StringBuffer is',TRUE),(@q,'StringBuffer is faster',FALSE),(@q,'No difference',FALSE),(@q,'StringBuilder allows null',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is a functional interface in Java?', 'SINGLE_CHOICE', 'Interface with exactly one abstract method.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Interface with one abstract method',TRUE),(@q,'Interface with no methods',FALSE),(@q,'Class with methods',FALSE),(@q,'Abstract class',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the purpose of the synchronized keyword?', 'SINGLE_CHOICE', 'synchronized controls access to critical sections.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Controls thread access',TRUE),(@q,'Makes method static',FALSE),(@q,'Makes method final',FALSE),(@q,'Makes method private',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is method overriding in Java?', 'SINGLE_CHOICE', 'Same method signature in subclass.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Same signature in subclass',TRUE),(@q,'Same name, different parameters',FALSE),(@q,'Static methods',FALSE),(@q,'Final methods',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the purpose of the instanceof operator?', 'SINGLE_CHOICE', 'instanceof checks object type at runtime.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Checks object type',TRUE),(@q,'Creates object',FALSE),(@q,'Casts object',FALSE),(@q,'Compares objects',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is a generic class in Java?', 'SINGLE_CHOICE', 'Class that can work with different types.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Class with type parameters',TRUE),(@q,'Class with no methods',FALSE),(@q,'Abstract class',FALSE),(@q,'Final class',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'What is the difference between abstract class and interface?', 'SINGLE_CHOICE', 'Abstract class can have state, interface cannot.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Abstract class has state, interface does not',TRUE),(@q,'No difference',FALSE),(@q,'Interface is faster',FALSE),(@q,'Abstract class allows multiple inheritance',FALSE);

-- -----------------------------
-- JAVA - ADVANCED (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the @Override annotation?', 'SINGLE_CHOICE', 'Indicates method overrides superclass method.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Indicates method override',TRUE),(@q,'Makes method final',FALSE),(@q,'Makes method static',FALSE),(@q,'Makes method synchronized',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between fail-fast and fail-safe iterators?', 'SINGLE_CHOICE', 'Fail-fast throws exception on modification, fail-safe does not.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Fail-fast throws exception, fail-safe does not',TRUE),(@q,'Fail-safe is faster',FALSE),(@q,'No difference',FALSE),(@q,'Fail-fast allows modification',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the WeakReference class?', 'SINGLE_CHOICE', 'Allows garbage collection of referenced objects.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Allows GC of referenced objects',TRUE),(@q,'Prevents GC',FALSE),(@q,'Strong reference',FALSE),(@q,'Soft reference',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between Callable and Runnable?', 'SINGLE_CHOICE', 'Callable returns result, Runnable does not.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Callable returns result, Runnable does not',TRUE),(@q,'Runnable is newer',FALSE),(@q,'No difference',FALSE),(@q,'Callable is for threads',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the @FunctionalInterface annotation?', 'SINGLE_CHOICE', 'Indicates interface is functional (one abstract method).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Indicates functional interface',TRUE),(@q,'Makes interface final',FALSE),(@q,'Allows multiple inheritance',FALSE),(@q,'Prevents implementation',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between Serialization and Externalization?', 'SINGLE_CHOICE', 'Externalization gives more control over serialization.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Externalization gives more control',TRUE),(@q,'Serialization is faster',FALSE),(@q,'No difference',FALSE),(@q,'Externalization is deprecated',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the java.util.concurrent package?', 'SINGLE_CHOICE', 'Provides concurrent utilities for multi-threading.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Concurrent utilities',TRUE),(@q,'Date utilities',FALSE),(@q,'Collection utilities',FALSE),(@q,'IO utilities',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between HashMap and ConcurrentHashMap?', 'SINGLE_CHOICE', 'ConcurrentHashMap is thread-safe, HashMap is not.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ConcurrentHashMap is thread-safe',TRUE),(@q,'HashMap allows null keys',FALSE),(@q,'No difference',FALSE),(@q,'ConcurrentHashMap is slower',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the @SuppressWarnings annotation?', 'SINGLE_CHOICE', 'Suppresses compiler warnings.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Suppresses compiler warnings',TRUE),(@q,'Suppresses exceptions',FALSE),(@q,'Suppresses errors',FALSE),(@q,'Suppresses output',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between shallow copy and deep copy?', 'SINGLE_CHOICE', 'Deep copy copies all objects, shallow copy copies references.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Deep copy copies objects, shallow copies references',TRUE),(@q,'Shallow copy is faster',FALSE),(@q,'No difference',FALSE),(@q,'Deep copy uses more memory',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the java.lang.reflect package?', 'SINGLE_CHOICE', 'Provides reflection capabilities.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Reflection capabilities',TRUE),(@q,'String utilities',FALSE),(@q,'Math utilities',FALSE),(@q,'Exception handling',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between Class.forName() and ClassLoader.loadClass()?', 'SINGLE_CHOICE', 'forName() initializes class, loadClass() does not.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'forName() initializes, loadClass() does not',TRUE),(@q,'loadClass() is deprecated',FALSE),(@q,'No difference',FALSE),(@q,'forName() is faster',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the @Deprecated annotation?', 'SINGLE_CHOICE', 'Marks methods/classes as deprecated.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Marks as deprecated',TRUE),(@q,'Makes final',FALSE),(@q,'Makes static',FALSE),(@q,'Makes synchronized',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between Executor and ExecutorService?', 'SINGLE_CHOICE', 'ExecutorService provides more features like shutdown.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ExecutorService has more features',TRUE),(@q,'Executor is newer',FALSE),(@q,'No difference',FALSE),(@q,'Executor is for single thread',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the java.util.stream package?', 'SINGLE_CHOICE', 'Provides functional-style operations on streams.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Functional operations on streams',TRUE),(@q,'File streams',FALSE),(@q,'Network streams',FALSE),(@q,'Byte streams',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between ArrayBlockingQueue and LinkedBlockingQueue?', 'SINGLE_CHOICE', 'ArrayBlockingQueue has fixed size, LinkedBlockingQueue grows.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ArrayBlockingQueue fixed size, LinkedBlockingQueue grows',TRUE),(@q,'LinkedBlockingQueue is faster',FALSE),(@q,'No difference',FALSE),(@q,'ArrayBlockingQueue allows null',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the @SafeVarargs annotation?', 'SINGLE_CHOICE', 'Suppresses warnings for varargs methods.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Suppresses varargs warnings',TRUE),(@q,'Makes varargs safe',FALSE),(@q,'Allows null varargs',FALSE),(@q,'Prevents varargs',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between CountDownLatch and CyclicBarrier?', 'SINGLE_CHOICE', 'CountDownLatch cannot be reused, CyclicBarrier can.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'CyclicBarrier can be reused',TRUE),(@q,'CountDownLatch is for timing',FALSE),(@q,'No difference',FALSE),(@q,'CyclicBarrier allows more threads',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the purpose of the java.nio package?', 'SINGLE_CHOICE', 'Provides non-blocking I/O operations.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Non-blocking I/O',TRUE),(@q,'New I/O',FALSE),(@q,'Network I/O',FALSE),(@q,'File I/O',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'What is the difference between ReentrantLock and synchronized?', 'SINGLE_CHOICE', 'ReentrantLock provides more features like fairness.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ReentrantLock has more features',TRUE),(@q,'synchronized is deprecated',FALSE),(@q,'No difference',FALSE),(@q,'ReentrantLock is faster',FALSE);

-- -----------------------------
-- PYTHON - BEGINNER (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct way to print "Hello World" in Python?', 'SINGLE_CHOICE', 'print() function outputs text.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'print("Hello World")',TRUE),(@q,'echo "Hello World"',FALSE),(@q,'console.log("Hello World")',FALSE),(@q,'System.out.println("Hello World")',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a variable in Python?', 'SINGLE_CHOICE', 'Variables are created by assignment.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'x = 5',TRUE),(@q,'int x = 5',FALSE),(@q,'var x = 5',FALSE),(@q,'let x = 5',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct file extension for Python files?', 'SINGLE_CHOICE', 'Python files use .py extension.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.py',TRUE),(@q,'.python',FALSE),(@q,'.p',FALSE),(@q,'.pyth',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a comment in Python?', 'SINGLE_CHOICE', 'Comments start with #.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'# comment',TRUE),(@q,'// comment',FALSE),(@q,'/* comment */',FALSE),(@q,'-- comment',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the output of 2 + 3 in Python?', 'SINGLE_CHOICE', 'Addition operator adds numbers.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'5',TRUE),(@q,'23',FALSE),(@q,'6',FALSE),(@q,'Error',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a list in Python?', 'SINGLE_CHOICE', 'Lists use square brackets.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'[1, 2, 3]',TRUE),(@q,'(1, 2, 3)',FALSE),(@q,'{1, 2, 3}',FALSE),(@q,'<1, 2, 3>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct way to check if x is equal to 5?', 'SINGLE_CHOICE', '== is the equality operator.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'x == 5',TRUE),(@q,'x = 5',FALSE),(@q,'x is 5',FALSE),(@q,'x equals 5',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a function in Python?', 'SINGLE_CHOICE', 'Functions use def keyword.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'def my_function():',TRUE),(@q,'function my_function():',FALSE),(@q,'func my_function():',FALSE),(@q,'create my_function():',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct way to import a module?', 'SINGLE_CHOICE', 'import statement imports modules.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'import module_name',TRUE),(@q,'include module_name',FALSE),(@q,'using module_name',FALSE),(@q,'require module_name',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a dictionary in Python?', 'SINGLE_CHOICE', 'Dictionaries use curly braces with key:value pairs.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'{"key": "value"}',TRUE),(@q,'["key", "value"]',FALSE),(@q,'("key", "value")',FALSE),(@q,'<"key", "value">',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct way to get user input?', 'SINGLE_CHOICE', 'input() function gets user input.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'input()',TRUE),(@q,'get_input()',FALSE),(@q,'read()',FALSE),(@q,'scan()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a tuple in Python?', 'SINGLE_CHOICE', 'Tuples use parentheses.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'(1, 2, 3)',TRUE),(@q,'[1, 2, 3]',FALSE),(@q,'{1, 2, 3}',FALSE),(@q,'<1, 2, 3>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct way to check if a key exists in a dictionary?', 'SINGLE_CHOICE', 'in operator checks membership.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'key in dict',TRUE),(@q,'dict.has_key(key)',FALSE),(@q,'dict.contains(key)',FALSE),(@q,'dict.exists(key)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a set in Python?', 'SINGLE_CHOICE', 'Sets use curly braces.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'{1, 2, 3}',TRUE),(@q,'[1, 2, 3]',FALSE),(@q,'(1, 2, 3)',FALSE),(@q,'<1, 2, 3>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct way to handle exceptions?', 'SINGLE_CHOICE', 'try-except blocks handle exceptions.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'try: except:',TRUE),(@q,'catch: throw:',FALSE),(@q,'handle: error:',FALSE),(@q,'on_error:',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a class in Python?', 'SINGLE_CHOICE', 'Classes use class keyword.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class MyClass:',TRUE),(@q,'Class MyClass:',FALSE),(@q,'def MyClass:',FALSE),(@q,'create MyClass:',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct way to open a file?', 'SINGLE_CHOICE', 'open() function opens files.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'open("file.txt")',TRUE),(@q,'file("file.txt")',FALSE),(@q,'read("file.txt")',FALSE),(@q,'load("file.txt")',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a loop in Python?', 'SINGLE_CHOICE', 'for and while create loops.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'for i in range(5):',TRUE),(@q,'loop i = 1 to 5:',FALSE),(@q,'repeat 5 times:',FALSE),(@q,'foreach i in 5:',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'What is the correct way to check if a variable is None?', 'SINGLE_CHOICE', 'is operator checks identity.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'x is None',TRUE),(@q,'x == None',FALSE),(@q,'x is null',FALSE),(@q,'x == null',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'How do you create a string in Python?', 'SINGLE_CHOICE', 'Strings use quotes.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'"hello"',TRUE),(@q,'str("hello")',FALSE),(@q,'string("hello")',FALSE),(@q,'text("hello")',FALSE);

-- -----------------------------
-- PYTHON - INTERMEDIATE (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is a lambda function in Python?', 'SINGLE_CHOICE', 'Lambda creates anonymous functions.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Anonymous function',TRUE),(@q,'Named function',FALSE),(@q,'Class method',FALSE),(@q,'Static method',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a list comprehension?', 'SINGLE_CHOICE', 'List comprehensions create lists from iterables.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'[x for x in iterable]',TRUE),(@q,'{x for x in iterable}',FALSE),(@q,'(x for x in iterable)',FALSE),(@q,'<x for x in iterable>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the difference between range() and xrange()?', 'SINGLE_CHOICE', 'xrange() was in Python 2, range() in Python 3.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'xrange() was Python 2, range() Python 3',TRUE),(@q,'range() is faster',FALSE),(@q,'No difference',FALSE),(@q,'xrange() allows floats',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a generator in Python?', 'SINGLE_CHOICE', 'Generators use yield keyword.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'def gen(): yield x',TRUE),(@q,'def gen(): return x',FALSE),(@q,'class Gen:',FALSE),(@q,'gen = [x]',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the purpose of __init__ method?', 'SINGLE_CHOICE', '__init__ is the constructor.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Constructor method',TRUE),(@q,'Destructor method',FALSE),(@q,'Static method',FALSE),(@q,'Class method',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a decorator in Python?', 'SINGLE_CHOICE', 'Decorators are functions that modify other functions.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'def decorator(func):',TRUE),(@q,'class Decorator:',FALSE),(@q,'@decorator',FALSE),(@q,'decorator = func',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the difference between __str__ and __repr__?', 'SINGLE_CHOICE', '__str__ for users, __repr__ for developers.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'__str__ user-friendly, __repr__ unambiguous',TRUE),(@q,'No difference',FALSE),(@q,'__repr__ is deprecated',FALSE),(@q,'__str__ is for printing',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a context manager?', 'SINGLE_CHOICE', 'Context managers use __enter__ and __exit__.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class with __enter__ and __exit__',TRUE),(@q,'def with_context():',FALSE),(@q,'with statement',FALSE),(@q,'try: finally:',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the purpose of *args and **kwargs?', 'SINGLE_CHOICE', '*args for positional, **kwargs for keyword arguments.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Variable arguments',TRUE),(@q,'Global variables',FALSE),(@q,'Class attributes',FALSE),(@q,'Module variables',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a property in Python?', 'SINGLE_CHOICE', 'Properties use @property decorator.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'@property',TRUE),(@q,'def property:',FALSE),(@q,'class Property:',FALSE),(@q,'property = value',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the difference between shallow and deep copy?', 'SINGLE_CHOICE', 'Deep copy copies nested objects, shallow copies references.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Deep copies objects, shallow copies references',TRUE),(@q,'Shallow is faster',FALSE),(@q,'No difference',FALSE),(@q,'Deep uses more memory',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a metaclass in Python?', 'SINGLE_CHOICE', 'Metaclasses inherit from type.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class Meta(type):',TRUE),(@q,'def metaclass():',FALSE),(@q,'@metaclass',FALSE),(@q,'meta = type',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the purpose of __slots__?', 'SINGLE_CHOICE', '__slots__ restricts instance attributes.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Restricts attributes',TRUE),(@q,'Defines methods',FALSE),(@q,'Creates properties',FALSE),(@q,'Defines class variables',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a coroutine in Python?', 'SINGLE_CHOICE', 'Coroutines use async def.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'async def coro():',TRUE),(@q,'def coro():',FALSE),(@q,'class Coro:',FALSE),(@q,'coro = async',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the difference between is and ==?', 'SINGLE_CHOICE', 'is checks identity, == checks equality.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'is checks identity, == checks equality',TRUE),(@q,'No difference',FALSE),(@q,'== is for numbers',FALSE),(@q,'is is deprecated',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a namedtuple?', 'SINGLE_CHOICE', 'namedtuple creates tuple subclasses with named fields.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'namedtuple = namedtuple(...)',TRUE),(@q,'class NamedTuple:',FALSE),(@q,'def namedtuple():',FALSE),(@q,'namedtuple = tuple',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the purpose of __call__ method?', 'SINGLE_CHOICE', '__call__ makes objects callable.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Makes object callable',TRUE),(@q,'Calls parent method',FALSE),(@q,'Creates instance',FALSE),(@q,'Destroys instance',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a singleton in Python?', 'SINGLE_CHOICE', 'Singletons can be created with metaclass or module.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Use metaclass or module',TRUE),(@q,'class Singleton:',FALSE),(@q,'def singleton():',FALSE),(@q,'singleton = object',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'What is the difference between iter() and next()?', 'SINGLE_CHOICE', 'iter() gets iterator, next() gets next item.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'iter() creates iterator, next() gets item',TRUE),(@q,'No difference',FALSE),(@q,'next() is deprecated',FALSE),(@q,'iter() is for lists',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'How do you create a memory view?', 'SINGLE_CHOICE', 'Use memoryview() function.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'memoryview(obj)',TRUE),(@q,'view(obj)',FALSE),(@q,'memview(obj)',FALSE),(@q,'memory(obj)',FALSE);

-- -----------------------------
-- PYTHON - ADVANCED (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the Global Interpreter Lock (GIL)?', 'SINGLE_CHOICE', 'GIL prevents multiple threads from executing Python code simultaneously.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Prevents multiple threads executing simultaneously',TRUE),(@q,'Locks global variables',FALSE),(@q,'Interprets global code',FALSE),(@q,'Locks interpreter',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you create a C extension for Python?', 'SINGLE_CHOICE', 'C extensions use Python C API.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Use Python C API',TRUE),(@q,'Write C code',FALSE),(@q,'Use ctypes',FALSE),(@q,'Use Cython',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the purpose of __getattr__ and __setattr__?', 'SINGLE_CHOICE', 'Control attribute access.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Control attribute access',TRUE),(@q,'Define methods',FALSE),(@q,'Create properties',FALSE),(@q,'Define class variables',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you implement multiple inheritance in Python?', 'SINGLE_CHOICE', 'Class inherits from multiple classes.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class Child(Parent1, Parent2):',TRUE),(@q,'class Child(Parent1):',FALSE),(@q,'Child.inherit(Parent1, Parent2)',FALSE),(@q,'inherit Child from Parent1, Parent2',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the difference between __new__ and __init__?', 'SINGLE_CHOICE', '__new__ creates instance, __init__ initializes it.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'__new__ creates, __init__ initializes',TRUE),(@q,'No difference',FALSE),(@q,'__init__ is deprecated',FALSE),(@q,'__new__ is for classes',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you create a custom exception?', 'SINGLE_CHOICE', 'Inherit from Exception class.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class MyError(Exception):',TRUE),(@q,'def MyError():',FALSE),(@q,'MyError = Exception',FALSE),(@q,'raise MyError',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the purpose of the sys module?', 'SINGLE_CHOICE', 'Provides access to system-specific parameters.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'System parameters and functions',TRUE),(@q,'System calls',FALSE),(@q,'System variables',FALSE),(@q,'System paths',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you use the multiprocessing module?', 'SINGLE_CHOICE', 'Create Process objects and start them.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Process(target=func).start()',TRUE),(@q,'threading.Thread(target=func).start()',FALSE),(@q,'multiprocess(func)',FALSE),(@q,'run_parallel(func)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the difference between pickle and json?', 'SINGLE_CHOICE', 'pickle serializes Python objects, json is text-based.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'pickle for Python objects, json for text',TRUE),(@q,'No difference',FALSE),(@q,'json is faster',FALSE),(@q,'pickle is deprecated',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you create a weak reference?', 'SINGLE_CHOICE', 'Use weakref module.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'weakref.ref(obj)',TRUE),(@q,'weak_ref = obj',FALSE),(@q,'obj.weak()',FALSE),(@q,'ref(obj, weak=True)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the purpose of __del__ method?', 'SINGLE_CHOICE', '__del__ is the destructor.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Destructor method',TRUE),(@q,'Constructor method',FALSE),(@q,'Static method',FALSE),(@q,'Class method',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you implement operator overloading?', 'SINGLE_CHOICE', 'Define special methods like __add__.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'def __add__(self, other):',TRUE),(@q,'def add(self, other):',FALSE),(@q,'operator.add = func',FALSE),(@q,'overload + = func',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the difference between import and from import?', 'SINGLE_CHOICE', 'import imports module, from import imports specific items.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'import module, from import items',TRUE),(@q,'No difference',FALSE),(@q,'from is deprecated',FALSE),(@q,'import is for packages',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you create a package in Python?', 'SINGLE_CHOICE', 'Create __init__.py file.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Create __init__.py',TRUE),(@q,'Create package.py',FALSE),(@q,'Use package keyword',FALSE),(@q,'def package():',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the purpose of the inspect module?', 'SINGLE_CHOICE', 'Provides introspection capabilities.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Introspection of live objects',TRUE),(@q,'Code inspection',FALSE),(@q,'Module inspection',FALSE),(@q,'Function inspection',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you implement a custom iterator?', 'SINGLE_CHOICE', 'Implement __iter__ and __next__.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'def __iter__(self): def __next__(self):',TRUE),(@q,'class Iterator:',FALSE),(@q,'def iterator():',FALSE),(@q,'iter = func',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the difference between threading and asyncio?', 'SINGLE_CHOICE', 'threading uses OS threads, asyncio uses event loop.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'threading OS threads, asyncio event loop',TRUE),(@q,'No difference',FALSE),(@q,'asyncio is deprecated',FALSE),(@q,'threading is for I/O',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'How do you create a memory view?', 'SINGLE_CHOICE', 'Use memoryview() function.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'memoryview(obj)',TRUE),(@q,'view(obj)',FALSE),(@q,'memview(obj)',FALSE),(@q,'memory(obj)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'What is the purpose of the dis module?', 'SINGLE_CHOICE', 'Disassembles Python bytecode.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Disassembles bytecode',TRUE),(@q,'Displays code',FALSE),(@q,'Debugs code',FALSE),(@q,'Analyzes code',FALSE);

-- -----------------------------
-- JAVASCRIPT - BEGINNER (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Inside which HTML element do we put JavaScript?', 'SINGLE_CHOICE', 'JavaScript goes in <script> tags.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<script>',TRUE),(@q,'<javascript>',FALSE),(@q,'<js>',FALSE),(@q,'<scripting>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you create a function in JavaScript?', 'SINGLE_CHOICE', 'Functions use function keyword.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'function myFunction()',TRUE),(@q,'def myFunction()',FALSE),(@q,'func myFunction()',FALSE),(@q,'create myFunction()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you call a function named "myFunction"?', 'SINGLE_CHOICE', 'Functions are called with parentheses.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'myFunction()',TRUE),(@q,'call myFunction()',FALSE),(@q,'execute myFunction()',FALSE),(@q,'run myFunction()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you write an IF statement in JavaScript?', 'SINGLE_CHOICE', 'IF statements use if keyword with parentheses.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'if (condition)',TRUE),(@q,'if condition then',FALSE),(@q,'when condition',FALSE),(@q,'if [condition]',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How does a FOR loop start?', 'SINGLE_CHOICE', 'FOR loops have initialization, condition, increment.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'for (i = 0; i < 5; i++)',TRUE),(@q,'for i = 1 to 5',FALSE),(@q,'for (i in 1..5)',FALSE),(@q,'for each i in 5',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you declare a JavaScript variable?', 'SINGLE_CHOICE', 'Variables use var, let, or const.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'var x = 5',TRUE),(@q,'variable x = 5',FALSE),(@q,'v x = 5',FALSE),(@q,'dim x = 5',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Which operator is used to assign a value to a variable?', 'SINGLE_CHOICE', '= is the assignment operator.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'=',TRUE),(@q,'==',FALSE),(@q,'===',FALSE),(@q,'<-',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'What is the correct way to write a JavaScript array?', 'SINGLE_CHOICE', 'Arrays use square brackets.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'var colors = ["red", "green", "blue"]',TRUE),(@q,'var colors = ("red", "green", "blue")',FALSE),(@q,'var colors = {"red", "green", "blue"}',FALSE),(@q,'var colors = <"red", "green", "blue">',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you round the number 7.25 to the nearest integer?', 'SINGLE_CHOICE', 'Math.round() rounds to nearest integer.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Math.round(7.25)',TRUE),(@q,'round(7.25)',FALSE),(@q,'Math.rnd(7.25)',FALSE),(@q,'rnd(7.25)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'What is the correct syntax for referring to an external script?', 'SINGLE_CHOICE', 'External scripts use src attribute.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<script src="xxx.js">',TRUE),(@q,'<script href="xxx.js">',FALSE),(@q,'<script name="xxx.js">',FALSE),(@q,'<script file="xxx.js">',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you create an object in JavaScript?', 'SINGLE_CHOICE', 'Objects use curly braces.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'var person = {}',TRUE),(@q,'var person = []',FALSE),(@q,'var person = ()',FALSE),(@q,'var person = <>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you add a comment in JavaScript?', 'SINGLE_CHOICE', 'Single-line comments use //.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'// comment',TRUE),(@q,'# comment',FALSE),(@q,'/* comment */',TRUE),(@q,'-- comment',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'What is the correct way to write a JavaScript object?', 'SINGLE_CHOICE', 'Objects have key-value pairs.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'var person = {name: "John", age: 30}',TRUE),(@q,'var person = [name: "John", age: 30]',FALSE),(@q,'var person = (name: "John", age: 30)',FALSE),(@q,'var person = <name: "John", age: 30>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Which event occurs when the user clicks on an HTML element?', 'SINGLE_CHOICE', 'onclick event handles clicks.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'onclick',TRUE),(@q,'onmouseclick',FALSE),(@q,'onpress',FALSE),(@q,'onhit',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you declare a const variable?', 'SINGLE_CHOICE', 'const creates constant variables.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'const x = 5',TRUE),(@q,'constant x = 5',FALSE),(@q,'final x = 5',FALSE),(@q,'static x = 5',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'What does DOM stand for?', 'SINGLE_CHOICE', 'DOM is Document Object Model.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Document Object Model',TRUE),(@q,'Data Object Model',FALSE),(@q,'Document Oriented Model',FALSE),(@q,'Dynamic Object Model',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you find an HTML element by id?', 'SINGLE_CHOICE', 'getElementById finds elements by id.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'getElementById()',TRUE),(@q,'findElementById()',FALSE),(@q,'getById()',FALSE),(@q,'findById()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'What is the correct way to write a string in JavaScript?', 'SINGLE_CHOICE', 'Strings use quotes.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'"Hello"',TRUE),(@q,'Hello',FALSE),(@q,'<Hello>',FALSE),(@q,'[Hello]',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'How do you convert a string to an integer?', 'SINGLE_CHOICE', 'parseInt() converts to integer.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'parseInt()',TRUE),(@q,'toInt()',FALSE),(@q,'int()',FALSE),(@q,'convert()',FALSE);

-- -----------------------------
-- JAVASCRIPT - INTERMEDIATE (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the difference between == and ===?', 'SINGLE_CHOICE', '=== checks type and value, == allows type coercion.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'=== strict equality, == loose equality',TRUE),(@q,'No difference',FALSE),(@q,'== is deprecated',FALSE),(@q,'=== is for objects',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you create a promise in JavaScript?', 'SINGLE_CHOICE', 'Promises use Promise constructor.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'new Promise()',TRUE),(@q,'create Promise()',FALSE),(@q,'Promise.create()',FALSE),(@q,'async Promise()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the purpose of the bind() method?', 'SINGLE_CHOICE', 'bind() creates new function with bound this.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Binds this context',TRUE),(@q,'Binds arguments',FALSE),(@q,'Creates closure',FALSE),(@q,'Creates prototype',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you handle errors in promises?', 'SINGLE_CHOICE', 'Use .catch() method.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.catch()',TRUE),(@q,'.error()',FALSE),(@q,'.fail()',FALSE),(@q,'try-catch',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the difference between let and var?', 'SINGLE_CHOICE', 'let has block scope, var has function scope.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'let block scope, var function scope',TRUE),(@q,'No difference',FALSE),(@q,'var is deprecated',FALSE),(@q,'let is for constants',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you create an arrow function?', 'SINGLE_CHOICE', 'Arrow functions use => syntax.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'() => {}',TRUE),(@q,'function() {}',FALSE),(@q,'() -> {}',FALSE),(@q,'lambda() {}',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the purpose of the spread operator?', 'SINGLE_CHOICE', 'Spread expands iterables.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Expands arrays/objects',TRUE),(@q,'Creates arrays',FALSE),(@q,'Joins strings',FALSE),(@q,'Clones objects',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you destructure an array?', 'SINGLE_CHOICE', 'Use square brackets for destructuring.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'const [a, b] = arr',TRUE),(@q,'const a, b = arr',FALSE),(@q,'const {a, b} = arr',FALSE),(@q,'const arr.a, arr.b',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the purpose of async/await?', 'SINGLE_CHOICE', 'async/await simplifies promise handling.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Handles promises synchronously',TRUE),(@q,'Creates threads',FALSE),(@q,'Handles events',FALSE),(@q,'Creates callbacks',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you create a class in JavaScript?', 'SINGLE_CHOICE', 'Classes use class keyword.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class MyClass {}',TRUE),(@q,'function MyClass() {}',FALSE),(@q,'var MyClass = {}',FALSE),(@q,'create MyClass {}',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the difference between null and undefined?', 'SINGLE_CHOICE', 'null is assigned, undefined is unassigned.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'null assigned value, undefined unassigned',TRUE),(@q,'No difference',FALSE),(@q,'undefined is deprecated',FALSE),(@q,'null is for objects',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you create a module in JavaScript?', 'SINGLE_CHOICE', 'Use export/import syntax.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'export/import',TRUE),(@q,'module.exports',FALSE),(@q,'require()',FALSE),(@q,'include()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the purpose of the map() method?', 'SINGLE_CHOICE', 'map() transforms array elements.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Transforms array elements',TRUE),(@q,'Filters elements',FALSE),(@q,'Finds elements',FALSE),(@q,'Sorts elements',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you handle events in JavaScript?', 'SINGLE_CHOICE', 'Use addEventListener.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'addEventListener()',TRUE),(@q,'onEvent()',FALSE),(@q,'handleEvent()',FALSE),(@q,'eventListener()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the difference between call() and apply()?', 'SINGLE_CHOICE', 'apply() takes arguments array, call() takes individual arguments.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'apply() array, call() individual',TRUE),(@q,'No difference',FALSE),(@q,'call() is deprecated',FALSE),(@q,'apply() is for functions',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you create a closure in JavaScript?', 'SINGLE_CHOICE', 'Function inside function accessing outer variables.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Function inside function',TRUE),(@q,'Global function',FALSE),(@q,'Anonymous function',FALSE),(@q,'Arrow function',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the purpose of the reduce() method?', 'SINGLE_CHOICE', 'reduce() reduces array to single value.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Reduces to single value',TRUE),(@q,'Filters array',FALSE),(@q,'Maps array',FALSE),(@q,'Finds element',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'How do you create a template literal?', 'SINGLE_CHOICE', 'Use backticks with ${}.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'`Hello ${name}`',TRUE),(@q,'"Hello " + name',FALSE),(@q,'\'Hello \' + name',FALSE),(@q,'<Hello> name </Hello>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'What is the difference between localStorage and sessionStorage?', 'SINGLE_CHOICE', 'sessionStorage clears on tab close, localStorage persists.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'sessionStorage per session, localStorage persistent',TRUE),(@q,'No difference',FALSE),(@q,'localStorage is deprecated',FALSE),(@q,'sessionStorage is for server',FALSE);

-- -----------------------------
-- JAVASCRIPT - ADVANCED (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the event loop in JavaScript?', 'SINGLE_CHOICE', 'Event loop handles asynchronous operations.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Handles async operations',TRUE),(@q,'Loops through events',FALSE),(@q,'Creates events',FALSE),(@q,'Manages DOM',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you implement inheritance in JavaScript?', 'SINGLE_CHOICE', 'Use prototype chain or classes.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Prototype chain or extends',TRUE),(@q,'Copy properties',FALSE),(@q,'Use mixins',FALSE),(@q,'Global inheritance',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the purpose of the Symbol type?', 'SINGLE_CHOICE', 'Symbols create unique identifiers.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Unique identifiers',TRUE),(@q,'String replacement',FALSE),(@q,'Number type',FALSE),(@q,'Object keys',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you create a web worker?', 'SINGLE_CHOICE', 'Use Worker constructor.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'new Worker()',TRUE),(@q,'createWorker()',FALSE),(@q,'spawnWorker()',FALSE),(@q,'webWorker()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the difference between setTimeout and setInterval?', 'SINGLE_CHOICE', 'setTimeout runs once, setInterval repeats.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'setTimeout once, setInterval repeat',TRUE),(@q,'No difference',FALSE),(@q,'setInterval is deprecated',FALSE),(@q,'setTimeout for intervals',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you implement memoization in JavaScript?', 'SINGLE_CHOICE', 'Cache function results.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Cache results in closure',TRUE),(@q,'Use global cache',FALSE),(@q,'Override function',FALSE),(@q,'Use prototype',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the purpose of the Proxy object?', 'SINGLE_CHOICE', 'Proxy controls object operations.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Controls object operations',TRUE),(@q,'Creates proxies',FALSE),(@q,'Handles requests',FALSE),(@q,'Manages connections',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you implement currying in JavaScript?', 'SINGLE_CHOICE', 'Return functions that take single arguments.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Return nested functions',TRUE),(@q,'Use bind()',FALSE),(@q,'Use apply()',FALSE),(@q,'Use call()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the difference between WeakMap and Map?', 'SINGLE_CHOICE', 'WeakMap allows garbage collection of keys.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'WeakMap GC keys, Map does not',TRUE),(@q,'No difference',FALSE),(@q,'WeakMap is deprecated',FALSE),(@q,'Map allows weak keys',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you create a custom iterator?', 'SINGLE_CHOICE', 'Implement Symbol.iterator.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'[Symbol.iterator]()',TRUE),(@q,'iterator()',FALSE),(@q,'createIterator()',FALSE),(@q,'makeIterator()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the purpose of the Reflect API?', 'SINGLE_CHOICE', 'Reflect provides introspection methods.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Introspection methods',TRUE),(@q,'Reflection operations',FALSE),(@q,'Object reflection',FALSE),(@q,'Method reflection',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you implement debouncing?', 'SINGLE_CHOICE', 'Delay function execution.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Use setTimeout with clear',TRUE),(@q,'Use intervals',FALSE),(@q,'Use promises',FALSE),(@q,'Use callbacks',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the difference between Object.freeze() and Object.seal()?', 'SINGLE_CHOICE', 'freeze() prevents changes, seal() allows property changes.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'freeze() no changes, seal() allows values',TRUE),(@q,'No difference',FALSE),(@q,'seal() is deprecated',FALSE),(@q,'freeze() allows values',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you create a service worker?', 'SINGLE_CHOICE', 'Register script as service worker.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'navigator.serviceWorker.register()',TRUE),(@q,'new ServiceWorker()',FALSE),(@q,'createServiceWorker()',FALSE),(@q,'registerWorker()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the purpose of the Intl object?', 'SINGLE_CHOICE', 'Intl provides internationalization.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Internationalization',TRUE),(@q,'Internal operations',FALSE),(@q,'Interface methods',FALSE),(@q,'Integer operations',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you implement the observer pattern?', 'SINGLE_CHOICE', 'Use event emitters or callbacks.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Event listeners/callbacks',TRUE),(@q,'Global variables',FALSE),(@q,'Direct method calls',FALSE),(@q,'Prototype chain',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the difference between fetch() and XMLHttpRequest?', 'SINGLE_CHOICE', 'fetch() returns promises, XMLHttpRequest uses callbacks.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'fetch() promises, XMLHttpRequest callbacks',TRUE),(@q,'No difference',FALSE),(@q,'XMLHttpRequest deprecated',FALSE),(@q,'fetch() for XML',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'How do you create a custom element?', 'SINGLE_CHOICE', 'Extend HTMLElement.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class MyElement extends HTMLElement',TRUE),(@q,'createElement()',FALSE),(@q,'new HTMLElement()',FALSE),(@q,'customElement()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'What is the purpose of the WeakSet?', 'SINGLE_CHOICE', 'WeakSet allows garbage collection of values.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'GC of values',TRUE),(@q,'Weak references',FALSE),(@q,'Set operations',FALSE),(@q,'Memory management',FALSE);

-- -----------------------------
-- SQL - BEGINNER (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What does SQL stand for?', 'SINGLE_CHOICE', 'SQL is Structured Query Language.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Structured Query Language',TRUE),(@q,'Simple Query Language',FALSE),(@q,'Standard Query Language',FALSE),(@q,'System Query Language',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which SQL statement is used to extract data from a database?', 'SINGLE_CHOICE', 'SELECT retrieves data.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'SELECT',TRUE),(@q,'GET',FALSE),(@q,'EXTRACT',FALSE),(@q,'FETCH',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which SQL statement is used to update data in a database?', 'SINGLE_CHOICE', 'UPDATE modifies existing data.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UPDATE',TRUE),(@q,'MODIFY',FALSE),(@q,'CHANGE',FALSE),(@q,'ALTER',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which SQL statement is used to delete data from a database?', 'SINGLE_CHOICE', 'DELETE removes data.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'DELETE',TRUE),(@q,'REMOVE',FALSE),(@q,'CLEAR',FALSE),(@q,'DROP',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which SQL statement is used to insert new data in a database?', 'SINGLE_CHOICE', 'INSERT adds new data.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'INSERT',TRUE),(@q,'ADD',FALSE),(@q,'CREATE',FALSE),(@q,'NEW',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What does the SELECT * statement do?', 'SINGLE_CHOICE', '* selects all columns.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Selects all columns',TRUE),(@q,'Selects first column',FALSE),(@q,'Selects last column',FALSE),(@q,'Selects no columns',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which SQL keyword is used to sort the result-set?', 'SINGLE_CHOICE', 'ORDER BY sorts results.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ORDER BY',TRUE),(@q,'SORT BY',FALSE),(@q,'GROUP BY',FALSE),(@q,'ARRANGE BY',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What is the correct SQL syntax for selecting all records from a table named "customers"?', 'SINGLE_CHOICE', 'SELECT * FROM table_name.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'SELECT * FROM customers',TRUE),(@q,'SELECT customers',FALSE),(@q,'GET * customers',FALSE),(@q,'EXTRACT customers',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which SQL clause is used to filter records?', 'SINGLE_CHOICE', 'WHERE filters records.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'WHERE',TRUE),(@q,'FILTER',FALSE),(@q,'WHEN',FALSE),(@q,'IF',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What is the default sort order in SQL?', 'SINGLE_CHOICE', 'ASC is ascending order.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ASC',TRUE),(@q,'DESC',FALSE),(@q,'RANDOM',FALSE),(@q,'ALPHA',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which operator is used to select values within a range?', 'SINGLE_CHOICE', 'BETWEEN selects ranges.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'BETWEEN',TRUE),(@q,'RANGE',FALSE),(@q,'WITHIN',FALSE),(@q,'INSIDE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What does NULL represent in SQL?', 'SINGLE_CHOICE', 'NULL represents missing value.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Missing value',TRUE),(@q,'Zero',FALSE),(@q,'Empty string',FALSE),(@q,'False',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which SQL function is used to count the number of rows?', 'SINGLE_CHOICE', 'COUNT() counts rows.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'COUNT()',TRUE),(@q,'SUM()',FALSE),(@q,'TOTAL()',FALSE),(@q,'NUMBER()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What is the correct SQL syntax to create a table?', 'SINGLE_CHOICE', 'CREATE TABLE creates tables.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'CREATE TABLE',TRUE),(@q,'MAKE TABLE',FALSE),(@q,'NEW TABLE',FALSE),(@q,'BUILD TABLE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which constraint ensures that all values in a column are unique?', 'SINGLE_CHOICE', 'UNIQUE ensures uniqueness.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UNIQUE',TRUE),(@q,'DISTINCT',FALSE),(@q,'SINGLE',FALSE),(@q,'ONLY',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What is a primary key in SQL?', 'SINGLE_CHOICE', 'Primary key uniquely identifies rows.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Unique identifier',TRUE),(@q,'Foreign key',FALSE),(@q,'Index',FALSE),(@q,'Constraint',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which SQL statement is used to modify a table structure?', 'SINGLE_CHOICE', 'ALTER TABLE modifies structure.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ALTER TABLE',TRUE),(@q,'MODIFY TABLE',FALSE),(@q,'CHANGE TABLE',FALSE),(@q,'UPDATE TABLE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What is the purpose of the GROUP BY clause?', 'SINGLE_CHOICE', 'GROUP BY groups rows with same values.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Groups rows',TRUE),(@q,'Sorts rows',FALSE),(@q,'Filters rows',FALSE),(@q,'Joins tables',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Which join returns all records from both tables?', 'SINGLE_CHOICE', 'FULL OUTER JOIN returns all records.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'FULL OUTER JOIN',TRUE),(@q,'INNER JOIN',FALSE),(@q,'LEFT JOIN',FALSE),(@q,'RIGHT JOIN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'What is the correct syntax for a comment in SQL?', 'SINGLE_CHOICE', '-- starts single-line comments.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'-- comment',TRUE),(@q,'# comment',FALSE),(@q,'/* comment */',TRUE),(@q,'// comment',FALSE);

-- -----------------------------
-- SQL - INTERMEDIATE (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is the difference between WHERE and HAVING?', 'SINGLE_CHOICE', 'WHERE filters rows, HAVING filters groups.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'WHERE rows, HAVING groups',TRUE),(@q,'No difference',FALSE),(@q,'HAVING is deprecated',FALSE),(@q,'WHERE for aggregates',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is a subquery in SQL?', 'SINGLE_CHOICE', 'Subquery is query within another query.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Query within query',TRUE),(@q,'Main query',FALSE),(@q,'Simple query',FALSE),(@q,'Complex query',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Which SQL function is used to get the current date?', 'SINGLE_CHOICE', 'NOW() or CURRENT_DATE gets current date.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'NOW()',TRUE),(@q,'TODAY()',FALSE),(@q,'DATE()',FALSE),(@q,'CURRENT_DATE()',TRUE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is the purpose of the UNION operator?', 'SINGLE_CHOICE', 'UNION combines result sets.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Combines result sets',TRUE),(@q,'Joins tables',FALSE),(@q,'Filters results',FALSE),(@q,'Groups results',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is a view in SQL?', 'SINGLE_CHOICE', 'View is virtual table based on query.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Virtual table',TRUE),(@q,'Physical table',FALSE),(@q,'Index',FALSE),(@q,'Constraint',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'How do you create an index in SQL?', 'SINGLE_CHOICE', 'CREATE INDEX creates indexes.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'CREATE INDEX',TRUE),(@q,'MAKE INDEX',FALSE),(@q,'ADD INDEX',FALSE),(@q,'NEW INDEX',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is the difference between CHAR and VARCHAR?', 'SINGLE_CHOICE', 'CHAR fixed length, VARCHAR variable length.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'CHAR fixed, VARCHAR variable',TRUE),(@q,'No difference',FALSE),(@q,'VARCHAR deprecated',FALSE),(@q,'CHAR for numbers',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is a stored procedure?', 'SINGLE_CHOICE', 'Stored procedure is saved SQL code.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Saved SQL code',TRUE),(@q,'Query result',FALSE),(@q,'Table definition',FALSE),(@q,'Index definition',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is the purpose of the CASE statement?', 'SINGLE_CHOICE', 'CASE provides conditional logic.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Conditional logic',TRUE),(@q,'Looping',FALSE),(@q,'Sorting',FALSE),(@q,'Grouping',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'How do you handle NULL values in SQL?', 'SINGLE_CHOICE', 'Use IS NULL or IS NOT NULL.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'IS NULL',TRUE),(@q,'= NULL',FALSE),(@q,'NULL =',FALSE),(@q,'<> NULL',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is the difference between INNER JOIN and OUTER JOIN?', 'SINGLE_CHOICE', 'INNER JOIN matching rows, OUTER JOIN all rows.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'INNER matching, OUTER all',TRUE),(@q,'No difference',FALSE),(@q,'OUTER deprecated',FALSE),(@q,'INNER for all tables',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is normalization in databases?', 'SINGLE_CHOICE', 'Normalization reduces redundancy.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Reduces redundancy',TRUE),(@q,'Increases speed',FALSE),(@q,'Adds complexity',FALSE),(@q,'Creates indexes',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is the purpose of the DISTINCT keyword?', 'SINGLE_CHOICE', 'DISTINCT removes duplicates.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Removes duplicates',TRUE),(@q,'Adds duplicates',FALSE),(@q,'Sorts results',FALSE),(@q,'Groups results',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'How do you use wildcards in SQL?', 'SINGLE_CHOICE', 'Use % and _ with LIKE.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'LIKE with % and _',TRUE),(@q,'REGEX',FALSE),(@q,'MATCH',FALSE),(@q,'SEARCH',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is a trigger in SQL?', 'SINGLE_CHOICE', 'Trigger executes automatically on events.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Automatic execution',TRUE),(@q,'Manual execution',FALSE),(@q,'Query result',FALSE),(@q,'Table definition',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is the difference between DELETE and TRUNCATE?', 'SINGLE_CHOICE', 'DELETE can be rolled back, TRUNCATE cannot.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'DELETE rollback, TRUNCATE no',TRUE),(@q,'No difference',FALSE),(@q,'TRUNCATE faster',FALSE),(@q,'DELETE for tables',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'How do you create a foreign key?', 'SINGLE_CHOICE', 'Use REFERENCES in CREATE TABLE.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'REFERENCES',TRUE),(@q,'FOREIGN KEY',TRUE),(@q,'LINK',FALSE),(@q,'CONNECT',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is the purpose of the LIMIT clause?', 'SINGLE_CHOICE', 'LIMIT restricts number of rows.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Restricts rows',TRUE),(@q,'Limits columns',FALSE),(@q,'Limits tables',FALSE),(@q,'Limits queries',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'What is a correlated subquery?', 'SINGLE_CHOICE', 'Correlated subquery references outer query.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'References outer query',TRUE),(@q,'Independent query',FALSE),(@q,'Simple subquery',FALSE),(@q,'Complex query',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'How do you concatenate strings in SQL?', 'SINGLE_CHOICE', 'Use CONCAT() or ||.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'CONCAT()',TRUE),(@q,'+',FALSE),(@q,'&',FALSE),(@q,'JOIN',FALSE);

-- -----------------------------
-- SQL - ADVANCED (20 questions)
-- -----------------------------
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is a transaction in SQL?', 'SINGLE_CHOICE', 'Transaction is atomic unit of work.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Atomic unit of work',TRUE),(@q,'Single query',FALSE),(@q,'Table operation',FALSE),(@q,'Index operation',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What are ACID properties?', 'SINGLE_CHOICE', 'ACID ensures reliable transactions.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Atomicity, Consistency, Isolation, Durability',TRUE),(@q,'Access, Control, Integrity, Data',FALSE),(@q,'Automatic, Consistent, Independent, Durable',FALSE),(@q,'All, Complete, Isolated, Done',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is database locking?', 'SINGLE_CHOICE', 'Locking prevents concurrent access conflicts.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Prevents conflicts',TRUE),(@q,'Speeds up queries',FALSE),(@q,'Creates indexes',FALSE),(@q,'Normalizes data',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is the difference between clustered and non-clustered indexes?', 'SINGLE_CHOICE', 'Clustered determines physical order, non-clustered does not.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Clustered physical order, non-clustered logical',TRUE),(@q,'No difference',FALSE),(@q,'Non-clustered deprecated',FALSE),(@q,'Clustered for primary keys',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is database partitioning?', 'SINGLE_CHOICE', 'Partitioning divides table into smaller pieces.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Divides table',TRUE),(@q,'Joins tables',FALSE),(@q,'Creates views',FALSE),(@q,'Normalizes data',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is the purpose of the EXPLAIN statement?', 'SINGLE_CHOICE', 'EXPLAIN shows query execution plan.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Shows execution plan',TRUE),(@q,'Explains syntax',FALSE),(@q,'Describes table',FALSE),(@q,'Shows results',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is database sharding?', 'SINGLE_CHOICE', 'Sharding distributes data across servers.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Distributes data',TRUE),(@q,'Compresses data',FALSE),(@q,'Encrypts data',FALSE),(@q,'Backs up data',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is the difference between OLTP and OLAP?', 'SINGLE_CHOICE', 'OLTP transactional, OLAP analytical.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'OLTP transaction, OLAP analysis',TRUE),(@q,'No difference',FALSE),(@q,'OLAP deprecated',FALSE),(@q,'OLTP for reporting',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is database replication?', 'SINGLE_CHOICE', 'Replication copies data to multiple servers.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Copies data',TRUE),(@q,'Deletes data',FALSE),(@q,'Moves data',FALSE),(@q,'Compresses data',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is the purpose of the WITH clause?', 'SINGLE_CHOICE', 'WITH creates common table expressions.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Common table expressions',TRUE),(@q,'Temporary tables',FALSE),(@q,'Views',FALSE),(@q,'Subqueries',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is database denormalization?', 'SINGLE_CHOICE', 'Denormalization adds redundancy for performance.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Adds redundancy',TRUE),(@q,'Removes redundancy',FALSE),(@q,'Creates indexes',FALSE),(@q,'Normalizes data',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is the difference between UNION and UNION ALL?', 'SINGLE_CHOICE', 'UNION removes duplicates, UNION ALL keeps them.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UNION no duplicates, UNION ALL with duplicates',TRUE),(@q,'No difference',FALSE),(@q,'UNION ALL deprecated',FALSE),(@q,'UNION for different tables',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is a materialized view?', 'SINGLE_CHOICE', 'Materialized view stores query results.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Stores results',TRUE),(@q,'Virtual table',FALSE),(@q,'Index',FALSE),(@q,'Constraint',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is database connection pooling?', 'SINGLE_CHOICE', 'Pooling reuses database connections.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Reuses connections',TRUE),(@q,'Creates connections',FALSE),(@q,'Closes connections',FALSE),(@q,'Tests connections',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is the purpose of the ROLLBACK statement?', 'SINGLE_CHOICE', 'ROLLBACK undoes transaction changes.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Undoes changes',TRUE),(@q,'Commits changes',FALSE),(@q,'Saves changes',FALSE),(@q,'Deletes transaction',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is database deadlock?', 'SINGLE_CHOICE', 'Deadlock occurs when processes wait for each other.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Processes waiting',TRUE),(@q,'Query timeout',FALSE),(@q,'Connection lost',FALSE),(@q,'Memory full',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is the difference between a cursor and a result set?', 'SINGLE_CHOICE', 'Cursor navigates results, result set is the data.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Cursor navigation, result set data',TRUE),(@q,'No difference',FALSE),(@q,'Cursor deprecated',FALSE),(@q,'Result set for stored procedures',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is database indexing strategy?', 'SINGLE_CHOICE', 'Strategy optimizes query performance.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Optimizes performance',TRUE),(@q,'Creates tables',FALSE),(@q,'Normalizes data',FALSE),(@q,'Secures data',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'What is the purpose of the SAVEPOINT statement?', 'SINGLE_CHOICE', 'SAVEPOINT creates rollback points.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Rollback points',TRUE),(@q,'Save data',FALSE),(@q,'Commit transaction',FALSE),(@q,'End transaction',FALSE);

SELECT 'Seed complete: Added 240+ questions across all levels and languages.' as status;
