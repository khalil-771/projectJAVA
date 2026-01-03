-- Python Questions (60 total)
SET @quiz_py_beginner = (SELECT id FROM quizzes WHERE title='Python: Quiz Débutant');
SET @quiz_py_inter = (SELECT id FROM quizzes WHERE title='Python: Quiz Intermédiaire');
SET @quiz_py_adv = (SELECT id FROM quizzes WHERE title='Python: Quiz Avancé');

-- Difficulty: BEGINNER (20 Questions)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment afficher du texte ?', 'SINGLE_CHOICE', 'print()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'print()',TRUE), (@q,'echo()',FALSE), (@q,'printf()',FALSE), (@q,'log()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel symbole pour les commentaires ?', 'SINGLE_CHOICE', '#', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'#',TRUE), (@q,'//',FALSE), (@q,'/* */',FALSE), (@q,'--',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel mot-clé définit une fonction ?', 'SINGLE_CHOICE', 'def', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'def',TRUE), (@q,'function',FALSE), (@q,'fun',FALSE), (@q,'void',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Python est-il compilé ou interprété ?', 'SINGLE_CHOICE', 'Interprété.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Interprété',TRUE), (@q,'Compilé',FALSE), (@q,'Assemblé',FALSE), (@q,'Machine',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel type pour "Hello" ?', 'SINGLE_CHOICE', 'str', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'str',TRUE), (@q,'int',FALSE), (@q,'char',FALSE), (@q,'bool',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment créer une liste ?', 'SINGLE_CHOICE', '[]', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'[]',TRUE), (@q,'{}',FALSE), (@q,'()',FALSE), (@q,'<>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel est le résultat de 3 ** 2 ?', 'SINGLE_CHOICE', '9 (puissance).', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'9',TRUE), (@q,'6',FALSE), (@q,'5',FALSE), (@q,'1',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment vérifier une condition ?', 'SINGLE_CHOICE', 'if', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'if',TRUE), (@q,'check',FALSE), (@q,'test',FALSE), (@q,'loop',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel opérateur vérifie l''égalité ?', 'SINGLE_CHOICE', '==', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'==',TRUE), (@q,'=',FALSE), (@q,'is equal',FALSE), (@q,'!=',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment convertir "10" en entier ?', 'SINGLE_CHOICE', 'int("10")', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int()',TRUE), (@q,'str()',FALSE), (@q,'float()',FALSE), (@q,'num()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quelle est la valeur booléenne de Faux ?', 'SINGLE_CHOICE', 'False', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'False',TRUE), (@q,'faux',FALSE), (@q,'0',FALSE), (@q,'Non',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment obtenir la taille d''une liste ?', 'SINGLE_CHOICE', 'len()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'len()',TRUE), (@q,'size()',FALSE), (@q,'count()',FALSE), (@q,'length()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment ajouter un élément à une liste ?', 'SINGLE_CHOICE', 'append()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'append()',TRUE), (@q,'add()',FALSE), (@q,'push()',FALSE), (@q,'insert()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel type est (1, 2) ?', 'SINGLE_CHOICE', 'tuple', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'tuple',TRUE), (@q,'list',FALSE), (@q,'set',FALSE), (@q,'dict',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment faire une boucle ?', 'SINGLE_CHOICE', 'for ou while', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'for',TRUE), (@q,'loop',FALSE), (@q,'repeat',FALSE), (@q,'cycle',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quel mot-clé importe une bibliothèque ?', 'SINGLE_CHOICE', 'import', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'import',TRUE), (@q,'include',FALSE), (@q,'require',FALSE), (@q,'load',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quelle est l''extension Python ?', 'SINGLE_CHOICE', '.py', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.py',TRUE), (@q,'.python',FALSE), (@q,'.pt',FALSE), (@q,'.pi',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Comment lire une entrée utilisateur ?', 'SINGLE_CHOICE', 'input()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'input()',TRUE), (@q,'read()',FALSE), (@q,'get()',FALSE), (@q,'scan()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Le bloc if se termine par ?', 'SINGLE_CHOICE', ':', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,':',TRUE), (@q,';',FALSE), (@q,'}',FALSE), (@q,'then',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_beginner, 'Quelle indentation est standard ?', 'SINGLE_CHOICE', '4 espaces', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'4 espaces',TRUE), (@q,'2 espaces',FALSE), (@q,'Tab',FALSE), (@q,'8 espaces',FALSE);

-- Difficulty: INTERMEDIATE (20 Questions for Python)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Quel type est mutable ?', 'SINGLE_CHOICE', 'list est mutable, tuple non.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'list',TRUE), (@q,'tuple',FALSE), (@q,'str',FALSE), (@q,'int',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Comment créer un dictionnaire ?', 'SINGLE_CHOICE', '{}', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'{}',TRUE), (@q,'[]',FALSE), (@q,'()',FALSE), (@q,'Set()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Que fait range(3) ?', 'SINGLE_CHOICE', 'Génère 0, 1, 2', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'0, 1, 2',TRUE), (@q,'1, 2, 3',FALSE), (@q,'0, 1, 2, 3',FALSE), (@q,'3, 2, 1',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Comment gérer les exceptions ?', 'SINGLE_CHOICE', 'try / except', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'try / except',TRUE), (@q,'try / catch',FALSE), (@q,'do / catch',FALSE), (@q,'check / error',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Qu''est-ce que self ?', 'SINGLE_CHOICE', 'Référence à l''instance courante.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Instance courante',TRUE), (@q,'Classe',FALSE), (@q,'Global',FALSE), (@q,'Rien',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Comment ouvrir un fichier proprement ?', 'SINGLE_CHOICE', 'with open(...)', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'with open(...)',TRUE), (@q,'open(...)',FALSE), (@q,'file(...)',FALSE), (@q,'read(...)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Quelle est la sortie de print("Hello"[::-1]) ?', 'SINGLE_CHOICE', 'olleH (inversion)', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'olleH',TRUE), (@q,'Hello',FALSE), (@q,'Error',FALSE), (@q,'H',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Comment importer une seule fonction ?', 'SINGLE_CHOICE', 'from module import func', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'from module import func',TRUE), (@q,'import func from module',FALSE), (@q,'include func',FALSE), (@q,'using func',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Quel module pour les regex ?', 'SINGLE_CHOICE', 're', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'re',TRUE), (@q,'regex',FALSE), (@q,'pyregex',FALSE), (@q,'string',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'À quoi sert __init__ ?', 'SINGLE_CHOICE', 'Constructeur (initialiseur).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Initialiseur',TRUE), (@q,'Destructeur',FALSE), (@q,'Import',FALSE), (@q,'Convertisseur',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Que retourne type(3.14) ?', 'SINGLE_CHOICE', 'float', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'float',TRUE), (@q,'double',FALSE), (@q,'int',FALSE), (@q,'decimal',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Compréhension de liste pour les carrés ?', 'SINGLE_CHOICE', '[x**2 for x in list]', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'[x**2 for x in list]',TRUE), (@q,'list.map(x=>x*2)',FALSE), (@q,'for x in list x*2',FALSE), (@q,'(x**2)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Comment supprimer un élément par index ?', 'SINGLE_CHOICE', 'pop() ou del', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'pop()',TRUE), (@q,'remove()',FALSE), (@q,'delete()',FALSE), (@q,'clear()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Quelle structure a des éléments uniques ?', 'SINGLE_CHOICE', 'set', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'set',TRUE), (@q,'list',FALSE), (@q,'tuple',FALSE), (@q,'dict',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Que fait pass ?', 'SINGLE_CHOICE', 'Rien (placeholder).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Rien',TRUE), (@q,'Arrête',FALSE), (@q,'Retourne',FALSE), (@q,'Passe au suivant',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Comment fusionner deux dicts (3.9+) ?', 'SINGLE_CHOICE', 'd1 | d2', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'d1 | d2',TRUE), (@q,'d1 + d2',FALSE), (@q,'d1.merge(d2)',FALSE), (@q,'d1.append(d2)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Quel mot-clé pour une variable globale ?', 'SINGLE_CHOICE', 'global', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'global',TRUE), (@q,'extern',FALSE), (@q,'static',FALSE), (@q,'var',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Lambda sert à quoi ?', 'SINGLE_CHOICE', 'Fonction anonyme sur une ligne.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Fonction anonyme',TRUE), (@q,'Variable',FALSE), (@q,'Classe',FALSE), (@q,'Boucle',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Comment vérifier si une clé est dans un dict ?', 'SINGLE_CHOICE', 'key in dict', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'key in dict',TRUE), (@q,'dict.has(key)',FALSE), (@q,'dict.contains(key)',FALSE), (@q,'exists(key)',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_inter, 'Zip() fait quoi ?', 'SINGLE_CHOICE', 'Combine deux itérables paire par paire.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Combine itérables',TRUE), (@q,'Compresse fichier',FALSE), (@q,'Trie liste',FALSE), (@q,'Sépare liste',FALSE);

-- Difficulty: ADVANCED (20 Questions for Python)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Qu''est-ce qu''un décorateur ?', 'SINGLE_CHOICE', 'Fonction qui modifie une fonction.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Modifie fonction',TRUE), (@q,'Décore texte',FALSE), (@q,'Classe abstraite',FALSE), (@q,'Variable env',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Que fait le GIL ?', 'SINGLE_CHOICE', 'Limite l''exécution à un thread CPU à la fois.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Limite thread CPU',TRUE), (@q,'Gère mémoire',FALSE), (@q,'Compile code',FALSE), (@q,'Optimise IO',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Qu''est-ce qu''un générateur ?', 'SINGLE_CHOICE', 'Fonction avec yield.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Avec yield',TRUE), (@q,'Avec return',FALSE), (@q,'Avec lambda',FALSE), (@q,'Avec class',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Que fait __new__ ?', 'SINGLE_CHOICE', 'Crée l''instance (avant __init__).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Crée l''instance',TRUE), (@q,'Initialise les champs',FALSE), (@q,'Supprime l''instance',FALSE), (@q,'Copie l''instance',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Quel module pour le multiprocessing ?', 'SINGLE_CHOICE', 'multiprocessing', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'multiprocessing',TRUE), (@q,'threading',FALSE), (@q,'subprocess',FALSE), (@q,'parallel',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Qu''est-ce qu''une métaclasse ?', 'SINGLE_CHOICE', 'La classe d''une classe (type).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Classe d''une classe',TRUE), (@q,'Sous-classe',FALSE), (@q,'Super-classe',FALSE), (@q,'Classe abstraite',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Comment rendre un attribut "privé" ?', 'SINGLE_CHOICE', 'Préfixe __ (double underscore).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Prefix __',TRUE), (@q,'Prefix _',FALSE), (@q,'Mot-clé private',FALSE), (@q,'Mot-clé hidden',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Que fait @staticmethod ?', 'SINGLE_CHOICE', 'Méthode sans accès à instance ou classe.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Sans self ni cls',TRUE), (@q,'Avec self',FALSE), (@q,'Avec cls',FALSE), (@q,'Virtuelle',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Que fait @classmethod ?', 'SINGLE_CHOICE', 'Reçoit la classe (cls) en premier argument.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Reçoit cls',TRUE), (@q,'Reçoit self',FALSE), (@q,'Statique',FALSE), (@q,'Abstraite',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Qu''est-ce que le MRO ?', 'SINGLE_CHOICE', 'Method Resolution Order (ordre héritage).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Method Resolution Order',TRUE), (@q,'Memory Read Operation',FALSE), (@q,'Main Routine Object',FALSE), (@q,'Map Reduce Option',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'À quoi sert pickle ?', 'SINGLE_CHOICE', 'Sérialisation d''objets Python.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Sérialisation',TRUE), (@q,'Compression',FALSE), (@q,'Cryptage',FALSE), (@q,'Parsing',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Que sont *args et **kwargs ?', 'SINGLE_CHOICE', 'Arguments variables (tuple/dict).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Args variables',TRUE), (@q,'Pointers',FALSE), (@q,'Références',FALSE), (@q,'Valeurs par défaut',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Comment créer un context manager ?', 'SINGLE_CHOICE', 'Méthodes __enter__ et __exit__.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'__enter__/__exit__',TRUE), (@q,'__open__/__close__',FALSE), (@q,'__start__/__stop__',FALSE), (@q,'__init__/__del__',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Quelle est la différence entre is et == ?', 'SINGLE_CHOICE', 'is vérifie l''identité, == la valeur.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'is: identité, ==: valeur',TRUE), (@q,'Pareil',FALSE), (@q,'is: valeur, ==: identité',FALSE), (@q,'is pour booléens',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Qu''est-ce qu''une coroutine en Python ?', 'SINGLE_CHOICE', 'Fonction asynchrone (async def).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Async def',TRUE), (@q,'Thread',FALSE), (@q,'Processus',FALSE), (@q,'Générateur simple',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Que fait functools.lru_cache ?', 'SINGLE_CHOICE', 'Cache les résultats de fonction (mémoïsation).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Mémoïsation',TRUE), (@q,'Log des appels',FALSE), (@q,'Debug',FALSE), (@q,'Timeout',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Qu''est-ce que __slots__ ?', 'SINGLE_CHOICE', 'Optimise mémoire en fixant les attributs.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Optimise mémoire',TRUE), (@q,'Gère slots machine',FALSE), (@q,'Héritage multiple',FALSE), (@q,'Signaux',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Comment forcer le Garbage Collection ?', 'SINGLE_CHOICE', 'gc.collect()', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'gc.collect()',TRUE), (@q,'System.gc()',FALSE), (@q,'free()',FALSE), (@q,'delete',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Quel module pour tests unitaires ?', 'SINGLE_CHOICE', 'unittest', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'unittest',TRUE), (@q,'testpy',FALSE), (@q,'pycheck',FALSE), (@q,'exam',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_py_adv, 'Quelle structure de données est la plus rapide pour recherche ?', 'SINGLE_CHOICE', 'set ou dict (table de hachage).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'set/dict',TRUE), (@q,'list',FALSE), (@q,'tuple',FALSE), (@q,'deque',FALSE);
