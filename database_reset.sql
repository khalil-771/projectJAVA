USE quiztests;

-- DÉSACTIVER LES CONTRAINTES DE CLÉ ÉTRANGÈRE
SET FOREIGN_KEY_CHECKS = 0;

-- VIDER TOUTES LES TABLES (CLEAN SLATE)
TRUNCATE TABLE user_quiz_results;
TRUNCATE TABLE user_lesson_progress;
TRUNCATE TABLE answers;
TRUNCATE TABLE questions;
TRUNCATE TABLE quizzes;
TRUNCATE TABLE lessons;
TRUNCATE TABLE chapters;
TRUNCATE TABLE courses;
TRUNCATE TABLE users;
TRUNCATE TABLE multiplayer_rooms;
TRUNCATE TABLE room_players;

-- RÉACTIVER LES CONTRAINTES
SET FOREIGN_KEY_CHECKS = 1;

-- 1. CRÉER LES UTILISATEURS
-- Admin (password: admin123)
INSERT INTO users (username, email, password_hash, role) 
VALUES ('admin', 'admin@devquiz.com', '$2a$10$Ew.K.w.K.w.K.w.K.w.K.ue3.3.3.3.3.3.3.3.3.3.3.3.3.3.3', 'ROLE_ADMIN');

-- Student (password: student123)
INSERT INTO users (username, email, password_hash, role) 
VALUES ('student', 'student@devquiz.com', '$2a$10$Ew.K.w.K.w.K.w.K.w.K.ue3.3.3.3.3.3.3.3.3.3.3.3.3.3.3', 'ROLE_STUDENT');


-- 2. INSÉRER LES LANGAGES (Table courses)
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

-- 3. CRÉER LA STRUCTURE DES QUIZ (3 Niveaux par Langage)
-- Nous utilisons une procédure stockée temporaire pour éviter de répéter le code
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
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Quiz Débutant
        INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) 
        VALUES (c_id, CONCAT(c_name, ' - Débutant'), FALSE, 70);
        
        -- Quiz Intermédiaire
        INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) 
        VALUES (c_id, CONCAT(c_name, ' - Intermédiaire'), FALSE, 75);
        
        -- Quiz Avancé
        INSERT INTO quizzes (course_id, title, is_final_exam, passing_score) 
        VALUES (c_id, CONCAT(c_name, ' - Avancé'), FALSE, 80);
        
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

-- Exécuter la procédure
CALL InitQuizzes();

-- Supprimer la procédure
DROP PROCEDURE InitQuizzes;

-- NOTE: Les tables 'questions' et 'answers' sont vides.
-- Utilisez le prompt ChatGPT fourni pour générer les 780 questions !
