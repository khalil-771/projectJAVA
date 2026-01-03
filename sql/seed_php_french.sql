-- PHP Questions (60 total)
SET @quiz_php_beginner = (SELECT id FROM quizzes WHERE title='PHP: Quiz Débutant');
SET @quiz_php_inter = (SELECT id FROM quizzes WHERE title='PHP: Quiz Intermédiaire');
SET @quiz_php_adv = (SELECT id FROM quizzes WHERE title='PHP: Quiz Avancé');

-- Difficulty: BEGINNER
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Que signifie PHP ?', 'SINGLE_CHOICE', 'PHP: Hypertext Preprocessor', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Hypertext Preprocessor',TRUE), (@q,'Personal Home Page',FALSE), (@q,'Private Home Page',FALSE), (@q,'Program Home Page',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Balise ouverture PHP ?', 'SINGLE_CHOICE', '<?php', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<?php',TRUE), (@q,'<php>',FALSE), (@q,'<?',FALSE), (@q,'<script>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Afficher texte ?', 'SINGLE_CHOICE', 'echo', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'echo',TRUE), (@q,'print',FALSE), (@q,'write',FALSE), (@q,'display',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Déclarer variable ?', 'SINGLE_CHOICE', '$nom', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'$nom',TRUE), (@q,'var nom',FALSE), (@q,'let nom',FALSE), (@q,'nom',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Fin instruction ?', 'SINGLE_CHOICE', ';', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,';',TRUE), (@q,':',FALSE), (@q,'.',FALSE), (@q,',',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Concaténation ?', 'SINGLE_CHOICE', '.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.',TRUE), (@q,'+',FALSE), (@q,'&',FALSE), (@q,',',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Commentaire multi-lignes ?', 'SINGLE_CHOICE', '/* ... */', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'/* */',TRUE), (@q,'//',FALSE), (@q,'#',FALSE), (@q,'<!-- -->',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Tableau indexé ?', 'SINGLE_CHOICE', '$tab = array("a", "b");', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'array()',TRUE), (@q,'[]',FALSE), (@q,'list()',FALSE), (@q,'dict()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Structure conditionnelle ?', 'SINGLE_CHOICE', 'if', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'if',TRUE), (@q,'check',FALSE), (@q,'when',FALSE), (@q,'cond',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Boucle itérative ?', 'SINGLE_CHOICE', 'for', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'for',TRUE), (@q,'loop',FALSE), (@q,'repeat',FALSE), (@q,'cycle',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Variable superglobale formulaire POST ?', 'SINGLE_CHOICE', '$_POST', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'$_POST',TRUE), (@q,'$POST',FALSE), (@q,'$_GET',FALSE), (@q,'$_REQUEST',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Variable superglobale URL ?', 'SINGLE_CHOICE', '$_GET', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'$_GET',TRUE), (@q,'$_POST',FALSE), (@q,'$URL',FALSE), (@q,'$_LINK',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Fonction longueur chaîne ?', 'SINGLE_CHOICE', 'strlen()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'strlen()',TRUE), (@q,'count()',FALSE), (@q,'length()',FALSE), (@q,'size()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Fonction compter éléments tableau ?', 'SINGLE_CHOICE', 'count()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'count()',TRUE), (@q,'sizeof()',FALSE), (@q,'length()',FALSE), (@q,'strn()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Inclusion fichier obligatoire ?', 'SINGLE_CHOICE', 'require', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'require',TRUE), (@q,'include',FALSE), (@q,'import',FALSE), (@q,'load',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Inclusion fichier optionnelle ?', 'SINGLE_CHOICE', 'include', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'include',TRUE), (@q,'require',FALSE), (@q,'using',FALSE), (@q,'add',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Définir fonction ?', 'SINGLE_CHOICE', 'function nom()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'function',TRUE), (@q,'def',FALSE), (@q,'fun',FALSE), (@q,'fn',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Valeur vrai ?', 'SINGLE_CHOICE', 'true', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'true',TRUE), (@q,'1',FALSE), (@q,'ok',FALSE), (@q,'yes',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Opérateur égalité ?', 'SINGLE_CHOICE', '==', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'==',TRUE), (@q,'=',FALSE), (@q,'===',FALSE), (@q,'is',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_beginner, 'Type null ?', 'SINGLE_CHOICE', 'null', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'null',TRUE), (@q,'NULL',FALSE), (@q,'0',FALSE), (@q,'void',FALSE);

-- Difficulty: INTERMEDIATE
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Tableau associatif ?', 'SINGLE_CHOICE', '["clé" => "valeur"]', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'=>',TRUE), (@q,':',FALSE), (@q,'=',FALSE), (@q,'->',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Parcourir tableau ?', 'SINGLE_CHOICE', 'foreach', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'foreach',TRUE), (@q,'for',FALSE), (@q,'while',FALSE), (@q,'map',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Opérateur objet ?', 'SINGLE_CHOICE', '->', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'->',TRUE), (@q,'.',FALSE), (@q,'::',FALSE), (@q,'=>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Opérateur résolution portée ?', 'SINGLE_CHOICE', '::', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'::',TRUE), (@q,'->',FALSE), (@q,'=>',FALSE), (@q,'.',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Variable globale session ?', 'SINGLE_CHOICE', '$_SESSION', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'$_SESSION',TRUE), (@q,'$_COOKIE',FALSE), (@q,'$_GLOBAL',FALSE), (@q,'$SESSION',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Démarrer session ?', 'SINGLE_CHOICE', 'session_start()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'session_start()',TRUE), (@q,'start_session()',FALSE), (@q,'session_init()',FALSE), (@q,'session()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Définir constante ?', 'SINGLE_CHOICE', 'define("NOM", "valeur")', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'define()',TRUE), (@q,'const',FALSE), (@q,'constant()',FALSE), (@q,'def',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Vérifier existe variable ?', 'SINGLE_CHOICE', 'isset()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'isset()',TRUE), (@q,'exist()',FALSE), (@q,'check()',FALSE), (@q,'empty()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Vérifier vide ?', 'SINGLE_CHOICE', 'empty()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'empty()',TRUE), (@q,'isset()',FALSE), (@q,'null()',FALSE), (@q,'void()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Constructeur classe ?', 'SINGLE_CHOICE', '__construct()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'__construct()',TRUE), (@q,'ClassName()',FALSE), (@q,'init()',FALSE), (@q,'new()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Héritage ?', 'SINGLE_CHOICE', 'extends', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'extends',TRUE), (@q,'implements',FALSE), (@q,'inherits',FALSE), (@q,'using',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Interface ?', 'SINGLE_CHOICE', 'implements', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'implements',TRUE), (@q,'extends',FALSE), (@q,'uses',FALSE), (@q,'interface',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Fonction anonyme (closure) ?', 'SINGLE_CHOICE', 'function() { ... }', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Closure',TRUE), (@q,'Lambda',FALSE), (@q,'Anon',FALSE), (@q,'Block',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Rediriger header ?', 'SINGLE_CHOICE', 'header("Location: ...")', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'header()',TRUE), (@q,'redirect()',FALSE), (@q,'go()',FALSE), (@q,'nav()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Encoder JSON ?', 'SINGLE_CHOICE', 'json_encode()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'json_encode',TRUE), (@q,'json_str',FALSE), (@q,'to_json',FALSE), (@q,'encode_json',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Décoder JSON ?', 'SINGLE_CHOICE', 'json_decode()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'json_decode',TRUE), (@q,'json_parse',FALSE), (@q,'from_json',FALSE), (@q,'decode_json',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Type strict ?', 'SINGLE_CHOICE', 'declare(strict_types=1);', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'strict_types=1',TRUE), (@q,'use strict',FALSE), (@q,'strict mode',FALSE), (@q,'type_check',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Mot-clé parent ?', 'SINGLE_CHOICE', 'parent::', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'parent::',TRUE), (@q,'super',FALSE), (@q,'base',FALSE), (@q,'this',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Mot-clé instance courante ?', 'SINGLE_CHOICE', '$this', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'$this',TRUE), (@q,'self',FALSE), (@q,'me',FALSE), (@q,'obj',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_inter, 'Hash mot de passe ?', 'SINGLE_CHOICE', 'password_hash()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'password_hash()',TRUE), (@q,'md5()',FALSE), (@q,'sha1()',FALSE), (@q,'crypt()',FALSE);

-- Difficulty: ADVANCED
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Composer ?', 'SINGLE_CHOICE', 'Gestionnaire de dépendances.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Dépendances',TRUE), (@q,'Compilateur',FALSE), (@q,'Editeur',FALSE), (@q,'Serveur',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'PSR ?', 'SINGLE_CHOICE', 'PHP Standards Recommendations.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Standards',TRUE), (@q,'Server',FALSE), (@q,'Speed',FALSE), (@q,'Source',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Trait ?', 'SINGLE_CHOICE', 'Réutilisation code horiztontale.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Trait',TRUE), (@q,'Interface',FALSE), (@q,'Abstract',FALSE), (@q,'Module',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Utiliser un Trait ?', 'SINGLE_CHOICE', 'use NomTrait;', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'use',TRUE), (@q,'implements',FALSE), (@q,'extends',FALSE), (@q,'with',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Namespace ?', 'SINGLE_CHOICE', 'namespace Mon\Espace;', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'namespace',TRUE), (@q,'package',FALSE), (@q,'module',FALSE), (@q,'folder',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Autoloading ?', 'SINGLE_CHOICE', 'Chargement automatique classes.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Autoloading',TRUE), (@q,'Autocoding',FALSE), (@q,'Preload',FALSE), (@q,'Imports',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'PDO ?', 'SINGLE_CHOICE', 'PHP Data Objects (Abstraction DB).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'PHP Data Objects',TRUE), (@q,'Persistent Obj',FALSE), (@q,'Public Data Obj',FALSE), (@q,'Program Data Obj',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Préparer requête PDO ?', 'SINGLE_CHOICE', 'prepare()', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'prepare()',TRUE), (@q,'query()',FALSE), (@q,'exec()',FALSE), (@q,'run()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Generator (yield) ?', 'SINGLE_CHOICE', 'Itérateur simple mémoire efficace.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Generator',TRUE), (@q,'Array',FALSE), (@q,'Loop',FALSE), (@q,'Recursive',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Méthode magique get ?', 'SINGLE_CHOICE', '__get($prop)', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'__get',TRUE), (@q,'get',FALSE), (@q,'magic_get',FALSE), (@q,'read',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Méthode magique call ?', 'SINGLE_CHOICE', '__call($method, $args)', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'__call',TRUE), (@q,'call',FALSE), (@q,'invoke',FALSE), (@q,'run',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Classe anonyme ?', 'SINGLE_CHOICE', 'new class { ... }', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'new class',TRUE), (@q,'anon class',FALSE), (@q,'lambda',FALSE), (@q,'closure',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Null Coalescing Operator ?', 'SINGLE_CHOICE', '??', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'??',TRUE), (@q,'?:',FALSE), (@q,'||',FALSE), (@q,'&&',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Spaceship operator ?', 'SINGLE_CHOICE', '<=>', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<=>',TRUE), (@q,'<==>',FALSE), (@q,'!=',FALSE), (@q,'===',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Type return ?', 'SINGLE_CHOICE', ': type', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,': type',TRUE), (@q,'-> type',FALSE), (@q,'returns type',FALSE), (@q,'as type',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Propriété typée (7.4+) ?', 'SINGLE_CHOICE', 'public int $id;', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'public type $var',TRUE), (@q,'var type $var',FALSE), (@q,'type $var',FALSE), (@q,'$var : type',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Arrow function (fn) ?', 'SINGLE_CHOICE', 'fn($x) => $x * 2', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'fn() => expr',TRUE), (@q,'function() =>',FALSE), (@q,'lambda',FALSE), (@q,'->',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Opérateur spread ?', 'SINGLE_CHOICE', '...$arr', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'...',TRUE), (@q,'**',FALSE), (@q,'&',FALSE), (@q,'->',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'Match expression (8.0) ?', 'SINGLE_CHOICE', 'match ($v) { ... }', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'match',TRUE), (@q,'switch',FALSE), (@q,'select',FALSE), (@q,'case',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_php_adv, 'JIT Compiler ?', 'SINGLE_CHOICE', 'Just In Time compilation (PHP 8).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'JIT',TRUE), (@q,'JVM',FALSE), (@q,'GCC',FALSE), (@q,'JDK',FALSE);
