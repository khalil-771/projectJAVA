-- =============================================================
-- SCRIPT D'OUTILS POUR AJOUTER DES QUESTIONS
-- =============================================================
-- Exécutez ce script UNE FOIS pour installer la commande "AddQ".
-- Ensuite, vous pourrez utiliser les scripts générés par ChatGPT.
-- =============================================================

USE quiztests;

DELIMITER //

-- Suppression de l'ancienne version si elle existe
DROP PROCEDURE IF EXISTS AddQ //

-- Création de la procédure
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
    
    -- 1. Trouver le Quiz par son titre Exact (ou partiel)
    SET q_quiz_id = (SELECT id FROM quizzes WHERE title = quizTitle LIMIT 1);
    
    -- Si pas de match exact, essai partiel (ex: "Java" pour "Java - Débutant")
    IF q_quiz_id IS NULL THEN
        SET q_quiz_id = (SELECT id FROM quizzes WHERE title LIKE CONCAT('%', quizTitle, '%') LIMIT 1);
    END IF;

    -- 2. Insérer la question si le quiz est trouvé
    IF q_quiz_id IS NOT NULL THEN
        INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) 
        VALUES (q_quiz_id, qText, 'SINGLE_CHOICE', expl, diff);
        
        -- Récupérer l'ID de la question créée
        SET @qid = LAST_INSERT_ID();
        
        -- 3. Insérer les 4 réponses
        INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, goodAns, TRUE);
        INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad1, FALSE);
        INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad2, FALSE);
        INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@qid, bad3, FALSE);
        
        -- SELECT CONCAT('✅ Question ajoutée au quiz : ', quizTitle) AS Status;
    ELSE
        -- SELECT CONCAT('❌ ERREUR : Quiz introuvable pour le titre "', quizTitle, '"') AS Status;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERREUR: Quiz introuvable, verifiez le titre';
    END IF;
END //

DELIMITER ;

SELECT 'INSTALLATION RÉUSSIE : Vous pouvez maintenant utiliser CALL AddQ(...) !' AS Message;
