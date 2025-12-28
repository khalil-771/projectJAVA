-- ======================================================================================
-- SCRIPT D'INSTALLATION COMPLET - DEVQUIZ (CORRIGÉ & ROBUSTE)
-- ======================================================================================

-- 1. CRÉATION BASE DE DONNÉES EN UTF8mb4 (Supporte les accents et emojis)
CREATE DATABASE IF NOT EXISTS quiztests CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quiztests;

-- DÉSACTIVER LES VIDÉOS DE SÉCURITÉ
SET FOREIGN_KEY_CHECKS = 0;

-- 2. NETTOYAGE (DROP TABLES)
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS room_players;
DROP TABLE IF EXISTS multiplayer_rooms;
DROP TABLE IF EXISTS user_quiz_results;
DROP TABLE IF EXISTS user_lesson_progress;
DROP TABLE IF EXISTS lessons;
DROP TABLE IF EXISTS chapters;
DROP TABLE IF EXISTS users;

-- 3. CRÉATION DES TABLES (AVEC CHARSET EXPLICITE)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ROLE_STUDENT', 'ROLE_ADMIN') DEFAULT 'ROLE_STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    language_tag VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    is_final_exam BOOLEAN DEFAULT FALSE,
    passing_score INT DEFAULT 70,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    question_type ENUM('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TRUE_FALSE') NOT NULL,
    explanation TEXT,
    difficulty ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') DEFAULT 'BEGINNER',
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE user_quiz_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    quiz_id INT NOT NULL,
    score INT NOT NULL,
    passed BOOLEAN NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE multiplayer_rooms (
    room_id VARCHAR(50) PRIMARY KEY,
    room_name VARCHAR(100) NOT NULL,
    host_user_id INT NOT NULL,
    host_ip VARCHAR(50),
    language VARCHAR(50),
    difficulty VARCHAR(20),
    max_players INT DEFAULT 4,
    status VARCHAR(20) DEFAULT 'WAITING',
    current_quiz_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE room_players (
    room_id VARCHAR(50),
    user_id INT,
    username VARCHAR(100),
    is_ready BOOLEAN DEFAULT FALSE,
    score INT DEFAULT 0,
    time_taken INT DEFAULT 0,
    PRIMARY KEY (room_id, user_id),
    FOREIGN KEY (room_id) REFERENCES multiplayer_rooms(room_id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;


-- ======================================================================================
-- 4. INSERTION DES DONNÉES DE BASE
-- ======================================================================================

-- Utilisateurs : ILS SERONT CRÉÉS AUTOMATIQUEMENT PAR L'APPLICATION AU PREMIER LANCEMENT
-- Cela garantit que le hachage du mot de passe (BCrypt) est correct et compatible.

-- Langages
INSERT INTO courses (title, description, language_tag) VALUES 
('Java', 'Programmation Orientée Objet', 'java'),
('Python', 'Scripting et Data Science', 'python'),
('C++', 'Performance et Système', 'cpp'),
('C', 'Programmation Système', 'c'),
('HTML', 'Structure Web', 'html'),
('CSS', 'Style Web', 'css'),
('JavaScript', 'Interactivité Web', 'js'),
('SQL', 'Bases de Données', 'sql'),
('Kotlin', 'Android et JVM', 'kotlin'),
('PHP', 'Backend Web', 'php'),
('C#', 'Développement .NET', 'csharp'),
('Ruby', 'Développement Web', 'ruby'),
('Swift', 'Développement iOS', 'swift');

-- Procedure pour créer les Quiz (Débutant, Int, Avancé)
DELIMITER //
CREATE PROCEDURE InitQuizzes()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE c_name VARCHAR(100);
    DECLARE cur CURSOR FOR SELECT id, title FROM courses;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO c_id, c_name;
        IF done THEN LEAVE read_loop; END IF;

        INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) VALUES (c_id, CONCAT(c_name, ' - Débutant'), FALSE, 70);
        INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) VALUES (c_id, CONCAT(c_name, ' - Intermédiaire'), FALSE, 75);
        INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) VALUES (c_id, CONCAT(c_name, ' - Avancé'), FALSE, 80);
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
CALL InitQuizzes();
DROP PROCEDURE InitQuizzes;


-- ======================================================================================
-- 5. POPULATION DES QUESTIONS (Echantillon) - VERSION SÉCURISÉE
-- ======================================================================================

DELIMITER //
CREATE PROCEDURE AddQ(
    IN quizTitle VARCHAR(100), 
    IN qText TEXT, 
    IN diff VARCHAR(20), 
    IN goodAns TEXT, 
    IN bad1 TEXT, 
    IN bad2 TEXT, 
    IN bad3 TEXT, 
    IN expl TEXT
)
BEGIN
    DECLARE q_quiz_id INT DEFAULT NULL;
    
    -- Utilisation de l'assignation directe pour éviter l'erreur "No Data" 
    -- COLLATE utf8mb4_general_ci : Assure que la comparaison de chaînes fonctionne bien
    SET q_quiz_id = (SELECT id FROM quizzes WHERE title = quizTitle LIMIT 1);
    
    IF q_quiz_id IS NOT NULL THEN
        INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) 
        VALUES (q_quiz_id, qText, 'SINGLE_CHOICE', expl, diff);
        
        -- On insert les réponses seulement si la question a bien été ajoutée
        IF LAST_INSERT_ID() > 0 THEN
			SET @qid = LAST_INSERT_ID();
            INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, goodAns, TRUE);
            INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad1, FALSE);
            INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad2, FALSE);
            INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad3, FALSE);
        END IF;
    END IF;
END //
DELIMITER ;

-- ==================== QUESTIONS DE TEST ====================

-- JAVA
CALL AddQ('Java - Débutant', 'Quel mot-clé est utilisé pour hériter d\'une classe ?', 'BEGINNER', 'extends', 'implements', 'inherit', 'super', 'extends pour l\'héritage.');
CALL AddQ('Java - Débutant', 'Quelle est la taille d\'un int en Java ?', 'BEGINNER', '32 bits', '16 bits', '64 bits', '8 bits', 'int fait 32 bits.');

-- PYTHON
CALL AddQ('Python - Débutant', 'Comment définir une fonction en Python ?', 'BEGINNER', 'def ma_fonction():', 'function ma_fonction()', 'void ma_fonction()', 'func ma_fonction()', 'Mot-clé def.');
CALL AddQ('Python - Intermédiaire', 'Que fait `pass` en Python ?', 'INTERMEDIATE', 'Rien', 'Arrête la boucle', 'Exception', 'Return', 'Instruction nulle.');

-- WEB
CALL AddQ('HTML - Débutant', 'Titre principal ?', 'BEGINNER', '<h1>', '<head>', '<title>', '<header>', 'h1.');
CALL AddQ('CSS - Débutant', 'Couleur du texte ?', 'BEGINNER', 'color', 'text-color', 'font-color', 'background', 'color.');
CALL AddQ('JavaScript - Débutant', 'Variable constante ?', 'BEGINNER', 'const x=1;', 'var x=1;', 'let x=1;', 'constant x=1;', 'const.');

-- AUTRES
CALL AddQ('C++ - Débutant', 'Symbole de fin d\'instruction ?', 'BEGINNER', ';', '.', ':', '#', '; est obligatoire.');
CALL AddQ('C - Débutant', 'Inclure stdio ?', 'BEGINNER', '#include <stdio.h>', 'import stdio', 'use stdio', 'require', '#include.');
CALL AddQ('SQL - Débutant', 'Tout sélectionner ?', 'BEGINNER', 'SELECT *', 'SELECT ALL', 'GET *', 'FETCH *', '* pour tout.');

-- Nettoyage
DROP PROCEDURE AddQ;

SELECT 'INSTALLATION ET POPULATION TERMINÉES AVEC SUCCÈS - LANCEZ L''APPLICATION !' AS Status;
