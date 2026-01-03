-- C Questions (60 total)
SET @quiz_c_beginner = (SELECT id FROM quizzes WHERE title='C: Quiz Débutant');
SET @quiz_c_inter = (SELECT id FROM quizzes WHERE title='C: Quiz Intermédiaire');
SET @quiz_c_adv = (SELECT id FROM quizzes WHERE title='C: Quiz Avancé');

-- Difficulty: BEGINNER
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Quelle est l''extension des fichiers C ?', 'SINGLE_CHOICE', '.c', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.c',TRUE), (@q,'.cpp',FALSE), (@q,'.h',FALSE), (@q,'.txt',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Fonction principale ?', 'SINGLE_CHOICE', 'main()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'main()',TRUE), (@q,'start()',FALSE), (@q,'init()',FALSE), (@q,'begin()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Afficher texte ?', 'SINGLE_CHOICE', 'printf()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'printf()',TRUE), (@q,'print()',FALSE), (@q,'cout <<',FALSE), (@q,'write()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Lire entier ?', 'SINGLE_CHOICE', 'scanf("%d", &v)', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'scanf',TRUE), (@q,'read',FALSE), (@q,'cin >>',FALSE), (@q,'input',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Inclure librairie standard ?', 'SINGLE_CHOICE', '#include <stdio.h>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'stdio.h',TRUE), (@q,'iostream',FALSE), (@q,'stdlib',FALSE), (@q,'main.h',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Type nombre entier ?', 'SINGLE_CHOICE', 'int', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int',TRUE), (@q,'integer',FALSE), (@q,'num',FALSE), (@q,'float',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Type nombre décimal ?', 'SINGLE_CHOICE', 'float', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'float',TRUE), (@q,'real',FALSE), (@q,'decimal',FALSE), (@q,'int',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Type caractère ?', 'SINGLE_CHOICE', 'char', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'char',TRUE), (@q,'string',FALSE), (@q,'text',FALSE), (@q,'byte',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Fin d''instruction ?', 'SINGLE_CHOICE', ';', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,';',TRUE), (@q,':',FALSE), (@q,'.',FALSE), (@q,',',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Boucle itérative ?', 'SINGLE_CHOICE', 'for', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'for',TRUE), (@q,'loop',FALSE), (@q,'repeat',FALSE), (@q,'foreach',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Structure conditionnelle ?', 'SINGLE_CHOICE', 'if', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'if',TRUE), (@q,'check',FALSE), (@q,'when',FALSE), (@q,'cond',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Opérateur ET ?', 'SINGLE_CHOICE', '&&', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'&&',TRUE), (@q,'&',FALSE), (@q,'AND',FALSE), (@q,'et',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Opérateur OU ?', 'SINGLE_CHOICE', '||', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'||',TRUE), (@q,'|',FALSE), (@q,'OR',FALSE), (@q,'ou',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Début bloc de code ?', 'SINGLE_CHOICE', '{', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'{',TRUE), (@q,'(',FALSE), (@q,'[',FALSE), (@q,'begin',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Fin bloc de code ?', 'SINGLE_CHOICE', '}', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'}',TRUE), (@q,')',FALSE), (@q,']',FALSE), (@q,'end',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Commentaire simple ?', 'SINGLE_CHOICE', '//', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'//',TRUE), (@q,'#',FALSE), (@q,'--',FALSE), (@q,'rem',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Format entier printf ?', 'SINGLE_CHOICE', '%d', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'%d',TRUE), (@q,'%s',FALSE), (@q,'%f',FALSE), (@q,'%c',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Format string printf ?', 'SINGLE_CHOICE', '%s', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'%s',TRUE), (@q,'%d',FALSE), (@q,'%f',FALSE), (@q,'%char',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Retour fonction ?', 'SINGLE_CHOICE', 'return', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'return',TRUE), (@q,'back',FALSE), (@q,'end',FALSE), (@q,'exit',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_beginner, 'Librairie math ?', 'SINGLE_CHOICE', 'math.h', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'math.h',TRUE), (@q,'cmath',FALSE), (@q,'calc.h',FALSE), (@q,'maths',FALSE);

-- Difficulty: INTERMEDIATE
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Taille d''un int (usuellement) ?', 'SINGLE_CHOICE', '4 octets (32 bits).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'4 octets',TRUE), (@q,'2 octets',FALSE), (@q,'8 octets',FALSE), (@q,'1 octet',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Opérateur adresse ?', 'SINGLE_CHOICE', '&', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'&',TRUE), (@q,'*',FALSE), (@q,'->',FALSE), (@q,'@',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Pointeur déclare ?', 'SINGLE_CHOICE', 'int *ptr;', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int *ptr',TRUE), (@q,'int &ptr',FALSE), (@q,'ptr int',FALSE), (@q,'pointer int',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Valeur pointeur null ?', 'SINGLE_CHOICE', 'NULL', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'NULL',TRUE), (@q,'0',FALSE), (@q,'nullptr',FALSE), (@q,'void',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Tableau de 10 int ?', 'SINGLE_CHOICE', 'int t[10];', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int t[10]',TRUE), (@q,'array int 10',FALSE), (@q,'int 10 t',FALSE), (@q,'table t 10',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Chaîne de caractères ??', 'SINGLE_CHOICE', 'Tableau de char terminé par \0.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Tableau char + \0',TRUE), (@q,'String object',FALSE), (@q,'Type string',FALSE), (@q,'Liste char',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Copier chaîne ?', 'SINGLE_CHOICE', 'strcpy()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'strcpy()',TRUE), (@q,'copystr()',FALSE), (@q,'strcopy()',FALSE), (@q,'cp()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Longueur chaîne ?', 'SINGLE_CHOICE', 'strlen()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'strlen()',TRUE), (@q,'length()',FALSE), (@q,'size()',FALSE), (@q,'count()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Structure ?', 'SINGLE_CHOICE', 'struct', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'struct',TRUE), (@q,'class',FALSE), (@q,'type',FALSE), (@q,'record',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Accès membre structure ?', 'SINGLE_CHOICE', '.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.',TRUE), (@q,'->',FALSE), (@q,':',FALSE), (@q,'::',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Accès membre via pointeur ?', 'SINGLE_CHOICE', '->', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'->',TRUE), (@q,'.',FALSE), (@q,'*',FALSE), (@q,'&',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Allocation mémoire ?', 'SINGLE_CHOICE', 'malloc()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'malloc()',TRUE), (@q,'new',FALSE), (@q,'alloc',FALSE), (@q,'create',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Libération mémoire ?', 'SINGLE_CHOICE', 'free()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'free()',TRUE), (@q,'delete',FALSE), (@q,'remove',FALSE), (@q,'drop',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Switch case ?', 'SINGLE_CHOICE', 'switch(var) { case 1: ... }', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'switch',TRUE), (@q,'select',FALSE), (@q,'choose',FALSE), (@q,'match',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Mot-clé pour arrêter boucle ?', 'SINGLE_CHOICE', 'break', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'break',TRUE), (@q,'stop',FALSE), (@q,'exit',FALSE), (@q,'halt',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Continuer boucle ?', 'SINGLE_CHOICE', 'continue', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'continue',TRUE), (@q,'next',FALSE), (@q,'skip',FALSE), (@q,'pass',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Alias de type ?', 'SINGLE_CHOICE', 'typedef', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'typedef',TRUE), (@q,'alias',FALSE), (@q,'using',FALSE), (@q,'def',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Variable constante ?', 'SINGLE_CHOICE', 'const', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'const',TRUE), (@q,'final',FALSE), (@q,'static',FALSE), (@q,'fixed',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Fichier en-tête ?', 'SINGLE_CHOICE', '.h', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.h',TRUE), (@q,'.c',FALSE), (@q,'.inc',FALSE), (@q,'.head',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_inter, 'Macro définition ?', 'SINGLE_CHOICE', '#define', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'#define',TRUE), (@q,'macro',FALSE), (@q,'const',FALSE), (@q,'set',FALSE);

-- Difficulty: ADVANCED
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Pointeur de fonction ?', 'SINGLE_CHOICE', 'void (*f)(int);', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'void (*f)(int)',TRUE), (@q,'void *f(int)',FALSE), (@q,'function f',FALSE), (@q,'ptr f',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Qu''est-ce que void* ?', 'SINGLE_CHOICE', 'Pointeur générique.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Générique',TRUE), (@q,'Null',FALSE), (@q,'Fonction',FALSE), (@q,'Entier',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Mot-clé static (variable locale) ?', 'SINGLE_CHOICE', 'Persiste entre appels.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Persiste',TRUE), (@q,'Constante',FALSE), (@q,'Globale',FALSE), (@q,'Sur pile',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Mot-clé volatile ?', 'SINGLE_CHOICE', 'Empêche optimisation compilo.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Pas optim.',TRUE), (@q,'Temporaire',FALSE), (@q,'Rapide',FALSE), (@q,'Thread',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Union ?', 'SINGLE_CHOICE', 'Membres partagent même mémoire.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Partagent mémoire',TRUE), (@q,'Structure',FALSE), (@q,'Liste',FALSE), (@q,'Jointure',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Bitwise AND ?', 'SINGLE_CHOICE', '&', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'&',TRUE), (@q,'&&',FALSE), (@q,'|',FALSE), (@q,'^',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Bitwise XOR ?', 'SINGLE_CHOICE', '^', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'^',TRUE), (@q,'|',FALSE), (@q,'&',FALSE), (@q,'~',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Opérateur ternaire ?', 'SINGLE_CHOICE', 'cond ? a : b', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'? :',TRUE), (@q,'if else',FALSE), (@q,'??',FALSE), (@q,'|',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Préprocesseur conditionnel ?', 'SINGLE_CHOICE', '#ifdef', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'#ifdef',TRUE), (@q,'if',FALSE), (@q,'when',FALSE), (@q,'check',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Taille d''un pointeur (64 bits) ?', 'SINGLE_CHOICE', '8 octets.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'8 octets',TRUE), (@q,'4 octets',FALSE), (@q,'2 octets',FALSE), (@q,'16 octets',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'calloc vs malloc ?', 'SINGLE_CHOICE', 'calloc initialise à zéro.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Initialise zéro',TRUE), (@q,'Plus rapide',FALSE), (@q,'Plus lent',FALSE), (@q,'Pareil',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'realloc ?', 'SINGLE_CHOICE', 'Redimensionne bloc mémoire.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Redimensionne',TRUE), (@q,'Libère',FALSE), (@q,'Alloue nouveau',FALSE), (@q,'Copie',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Argument Ligne Commande ?', 'SINGLE_CHOICE', 'argc, argv', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'argc, argv',TRUE), (@q,'args',FALSE), (@q,'params',FALSE), (@q,'input',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Fichier binaire ?', 'SINGLE_CHOICE', 'fopen(f, "rb")', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'"rb"',TRUE), (@q,'"r"',FALSE), (@q,'"bin"',FALSE), (@q,'"b"',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'fseek ?', 'SINGLE_CHOICE', 'Déplace le curseur fichier.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Déplace curseur',TRUE), (@q,'Lit fichier',FALSE), (@q,'Écrit fichier',FALSE), (@q,'Ferme fichier',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'extern ?', 'SINGLE_CHOICE', 'Variable définie ailleurs.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Défini ailleurs',TRUE), (@q,'Exporté',FALSE), (@q,'Interne',FALSE), (@q,'Module',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'enum ?', 'SINGLE_CHOICE', 'Énumération de constantes entières.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Enumération',TRUE), (@q,'Liste chaînes',FALSE), (@q,'Tableau',FALSE), (@q,'Classe',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Segfault (Segmentation Fault) ?', 'SINGLE_CHOICE', 'Accès mémoire interdit.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Accès mémoire interdit',TRUE), (@q,'Erreur division',FALSE), (@q,'Erreur syntaxe',FALSE), (@q,'Erreur type',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Memory Leak ?', 'SINGLE_CHOICE', 'Mémoire non libérée.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Non libérée',TRUE), (@q,'Trop de mémoire',FALSE), (@q,'Mémoire corrompue',FALSE), (@q,'Mémoire vide',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_c_adv, 'Complément à 2 ?', 'SINGLE_CHOICE', 'Représentation nombres négatifs.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Nombres négatifs',TRUE), (@q,'Inverse binaire',FALSE), (@q,'Double précision',FALSE), (@q,'Grand nombre',FALSE);
