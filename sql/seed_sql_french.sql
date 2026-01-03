-- SQL Questions (60 total)
SET @quiz_sql_beginner = (SELECT id FROM quizzes WHERE title='SQL: Quiz Débutant');
SET @quiz_sql_inter = (SELECT id FROM quizzes WHERE title='SQL: Quiz Intermédiaire');
SET @quiz_sql_adv = (SELECT id FROM quizzes WHERE title='SQL: Quiz Avancé');

-- Difficulty: BEGINNER
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Que signifie SQL ?', 'SINGLE_CHOICE', 'Structured Query Language', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Structured Query Language',TRUE), (@q,'Strong Question Language',FALSE), (@q,'Structured Question List',FALSE), (@q,'Simple Query Language',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Commande pour récupérer données ?', 'SINGLE_CHOICE', 'SELECT', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'SELECT',TRUE), (@q,'GET',FALSE), (@q,'FETCH',FALSE), (@q,'OPEN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Commande pour mettre à jour ?', 'SINGLE_CHOICE', 'UPDATE', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UPDATE',TRUE), (@q,'MODIFY',FALSE), (@q,'CHANGE',FALSE), (@q,'SAVE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Commande pour supprimer données ?', 'SINGLE_CHOICE', 'DELETE', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'DELETE',TRUE), (@q,'REMOVE',FALSE), (@q,'DROP',FALSE), (@q,'CLEAR',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Commande pour insérer données ?', 'SINGLE_CHOICE', 'INSERT INTO', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'INSERT INTO',TRUE), (@q,'ADD',FALSE), (@q,'PUT',FALSE), (@q,'CREATE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Créer une table ?', 'SINGLE_CHOICE', 'CREATE TABLE', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'CREATE TABLE',TRUE), (@q,'NEW TABLE',FALSE), (@q,'MAKE TABLE',FALSE), (@q,'ADD TABLE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Supprimer une table ?', 'SINGLE_CHOICE', 'DROP TABLE', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'DROP TABLE',TRUE), (@q,'DELETE TABLE',FALSE), (@q,'REMOVE TABLE',FALSE), (@q,'EXIT TABLE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Filtrer les résultats ?', 'SINGLE_CHOICE', 'WHERE', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'WHERE',TRUE), (@q,'FILTER',FALSE), (@q,'IF',FALSE), (@q,'WHEN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Trier les résultats ?', 'SINGLE_CHOICE', 'ORDER BY', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ORDER BY',TRUE), (@q,'SORT BY',FALSE), (@q,'ARRANGE',FALSE), (@q,'GROUP BY',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Sélectionner tous les champs ?', 'SINGLE_CHOICE', '*', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'*',TRUE), (@q,'ALL',FALSE), (@q,'%',FALSE), (@q,'EACH',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Opérateur égalité ?', 'SINGLE_CHOICE', '=', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'=',TRUE), (@q,'==',FALSE), (@q,'===',FALSE), (@q,'IS',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Opérateur différent ?', 'SINGLE_CHOICE', '<> ou !=', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<>',TRUE), (@q,'not',FALSE), (@q,'diff',FALSE), (@q,'~=',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Condition ET ?', 'SINGLE_CHOICE', 'AND', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'AND',TRUE), (@q,'&&',FALSE), (@q,'&',FALSE), (@q,'ET',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Condition OU ?', 'SINGLE_CHOICE', 'OR', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'OR',TRUE), (@q,'||',FALSE), (@q,'|',FALSE), (@q,'OU',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Valeur nulle ?', 'SINGLE_CHOICE', 'NULL', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'NULL',TRUE), (@q,'0',FALSE), (@q,'EMPTY',FALSE), (@q,'VOID',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Vérifier si null ?', 'SINGLE_CHOICE', 'IS NULL', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'IS NULL',TRUE), (@q,'= NULL',FALSE), (@q,'== NULL',FALSE), (@q,'EQUALS NULL',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Limite résultats ?', 'SINGLE_CHOICE', 'LIMIT', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'LIMIT',TRUE), (@q,'TOP',FALSE), (@q,'MAX',FALSE), (@q,'STOP',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Valeurs uniques ?', 'SINGLE_CHOICE', 'DISTINCT', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'DISTINCT',TRUE), (@q,'UNIQUE',FALSE), (@q,'SINGLE',FALSE), (@q,'ONLY',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Compter lignes ?', 'SINGLE_CHOICE', 'COUNT()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'COUNT()',TRUE), (@q,'SUM()',FALSE), (@q,'TOTAL()',FALSE), (@q,'NUMBER()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Chaine de caractères ?', 'SINGLE_CHOICE', 'VARCHAR', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'VARCHAR',TRUE), (@q,'STRING',FALSE), (@q,'TEXTO',FALSE), (@q,'CHARS',FALSE);

-- Difficulty: INTERMEDIATE
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Jointure interne ?', 'SINGLE_CHOICE', 'INNER JOIN', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'INNER JOIN',TRUE), (@q,'JOIN IN',FALSE), (@q,'INSIDE JOIN',FALSE), (@q,'OUTER JOIN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Jointure gauche ?', 'SINGLE_CHOICE', 'LEFT JOIN', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'LEFT JOIN',TRUE), (@q,'LEFT OUTER',FALSE), (@q,'G JOIN',FALSE), (@q,'JOIN LEFT',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Grouper résultats ?', 'SINGLE_CHOICE', 'GROUP BY', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'GROUP BY',TRUE), (@q,'ORDER BY',FALSE), (@q,'AGGREGATE',FALSE), (@q,'COLLECT',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Filtrer après groupement ?', 'SINGLE_CHOICE', 'HAVING', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'HAVING',TRUE), (@q,'WHERE',FALSE), (@q,'AFTER',FALSE), (@q,'FILTER',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Clé primaire ?', 'SINGLE_CHOICE', 'PRIMARY KEY', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'PRIMARY KEY',TRUE), (@q,'MAIN KEY',FALSE), (@q,'FIRST KEY',FALSE), (@q,'UNIQUE KEY',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Clé étrangère ?', 'SINGLE_CHOICE', 'FOREIGN KEY', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'FOREIGN KEY',TRUE), (@q,'REMOTE KEY',FALSE), (@q,'SECOND KEY',FALSE), (@q,'LINK KEY',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Alias colonne ?', 'SINGLE_CHOICE', 'AS', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'AS',TRUE), (@q,'ALIAS',FALSE), (@q,'LIKE',FALSE), (@q,'NAME',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Recherche motif (wildcard) ?', 'SINGLE_CHOICE', 'LIKE', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'LIKE',TRUE), (@q,'MATCH',FALSE), (@q,'SEARCH',FALSE), (@q,'CONTAINS',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Caractère joker % ?', 'SINGLE_CHOICE', 'N''importe quelle chaîne.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'N''importe chaîne',TRUE), (@q,'Un seul caractère',FALSE), (@q,'Début',FALSE), (@q,'Fin',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Caractère joker _ ?', 'SINGLE_CHOICE', 'Un seul caractère.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Un caractère',TRUE), (@q,'N''importe chaîne',FALSE), (@q,'Espace',FALSE), (@q,'Rien',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Vérifier liste valeurs ?', 'SINGLE_CHOICE', 'IN', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'IN',TRUE), (@q,'LIST',FALSE), (@q,'WITHIN',FALSE), (@q,'BETWEEN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Vérifier intervalle ?', 'SINGLE_CHOICE', 'BETWEEN', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'BETWEEN',TRUE), (@q,'RANGE',FALSE), (@q,'INTERVAL',FALSE), (@q,'FROM TO',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Concaténer chaines (MySQL) ?', 'SINGLE_CHOICE', 'CONCAT()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'CONCAT()',TRUE), (@q,'+',FALSE), (@q,'||',FALSE), (@q,'MERGE()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Date actuelle ?', 'SINGLE_CHOICE', 'NOW()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'NOW()',TRUE), (@q,'DATE()',FALSE), (@q,'TODAY()',FALSE), (@q,'TIME()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Somme colonne ?', 'SINGLE_CHOICE', 'SUM()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'SUM()',TRUE), (@q,'TOTAL()',FALSE), (@q,'ADD()',FALSE), (@q,'ACOUNT()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Moyenne colonne ?', 'SINGLE_CHOICE', 'AVG()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'AVG()',TRUE), (@q,'MEAN()',FALSE), (@q,'AVERAGE()',FALSE), (@q,'MEDIAN()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Maximum ?', 'SINGLE_CHOICE', 'MAX()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'MAX()',TRUE), (@q,'TOP()',FALSE), (@q,'HIGH()',FALSE), (@q,'PEAK()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Minimum ?', 'SINGLE_CHOICE', 'MIN()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'MIN()',TRUE), (@q,'LOW()',FALSE), (@q,'BOTTOM()',FALSE), (@q,'LEAST()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Changer structure table ?', 'SINGLE_CHOICE', 'ALTER TABLE', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ALTER TABLE',TRUE), (@q,'CHANGE TABLE',FALSE), (@q,'MODIFY TABLE',FALSE), (@q,'UPDATE TABLE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Index ?', 'SINGLE_CHOICE', 'Améliore perf lecture, ralentit écriture.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Améliore lecture',TRUE), (@q,'Améliore écriture',FALSE), (@q,'Sert à rien',FALSE), (@q,'Trie table',FALSE);

-- Difficulty: ADVANCED
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Transaction début ?', 'SINGLE_CHOICE', 'START TRANSACTION', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'START TRANSACTION',TRUE), (@q,'BEGIN TRANS',FALSE), (@q,'OPEN TRANS',FALSE), (@q,'TRANS START',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Valider transaction ?', 'SINGLE_CHOICE', 'COMMIT', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'COMMIT',TRUE), (@q,'SAVE',FALSE), (@q,'DONE',FALSE), (@q,'PUSH',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Annuler transaction ?', 'SINGLE_CHOICE', 'ROLLBACK', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ROLLBACK',TRUE), (@q,'CANCEL',FALSE), (@q,'UNDO',FALSE), (@q,'ABORT',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Vue (View) ?', 'SINGLE_CHOICE', 'Table virtuelle (requête stockée).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Table virtuelle',TRUE), (@q,'Table physique',FALSE), (@q,'Index',FALSE), (@q,'Clé',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Procédure stockée ?', 'SINGLE_CHOICE', 'Code SQL exécuté coté serveur.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Code serveur',TRUE), (@q,'Script client',FALSE), (@q,'Table',FALSE), (@q,'Vue',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Trigger ?', 'SINGLE_CHOICE', 'Action auto sur événement.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Action auto',TRUE), (@q,'Bouton',FALSE), (@q,'Fonction',FALSE), (@q,'Index',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'UNION ?', 'SINGLE_CHOICE', 'Combine résultats sans doublons.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UNION',TRUE), (@q,'UNION ALL',FALSE), (@q,'JOIN',FALSE), (@q,'ADD',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'UNION ALL ?', 'SINGLE_CHOICE', 'Combine résultats avec doublons.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UNION ALL',TRUE), (@q,'UNION',FALSE), (@q,'JOIN ALL',FALSE), (@q,'MERGE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Normalisation ?', 'SINGLE_CHOICE', 'Réduire redondance données.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Réduire redondance',TRUE), (@q,'Augmenter vitesse',FALSE), (@q,'Crypter',FALSE), (@q,'Sauvegarder',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Injection SQL ?', 'SINGLE_CHOICE', 'Faille sécurité code malveillant.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Faille sécurité',TRUE), (@q,'Méthode insertion',FALSE), (@q,'Optimisation',FALSE), (@q,'Type données',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'ACID ?', 'SINGLE_CHOICE', 'Atomicity, Consistency, Isolation, Durability.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ACID',TRUE), (@q,'BASE',FALSE), (@q,'SOLID',FALSE), (@q,'CRUD',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Full Outer Join (MySQL) ?', 'SINGLE_CHOICE', 'Pas supporté (utiliser UNION).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Utiliser UNION',TRUE), (@q,'FULL OUTER JOIN',FALSE), (@q,'FULL JOIN',FALSE), (@q,'OUTER JOIN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Sous-requête ?', 'SINGLE_CHOICE', 'SELECT imbriqué.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'SELECT imbriqué',TRUE), (@q,'JOIN',FALSE), (@q,'VIEW',FALSE), (@q,'TABLE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Contrainte check (MySQL 8) ?', 'SINGLE_CHOICE', 'Valide condition sur données.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Valide condition',TRUE), (@q,'Vérifie clé',FALSE), (@q,'Check table',FALSE), (@q,'Debug',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Index unique ?', 'SINGLE_CHOICE', 'Valeurs uniques obligatoires.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Valeurs uniques',TRUE), (@q,'Clé primaire',FALSE), (@q,'Non null',FALSE), (@q,'Rapide',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Difference DELETE / TRUNCATE ?', 'SINGLE_CHOICE', 'TRUNCATE réinitialise (plus rapide, DDL).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'TRUNCATE plus rapide',TRUE), (@q,'DELETE plus rapide',FALSE), (@q,'Pareil',FALSE), (@q,'TRUNCATE = WHERE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Self Join ?', 'SINGLE_CHOICE', 'Jointure table avec elle-même.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Jointure elle-même',TRUE), (@q,'Jointure auto',FALSE), (@q,'Jointure seule',FALSE), (@q,'Non',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Collation ?', 'SINGLE_CHOICE', 'Règles tri et comparaison char.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Règles tri',TRUE), (@q,'Encodage',FALSE), (@q,'Stockage',FALSE), (@q,'Collection',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Engine InnoDB supporte ?', 'SINGLE_CHOICE', 'Transactions et clés étrangères.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Transactions',TRUE), (@q,'Fulltext (vieux)',FALSE), (@q,'Rapide lecture seule',FALSE), (@q,'Pas de crash recovery',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_adv, 'Window function ?', 'SINGLE_CHOICE', 'OVER()', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'OVER()',TRUE), (@q,'WINDOW()',FALSE), (@q,'FRAME()',FALSE), (@q,'PARTITION()',FALSE);
