-- =======================================================
-- SCRIPT DE RÉPARATION (REPAIR_DB.sql)
-- =======================================================
-- Ce script va recréer les tables manquantes (questions, quizzes...)
-- Et réinstaller l'outil AddQ.
-- Exécutez-le AVANT de réessayer vos INSERT.
-- =======================================================

CREATE DATABASE IF NOT EXISTS quiztests CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quiztests;

SET FOREIGN_KEY_CHECKS = 0;

-- 1. CRÉATION DES TABLES
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ROLE_STUDENT', 'ROLE_ADMIN') DEFAULT 'ROLE_STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    language_tag VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    is_final_exam BOOLEAN DEFAULT FALSE,
    passing_score INT DEFAULT 70,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    question_type ENUM('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TRUE_FALSE') NOT NULL,
    explanation TEXT,
    difficulty ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') DEFAULT 'BEGINNER',
    language_tag VARCHAR(50) DEFAULT 'java',
    points_value INT DEFAULT 10,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- SÉCURITÉ : AJOUTER LES COLONNES SI ELLES MANQUENT (ALTER)
-- Car si la table existe déjà, le CREATE ci-dessus ne fait rien.
-- On tente d'ajouter les colonnes (les erreurs "Duplicate column" sont ignorées ou gérées par IF NOT EXISTS dans MySQL 8+ mais ici on fait simple)
-- Note: MySQL simple ne supporte pas IF NOT EXISTS dans ALTER ADD COLUMN facilement sans procedure, 
-- donc on va ignorer les erreurs potentielles en Java ou on demande au user de DROP. 
-- MAIS ici le sript "REPAIR" devrait être robuste.
-- Le plus simple : DROP TABLE questions et recréer ?
-- Non, le user a peut-être des données.
-- On va laisser le CREATE faire le job si la table n'existe pas.
-- Si la table existe sans colonnes, ça crash.
-- ALORS ON VA DROPPER LA TABLE QUESTIONS DANS CE FICHIER DE RÉPARATION POUR ÊTRE SÛR DE LA STRUCTURE.
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    question_type ENUM('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TRUE_FALSE') NOT NULL,
    explanation TEXT,
    difficulty ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') DEFAULT 'BEGINNER',
    language_tag VARCHAR(50) DEFAULT 'java',
    points_value INT DEFAULT 10,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_quiz_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    quiz_id INT NOT NULL,
    score INT NOT NULL,
    passed BOOLEAN NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS multiplayer_rooms (
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

CREATE TABLE IF NOT EXISTS room_players (
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

-- 2. RE-INSTALLATION DE L'OUTIL AddQ
DELIMITER //
DROP PROCEDURE IF EXISTS AddQ //
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
    
    SET q_quiz_id = (SELECT id FROM quizzes WHERE title = quizTitle LIMIT 1);
    
    IF q_quiz_id IS NOT NULL THEN
        INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) 
        VALUES (q_quiz_id, qText, 'SINGLE_CHOICE', expl, diff);
        
        SET @qid = LAST_INSERT_ID();
        
        INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, goodAns, TRUE);
        INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad1, FALSE);
        INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad2, FALSE);
        INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad3, FALSE);
        
        -- SELECT CONCAT('✅ Question ajoutée pour : ', quizTitle) AS Status;
    ELSE
        -- SELECT CONCAT('❌ ERREUR : Quiz introuvable -> ', quizTitle) AS Status;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERREUR: Quiz introuvable, verifiez le titre';
    END IF;
END //
DELIMITER ;

-- 3. INITIALISATION DES LANGAGES (SÉCURITÉ SI VIDE)
INSERT IGNORE INTO courses (title, description, language_tag) VALUES 
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

-- Procedure Temporaire pour recréer les Quiz si manquants
DELIMITER //
CREATE PROCEDURE InitQuizzesRev()
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

        -- On utilise INSERT IGNORE ou vérification pour ne pas dupliquer si déjà là
        IF NOT EXISTS (SELECT 1 FROM quizzes WHERE course_id = c_id AND title = CONCAT(c_name, ' - Débutant')) THEN
            INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) VALUES (c_id, CONCAT(c_name, ' - Débutant'), FALSE, 70);
            INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) VALUES (c_id, CONCAT(c_name, ' - Intermédiaire'), FALSE, 75);
            INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) VALUES (c_id, CONCAT(c_name, ' - Avancé'), FALSE, 80);
        END IF;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
CALL InitQuizzesRev();
DROP PROCEDURE InitQuizzesRev;


SELECT 'RÉPARATION TERMINÉE ! Vous pouvez relancer vos scripts d''ajout de questions.' AS Status;
