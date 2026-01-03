-- Kotlin Questions (60 total)
SET @quiz_kt_beginner = (SELECT id FROM quizzes WHERE title='Kotlin: Quiz Débutant');
SET @quiz_kt_inter = (SELECT id FROM quizzes WHERE title='Kotlin: Quiz Intermédiaire');
SET @quiz_kt_adv = (SELECT id FROM quizzes WHERE title='Kotlin: Quiz Avancé');

-- Difficulty: BEGINNER
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Extension fichier Kotlin ?', 'SINGLE_CHOICE', '.kt', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.kt',TRUE), (@q,'.ko',FALSE), (@q,'.java',FALSE), (@q,'.kts',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Point d''entrée ?', 'SINGLE_CHOICE', 'fun main()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'fun main()',TRUE), (@q,'public static main',FALSE), (@q,'func main()',FALSE), (@q,'start()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Afficher texte ?', 'SINGLE_CHOICE', 'println()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'println()',TRUE), (@q,'System.out.print',FALSE), (@q,'console.log',FALSE), (@q,'echo',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Variable immuable (constante) ?', 'SINGLE_CHOICE', 'val', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'val',TRUE), (@q,'var',FALSE), (@q,'const',FALSE), (@q,'let',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Variable mutable ?', 'SINGLE_CHOICE', 'var', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'var',TRUE), (@q,'val',FALSE), (@q,'mutable',FALSE), (@q,'let',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Définir une fonction ?', 'SINGLE_CHOICE', 'fun', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'fun',TRUE), (@q,'func',FALSE), (@q,'function',FALSE), (@q,'def',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Type d''entier ?', 'SINGLE_CHOICE', 'Int', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Int',TRUE), (@q,'Integer',FALSE), (@q,'int',FALSE), (@q,'Number',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Kotlin est-il interopérable avec Java ?', 'SINGLE_CHOICE', 'Oui, à 100%.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Oui 100%',TRUE), (@q,'Non',FALSE), (@q,'Un peu',FALSE), (@q,'Impossible',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Type chaîne ?', 'SINGLE_CHOICE', 'String', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'String',TRUE), (@q,'str',FALSE), (@q,'Text',FALSE), (@q,'char[]',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Commentaire ligne ?', 'SINGLE_CHOICE', '//', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'//',TRUE), (@q,'#',FALSE), (@q,'--',FALSE), (@q,'rem',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Interpolation chaîne ?', 'SINGLE_CHOICE', '$variable', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'$variable',TRUE), (@q,'%variable',FALSE), (@q,'{variable}',FALSE), (@q,'#variable',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Terminer ligne par ; ?', 'SINGLE_CHOICE', 'Optionnel.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Optionnel',TRUE), (@q,'Obligatoire',FALSE), (@q,'Interdit',FALSE), (@q,'Jamais',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Valeur nulle possible ?', 'SINGLE_CHOICE', 'Type?', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Type?',TRUE), (@q,'Type',FALSE), (@q,'Null<Type>',FALSE), (@q,'Optional',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Classe par défaut ?', 'SINGLE_CHOICE', 'public final', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Final',TRUE), (@q,'Open',FALSE), (@q,'Abstract',FALSE), (@q,'Private',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Mot-clé pour permettre héritage ?', 'SINGLE_CHOICE', 'open', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'open',TRUE), (@q,'virtual',FALSE), (@q,'extendable',FALSE), (@q,'public',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Opérateur égalité structurelle ?', 'SINGLE_CHOICE', '==', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'==',TRUE), (@q,'===',FALSE), (@q,'equals',FALSE), (@q,'is',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Boucle liste ?', 'SINGLE_CHOICE', 'for (item in list)', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'for (in)',TRUE), (@q,'foreach',FALSE), (@q,'loop',FALSE), (@q,'iterate',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Créer une instance (sans new) ?', 'SINGLE_CHOICE', 'val x = Classe()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Classe()',TRUE), (@q,'new Classe()',FALSE), (@q,'create Classe()',FALSE), (@q,'init Classe()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Condition if expression ?', 'SINGLE_CHOICE', 'val x = if(...) else ...', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Oui',TRUE), (@q,'Non',FALSE), (@q,'Seulement switch',FALSE), (@q,'Jamais',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_beginner, 'Type booléen ?', 'SINGLE_CHOICE', 'Boolean', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Boolean',TRUE), (@q,'bool',FALSE), (@q,'Bit',FALSE), (@q,'True',FALSE);

-- Difficulty: INTERMEDIATE
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Switch case en Kotlin ?', 'SINGLE_CHOICE', 'when', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'when',TRUE), (@q,'switch',FALSE), (@q,'case',FALSE), (@q,'match',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Data class ?', 'SINGLE_CHOICE', 'Stocke données, génère toString/equals.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Stocke données',TRUE), (@q,'Interface',FALSE), (@q,'Abstraite',FALSE), (@q,'Singleton',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Safe call operator ?', 'SINGLE_CHOICE', '?.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'?.',TRUE), (@q,'!!',FALSE), (@q,'?:',FALSE), (@q,':.',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Elvis operator ?', 'SINGLE_CHOICE', '?:', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'?:',TRUE), (@q,'?.',FALSE), (@q,'!!',FALSE), (@q,'::',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Not-null assertion ?', 'SINGLE_CHOICE', '!!', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'!!',TRUE), (@q,'?.',FALSE), (@q,'?:',FALSE), (@q,'nonnull',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Initialisation tardive ?', 'SINGLE_CHOICE', 'lateinit var', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'lateinit',TRUE), (@q,'lazy',FALSE), (@q,'defer',FALSE), (@q,'later',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Initialisation paresseuse (constante) ?', 'SINGLE_CHOICE', 'by lazy', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'by lazy',TRUE), (@q,'lateinit',FALSE), (@q,'delayed',FALSE), (@q,'async',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Singleton object ?', 'SINGLE_CHOICE', 'object NomClasse', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'object',TRUE), (@q,'class static',FALSE), (@q,'singleton',FALSE), (@q,'instance',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Companion Object ?', 'SINGLE_CHOICE', 'Membres statiques dans une classe.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Companion Object',TRUE), (@q,'Static Block',FALSE), (@q,'Global',FALSE), (@q,'Friend',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Extension function ?', 'SINGLE_CHOICE', 'fun String.maMethode()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Extension',TRUE), (@q,'Héritage',FALSE), (@q,'Mixin',FALSE), (@q,'Decorator',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Smart cast ?', 'SINGLE_CHOICE', 'if (x is String) ...', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Smart cast',TRUE), (@q,'Auto cast',FALSE), (@q,'Magic cast',FALSE), (@q,'Direct cast',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'List immuable ?', 'SINGLE_CHOICE', 'listOf()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'listOf()',TRUE), (@q,'mutableListOf()',FALSE), (@q,'ArrayList()',FALSE), (@q,'List()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'List mutable ?', 'SINGLE_CHOICE', 'mutableListOf()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'mutableListOf()',TRUE), (@q,'listOf()',FALSE), (@q,'List()',FALSE), (@q,'constList()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Boucle range ?', 'SINGLE_CHOICE', '1..10', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'1..10',TRUE), (@q,'1 to 10',FALSE), (@q,'range(1,10)',FALSE), (@q,'1-10',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Lambda syntaxe ?', 'SINGLE_CHOICE', '{ x -> x * 2 }', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'{ a -> b }',TRUE), (@q,'(a) => b',FALSE), (@q,'lambda a : b',FALSE), (@q,'[a](b)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Apply scope function ?', 'SINGLE_CHOICE', 'Configure objet, retourne objet.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Configure et retourne',TRUE), (@q,'Retourne résultat lambda',FALSE), (@q,'Transforme',FALSE), (@q,'Ferme',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Check type ?', 'SINGLE_CHOICE', 'is', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'is',TRUE), (@q,'instanceof',FALSE), (@q,'typeof',FALSE), (@q,'check',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Primary constructor ?', 'SINGLE_CHOICE', 'class C(val x: Int)', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Dans entête classe',TRUE), (@q,'Dans corps',FALSE), (@q,'Méthode init',FALSE), (@q,'Constructeur vide',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Init block ?', 'SINGLE_CHOICE', 'init { }', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'init { }',TRUE), (@q,'start { }',FALSE), (@q,'constructor { }',FALSE), (@q,'setup { }',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_inter, 'Visibilité par défaut ?', 'SINGLE_CHOICE', 'public', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'public',TRUE), (@q,'internal',FALSE), (@q,'private',FALSE), (@q,'protected',FALSE);

-- Difficulty: ADVANCED
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Coroutines ?', 'SINGLE_CHOICE', 'Threads légers pour asynchrone.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Threads légers',TRUE), (@q,'Processus lourds',FALSE), (@q,'Services',FALSE), (@q,'Callbacks',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Mot-clé suspend ?', 'SINGLE_CHOICE', 'Fonction qui peut être suspendue.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Fonction suspendue',TRUE), (@q,'Arrêt thread',FALSE), (@q,'Pause programme',FALSE), (@q,'Erreur',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Sealed class ?', 'SINGLE_CHOICE', 'Hiérarchie fermée (enums puissants).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Hiérarchie fermée',TRUE), (@q,'Classe finale',FALSE), (@q,'Interface',FALSE), (@q,'Classe abstraite',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Delegated properties ?', 'SINGLE_CHOICE', 'by Delegate()', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'by Delegate',TRUE), (@q,'using Delegate',FALSE), (@q,'with Delegate',FALSE), (@q,'from Delegate',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Type Unit ?', 'SINGLE_CHOICE', 'Equivalent de void (retourne objet).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Equivalent void',TRUE), (@q,'1',FALSE), (@q,'0',FALSE), (@q,'Null',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Type Nothing ?', 'SINGLE_CHOICE', 'Fonction qui ne retourne jamais (throw).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Ne retourne jamais',TRUE), (@q,'Vide',FALSE), (@q,'Null',FALSE), (@q,'Void',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Inline function ?', 'SINGLE_CHOICE', 'Remplace appel par code (perf lambdas).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Performance lambdas',TRUE), (@q,'Code en ligne',FALSE), (@q,'Fonction locale',FALSE), (@q,'Récursion',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Reified type parameters ?', 'SINGLE_CHOICE', 'Accès type générique au runtime (inline).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Type runtime',TRUE), (@q,'Type effacé',FALSE), (@q,'Type variable',FALSE), (@q,'Type statique',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Destructuring declaration ?', 'SINGLE_CHOICE', 'val (name, age) = person', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'val (a,b) = obj',TRUE), (@q,'val a,b = obj',FALSE), (@q,'val [a,b] = obj',FALSE), (@q,'split obj',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Infix function ?', 'SINGLE_CHOICE', 'Appel sans point ni parenthèses.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Syntaxe infixe',TRUE), (@q,'Opérateur',FALSE), (@q,'Préfixe',FALSE), (@q,'Suffixe',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Tailrec ?', 'SINGLE_CHOICE', 'Optimise récursion terminale.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Optim récursion',TRUE), (@q,'Fin fonction',FALSE), (@q,'Dernier appel',FALSE), (@q,'Boucle',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Alias de type ?', 'SINGLE_CHOICE', 'typealias', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'typealias',TRUE), (@q,'typedef',FALSE), (@q,'using',FALSE), (@q,'define',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Scope function : let ?', 'SINGLE_CHOICE', 'Exécute lambda, retourne résultat (it).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Retourne res',TRUE), (@q,'Retourne objet',FALSE), (@q,'Configure',FALSE), (@q,'Rien',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Scope function : also ?', 'SINGLE_CHOICE', 'Exécute action add., retourne objet (it).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Retourne objet',TRUE), (@q,'Retourne res',FALSE), (@q,'Transforme',FALSE), (@q,'Mappe',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Backing field ?', 'SINGLE_CHOICE', 'field dans accesseur custom.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'field',TRUE), (@q,'value',FALSE), (@q,'this',FALSE), (@q,'_field',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Variance : out ?', 'SINGLE_CHOICE', 'Covariance (Producer).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Covariance',TRUE), (@q,'Contravariance',FALSE), (@q,'Invariance',FALSE), (@q,'Any',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Variance : in ?', 'SINGLE_CHOICE', 'Contravariance (Consumer).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Contravariance',TRUE), (@q,'Covariance',FALSE), (@q,'Invariance',FALSE), (@q,'Any',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Annotation use-site targets ?', 'SINGLE_CHOICE', '@get:Rule, @param:Json...', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Cible annotation',TRUE), (@q,'Créer annotation',FALSE), (@q,'Suppr annotation',FALSE), (@q,'Lire annotation',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Operator overloading ?', 'SINGLE_CHOICE', 'operator fun plus(...)', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'operator fun',TRUE), (@q,'override op',FALSE), (@q,'overload',FALSE), (@q,'fun +',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_kt_adv, 'Exécuter coroutine bloquante ?', 'SINGLE_CHOICE', 'runBlocking', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'runBlocking',TRUE), (@q,'GlobalScope',FALSE), (@q,'launch',FALSE), (@q,'async',FALSE);
