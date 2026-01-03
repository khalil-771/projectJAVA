-- Seed file: Questions en Français pour Java, Python, JavaScript, SQL
USE quiztests;

-- Ensure difficulty column exists
SET @sql = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'questions' AND COLUMN_NAME = 'difficulty') = 0,
    'ALTER TABLE questions ADD COLUMN difficulty VARCHAR(20) DEFAULT \'BEGINNER\'',
    'SELECT \'Column difficulty already exists\' AS message'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Insert courses (updates if exist)
INSERT INTO courses (title, description, language_tag) VALUES
('Java Basics', 'Introduction aux concepts Java', 'java'),
('Python Basics', 'Introduction à la programmation Python', 'python'),
('JavaScript Basics', 'Introduction à JavaScript', 'js'),
('SQL Basics', 'Introduction au SQL et requêtes', 'sql')
ON DUPLICATE KEY UPDATE title=VALUES(title), description=VALUES(description);

-- Get course ids
SET @course_java = (SELECT id FROM courses WHERE language_tag='java' LIMIT 1);
SET @course_python = (SELECT id FROM courses WHERE language_tag='python' LIMIT 1);
SET @course_js = (SELECT id FROM courses WHERE language_tag='js' LIMIT 1);
SET @course_sql = (SELECT id FROM courses WHERE language_tag='sql' LIMIT 1);

-- Create quizzes
INSERT INTO quizzes (course_id, title, is_final_exam, passing_score)
VALUES 
(@course_java, 'Java: Quiz Débutant', FALSE, 70),
(@course_java, 'Java: Quiz Intermédiaire', FALSE, 75),
(@course_java, 'Java: Quiz Avancé', FALSE, 80),
(@course_python, 'Python: Quiz Débutant', FALSE, 70),
(@course_python, 'Python: Quiz Intermédiaire', FALSE, 75),
(@course_python, 'Python: Quiz Avancé', FALSE, 80),
(@course_js, 'JavaScript: Quiz Débutant', FALSE, 70),
(@course_js, 'JavaScript: Quiz Intermédiaire', FALSE, 75),
(@course_js, 'JavaScript: Quiz Avancé', FALSE, 80),
(@course_sql, 'SQL: Quiz Débutant', FALSE, 70),
(@course_sql, 'SQL: Quiz Intermédiaire', FALSE, 75),
(@course_sql, 'SQL: Quiz Avancé', FALSE, 80)
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), title=VALUES(title);

-- Capture IDs
SET @quiz_java_beginner = (SELECT id FROM quizzes WHERE title='Java: Quiz Débutant');
SET @quiz_java_inter = (SELECT id FROM quizzes WHERE title='Java: Quiz Intermédiaire');
SET @quiz_java_adv = (SELECT id FROM quizzes WHERE title='Java: Quiz Avancé');
SET @quiz_py_beginner = (SELECT id FROM quizzes WHERE title='Python: Quiz Débutant');
SET @quiz_py_inter = (SELECT id FROM quizzes WHERE title='Python: Quiz Intermédiaire');
SET @quiz_py_adv = (SELECT id FROM quizzes WHERE title='Python: Quiz Avancé');
SET @quiz_js_beginner = (SELECT id FROM quizzes WHERE title='JavaScript: Quiz Débutant');
SET @quiz_js_inter = (SELECT id FROM quizzes WHERE title='JavaScript: Quiz Intermédiaire');
SET @quiz_js_adv = (SELECT id FROM quizzes WHERE title='JavaScript: Quiz Avancé');
SET @quiz_sql_beginner = (SELECT id FROM quizzes WHERE title='SQL: Quiz Débutant');
SET @quiz_sql_inter = (SELECT id FROM quizzes WHERE title='SQL: Quiz Intermédiaire');
SET @quiz_sql_adv = (SELECT id FROM quizzes WHERE title='SQL: Quiz Avancé');

-- Clean existing questions to avoid duplicates (optional, use with caution)
-- DELETE FROM questions; 
-- DELETE FROM answers;

-- ==========================================
-- JAVA - DÉBUTANT
-- ==========================================
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel mot-clé est utilisé pour définir une classe en Java ?', 'SINGLE_CHOICE', 'Le mot-clé class est utilisé pour déclarer une classe.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class',TRUE),(@q,'struct',FALSE),(@q,'define',FALSE),(@q,'object',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quelle est la méthode principale (point d''entrée) d''une application Java ?', 'SINGLE_CHOICE', 'public static void main(String[] args) est le point d''entrée.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'public static void main(String[] args)',TRUE),(@q,'public void main()',FALSE),(@q,'static void start()',FALSE),(@q,'public int main()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel type de données est utilisé pour stocker du texte ?', 'SINGLE_CHOICE', 'String est utilisé pour le texte.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'String',TRUE),(@q,'Char',FALSE),(@q,'Text',FALSE),(@q,'Int',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Comment déclarez-vous une variable entière x égale à 5 ?', 'SINGLE_CHOICE', 'int x = 5;', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int x = 5;',TRUE),(@q,'x = 5;',FALSE),(@q,'num x = 5;',FALSE),(@q,'float x = 5;',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel opérateur est utilisé pour comparer l''égalité de deux valeurs primitives ?', 'SINGLE_CHOICE', '== compare les valeurs.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'==',TRUE),(@q,'=',FALSE),(@q,'equals()',FALSE),(@q,'IsEqual',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Que signifie JVM ?', 'SINGLE_CHOICE', 'Java Virtual Machine', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Java Virtual Machine',TRUE),(@q,'Java Variable Method',FALSE),(@q,'Java Visual Model',FALSE),(@q,'Just Virtual Machine',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel mot-clé est utilisé pour l''héritage de classe ?', 'SINGLE_CHOICE', 'extends est utilisé pour hériter d''une classe.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'extends',TRUE),(@q,'implements',FALSE),(@q,'inherits',FALSE),(@q,'super',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quelle boucle s''exécute au moins une fois ?', 'SINGLE_CHOICE', 'do-while vérifie la condition après l''exécution.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'do-while',TRUE),(@q,'while',FALSE),(@q,'for',FALSE),(@q,'foreach',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Comment écrire un commentaire sur une seule ligne ?', 'SINGLE_CHOICE', '// est utilisé pour les commentaires sur une ligne.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'// Commentaire',TRUE),(@q,'/* Commentaire */',FALSE),(@q,'# Commentaire',FALSE),(@q,'-- Commentaire',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel est le résultat de 10 % 3 ?', 'SINGLE_CHOICE', 'L''opérateur % donne le reste de la division.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'1',TRUE),(@q,'3',FALSE),(@q,'0',FALSE),(@q,'10',FALSE);

-- ==========================================
-- JAVA - INTERMÉDIAIRE
-- ==========================================
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle collection n''autorise pas les doublons ?', 'SINGLE_CHOICE', 'Set est une collection d''éléments uniques.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Set',TRUE),(@q,'List',FALSE),(@q,'Map',FALSE),(@q,'Queue',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle est la différence entre "==" et ".equals()" pour les objets ?', 'SINGLE_CHOICE', '== compare les références, equals() compare le contenu.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'== référence, equals() contenu',TRUE),(@q,'C''est la même chose',FALSE),(@q,'== contenu, equals() référence',FALSE),(@q,'equals() pour les primitifs',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quel mot-clé empêche l''héritage d''une classe ?', 'SINGLE_CHOICE', 'final empêche l''héritage ou la redéfinition.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'final',TRUE),(@q,'static',FALSE),(@q,'private',FALSE),(@q,'abstract',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Qu''est-ce que le polymorphisme ?', 'SINGLE_CHOICE', 'La capacité d''un objet à prendre plusieurs formes.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Capacité à prendre plusieurs formes',TRUE),(@q,'Avoir plusieurs constructeurs',FALSE),(@q,'Cacher les données',FALSE),(@q,'Hériter de plusieurs classes',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle interface est utilisée pour trier des objets (tri naturel) ?', 'SINGLE_CHOICE', 'Comparable définit l''ordre naturel.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Comparable',TRUE),(@q,'Comparator',FALSE),(@q,'Sortable',FALSE),(@q,'Order',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quel bloc est toujours exécuté dans un try-catch ?', 'SINGLE_CHOICE', 'finally s''exécute toujours.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'finally',TRUE),(@q,'catch',FALSE),(@q,'try',FALSE),(@q,'throw',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Que signifie "static" pour une méthode ?', 'SINGLE_CHOICE', 'Elle appartient à la classe, pas à une instance.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Appartient à la classe',TRUE),(@q,'Ne peut pas être modifiée',FALSE),(@q,'Visible partout',FALSE),(@q,'Thread-safe',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle classe est thread-safe ?', 'SINGLE_CHOICE', 'Vector est synchronisé (thread-safe).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Vector',TRUE),(@q,'ArrayList',FALSE),(@q,'LinkedList',FALSE),(@q,'HashMap',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'À quoi sert le garbage collector ?', 'SINGLE_CHOICE', 'Libérer automatiquement la mémoire inutilisée.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Libérer la mémoire',TRUE),(@q,'Optimiser le code',FALSE),(@q,'Compiler le code',FALSE),(@q,'Gérer les threads',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Qu''est-ce qu''une classe abstraite ?', 'SINGLE_CHOICE', 'Une classe qui ne peut pas être instanciée.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Ne peut être instanciée',TRUE),(@q,'Ne peut pas avoir de méthodes',FALSE),(@q,'Est toujours statique',FALSE),(@q,'Est finale',FALSE);

-- ==========================================
-- PYTHON - DÉBUTANT
-- ==========================================
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment afficher "Bonjour" en Python ?', 'SINGLE_CHOICE', 'print() est utilisé pour l''affichage.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'print("Bonjour")',TRUE),(@q,'echo "Bonjour"',FALSE),(@q,'printf("Bonjour")',FALSE),(@q,'System.out.print("Bonjour")',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel symbole est utilisé pour les commentaires ?', 'SINGLE_CHOICE', '# démarre un commentaire.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'#',TRUE),(@q,'//',FALSE),(@q,'--',FALSE),(@q,'/* */',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment déclarer une fonction ?', 'SINGLE_CHOICE', 'def est utilisé pour définir une fonction.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'def maFonction():',TRUE),(@q,'function maFonction():',FALSE),(@q,'func maFonction()',FALSE),(@q,'void maFonction()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel est le type d''une liste ?', 'SINGLE_CHOICE', 'Les listes utilisent des crochets [].', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'list',TRUE),(@q,'array',FALSE),(@q,'tuple',FALSE),(@q,'dict',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Que fait l''opérateur "**" ?', 'SINGLE_CHOICE', 'C''est l''opérateur de puissance.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Puissance',TRUE),(@q,'Multiplication',FALSE),(@q,'Division',FALSE),(@q,'Modulo',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quelle méthode ajoute un élément à une liste ?', 'SINGLE_CHOICE', 'append() ajoute à la fin.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'append()',TRUE),(@q,'add()',FALSE),(@q,'push()',FALSE),(@q,'insert()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment obtenir la longueur d''une chaîne ?', 'SINGLE_CHOICE', 'len() retourne la longueur.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'len()',TRUE),(@q,'size()',FALSE),(@q,'length()',FALSE),(@q,'count()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel est le résultat de "3" + "4" ?', 'SINGLE_CHOICE', 'Concaténation de chaînes.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'"34"',TRUE),(@q,'7',FALSE),(@q,'"7"',FALSE),(@q,'Erreur',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel mot-clé commence une boucle conditionnelle ?', 'SINGLE_CHOICE', 'if pour les conditions.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'if',TRUE),(@q,'when',FALSE),(@q,'check',FALSE),(@q,'loop',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Les tuples sont-ils immuables ?', 'SINGLE_CHOICE', 'Oui, on ne peut pas modifier un tuple.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Vrai',TRUE),(@q,'Faux',FALSE),(@q,'Dépend',FALSE),(@q,'Uniquement les nombres',FALSE);

-- ==========================================
-- SQL - DÉBUTANT
-- ==========================================
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quelle commande récupère des données ?', 'SINGLE_CHOICE', 'SELECT est utilisé pour lire les données.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'SELECT',TRUE),(@q,'GET',FALSE),(@q,'FETCH',FALSE),(@q,'RETRIEVE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quelle clause filtre les résultats ?', 'SINGLE_CHOICE', 'WHERE spécifie les conditions.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'WHERE',TRUE),(@q,'FILTER',FALSE),(@q,'HAVING',FALSE),(@q,'IF',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quelle commande ajoute une ligne ?', 'SINGLE_CHOICE', 'INSERT INTO ajoute des données.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'INSERT',TRUE),(@q,'ADD',FALSE),(@q,'UPDATE',FALSE),(@q,'CREATE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quelle commande modifie des données existantes ?', 'SINGLE_CHOICE', 'UPDATE modifie les enregistrements.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UPDATE',TRUE),(@q,'MODIFY',FALSE),(@q,'CHANGE',FALSE),(@q,'ALTER',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quelle commande supprime une table ?', 'SINGLE_CHOICE', 'DROP TABLE supprime la table et ses données.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'DROP',TRUE),(@q,'DELETE',FALSE),(@q,'REMOVE',FALSE),(@q,'ERASE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quel symbole sélectionne toutes les colonnes ?', 'SINGLE_CHOICE', '* est le joker pour tout.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'*',TRUE),(@q,'%',FALSE),(@q,'ALL',FALSE),(@q,'&',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quelle contrainte assure l''unicité ?', 'SINGLE_CHOICE', 'UNIQUE garantit des valeurs distinctes.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UNIQUE',TRUE),(@q,'PRIMARY KEY',FALSE),(@q,'DISTINCT',FALSE),(@q,'FOREIGN KEY',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quelle fonction compte les lignes ?', 'SINGLE_CHOICE', 'COUNT() retourne le nombre de lignes.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'COUNT()',TRUE),(@q,'SUM()',FALSE),(@q,'TOTAL()',FALSE),(@q,'NUMBER()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Quelle clause trie les résultats ?', 'SINGLE_CHOICE', 'ORDER BY trie les résultats.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ORDER BY',TRUE),(@q,'SORT BY',FALSE),(@q,'GROUP BY',FALSE),(@q,'ARRANGE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_beginner, 'Que signifie SQL ?', 'SINGLE_CHOICE', 'Structured Query Language', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Structured Query Language',TRUE),(@q,'Simple Query Language',FALSE),(@q,'Standard Question Library',FALSE),(@q,'System Query Logic',FALSE);

-- ==========================================
-- JAVASCRIPT - DÉBUTANT
-- ==========================================
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Dans quelle balise HTML place-t-on le JS ?', 'SINGLE_CHOICE', '<script> est la balise correcte.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<script>',TRUE),(@q,'<js>',FALSE),(@q,'<javascript>',FALSE),(@q,'<code>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment déclarer une variable modifiable ?', 'SINGLE_CHOICE', 'let déclare une variable locale modifiable.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'let',TRUE),(@q,'const',FALSE),(@q,'variable',FALSE),(@q,'dim',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Quel est l''opérateur d''égalité stricte ?', 'SINGLE_CHOICE', '=== vérifie valeur et type.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'===',TRUE),(@q,'==',FALSE),(@q,'=',FALSE),(@q,'equals',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment afficher une alerte ?', 'SINGLE_CHOICE', 'alert() affiche une boîte de dialogue.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'alert()',TRUE),(@q,'msg()',FALSE),(@q,'popup()',FALSE),(@q,'warn()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment écrire une fonction fléchée ?', 'SINGLE_CHOICE', '() => {} est la syntaxe ES6.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'() => {}',TRUE),(@q,'func -> {}',FALSE),(@q,'=> {}',FALSE),(@q,'function {}',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Quel objet représente le navigateur ?', 'SINGLE_CHOICE', 'window est l''objet global du navigateur.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'window',TRUE),(@q,'browser',FALSE),(@q,'navigator',FALSE),(@q,'client',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment ajouter un élément à la fin d''un tableau ?', 'SINGLE_CHOICE', 'push() ajoute à la fin.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'push()',TRUE),(@q,'add()',FALSE),(@q,'append()',FALSE),(@q,'insert()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Que retourne "typeof []" ?', 'SINGLE_CHOICE', 'Les tableaux sont des objets en JS.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'object',TRUE),(@q,'array',FALSE),(@q,'list',FALSE),(@q,'undefined',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Quel événement détecte un clic ?', 'SINGLE_CHOICE', 'onclick (ou click avec addEventListener).', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'onclick',TRUE),(@q,'onmouse',FALSE),(@q,'onpress',FALSE),(@q,'ontouch',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment convertir une chaîne en entier ?', 'SINGLE_CHOICE', 'parseInt() convertit en entier.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'parseInt()',TRUE),(@q,'toInteger()',FALSE),(@q,'parse()',FALSE),(@q,'int()',FALSE);

-- ==========================================
-- SQL - INTERMÉDIAIRE
-- ==========================================
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Quelle jointure retourne les lignes communes ?', 'SINGLE_CHOICE', 'INNER JOIN retourne les correspondances.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'INNER JOIN',TRUE),(@q,'LEFT JOIN',FALSE),(@q,'RIGHT JOIN',FALSE),(@q,'OUTER JOIN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Quelle clause groupe les résultats ?', 'SINGLE_CHOICE', 'GROUP BY regroupe pour les agrégations.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'GROUP BY',TRUE),(@q,'ORDER BY',FALSE),(@q,'AGGREGATE',FALSE),(@q,'CLUSTER',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Quelle condition filtre après un GROUP BY ?', 'SINGLE_CHOICE', 'HAVING filtre les groupes.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'HAVING',TRUE),(@q,'WHERE',FALSE),(@q,'FILTER',FALSE),(@q,'WHEN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Comment supprimer les doublons d''un résultat ?', 'SINGLE_CHOICE', 'DISTINCT supprime les doublons.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'SELECT DISTINCT',TRUE),(@q,'SELECT UNIQUE',FALSE),(@q,'SELECT DIFFERENT',FALSE),(@q,'SELECT SINGLE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Quelle fonction retourne la moyenne ?', 'SINGLE_CHOICE', 'AVG() calcule la moyenne.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'AVG()',TRUE),(@q,'MEAN()',FALSE),(@q,'AVERAGE()',FALSE),(@q,'MEDIAN()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Qu''est-ce qu''une clé étrangère ?', 'SINGLE_CHOICE', 'Un lien vers la clé primaire d''une autre table.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Lien vers autre table',TRUE),(@q,'Clé unique',FALSE),(@q,'Index rapide',FALSE),(@q,'Clé primaire secondaire',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Comment annuler une transaction ?', 'SINGLE_CHOICE', 'ROLLBACK annule les changements.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ROLLBACK',TRUE),(@q,'COMMIT',FALSE),(@q,'CANCEL',FALSE),(@q,'UNDO',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Quelle jointure retourne tout de la table de gauche ?', 'SINGLE_CHOICE', 'LEFT JOIN garde tout à gauche.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'LEFT JOIN',TRUE),(@q,'INNER JOIN',FALSE),(@q,'RIGHT JOIN',FALSE),(@q,'FULL JOIN',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Comment combiner les résultats de deux requêtes ?', 'SINGLE_CHOICE', 'UNION combine les résultats.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'UNION',TRUE),(@q,'JOIN',FALSE),(@q,'MERGE',FALSE),(@q,'COMBINE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_sql_inter, 'Que fait TRUNCATE TABLE ?', 'SINGLE_CHOICE', 'Vide la table rapidement sans supprimer la structure.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Vide la table',TRUE),(@q,'Supprime la table',FALSE),(@q,'Supprime une ligne',FALSE),(@q,'Compacte la table',FALSE);
