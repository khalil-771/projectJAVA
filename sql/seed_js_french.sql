-- JavaScript Questions (60 total)
SET @quiz_js_beginner = (SELECT id FROM quizzes WHERE title='JavaScript: Quiz Débutant');
SET @quiz_js_inter = (SELECT id FROM quizzes WHERE title='JavaScript: Quiz Intermédiaire');
SET @quiz_js_adv = (SELECT id FROM quizzes WHERE title='JavaScript: Quiz Avancé');

-- Difficulty: BEGINNER (20 Questions)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Où insérer le code JavaScript dans HTML ?', 'SINGLE_CHOICE', '<script>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<script>',TRUE), (@q,'<js>',FALSE), (@q,'<code ->',FALSE), (@q,'<javascript>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Quel mot-clé déclare une variable ?', 'SINGLE_CHOICE', 'var, let, ou const.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'let',TRUE), (@q,'variable',FALSE), (@q,'dim',FALSE), (@q,'int',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment afficher une alerte ?', 'SINGLE_CHOICE', 'alert()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'alert()',TRUE), (@q,'msg()',FALSE), (@q,'popup()',FALSE), (@q,'box()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment créer une fonction ?', 'SINGLE_CHOICE', 'function myFunc()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'function f()',TRUE), (@q,'def f()',FALSE), (@q,'func f()',FALSE), (@q,'create f()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment appeler une fonction nommée "myFunction" ?', 'SINGLE_CHOICE', 'myFunction()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'myFunction()',TRUE), (@q,'call myFunction',FALSE), (@q,'run myFunction',FALSE), (@q,'myFunction',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment écrire une condition IF ?', 'SINGLE_CHOICE', 'if (condition)', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'if (i == 5)',TRUE), (@q,'if i = 5 then',FALSE), (@q,'if i == 5 then',FALSE), (@q,'check i == 5',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment faire une boucle FOR ?', 'SINGLE_CHOICE', 'for (i = 0; i < 5; i++)', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'for(let i=0; i<5; i++)',TRUE), (@q,'for i to 5',FALSE), (@q,'for(i <= 5)',FALSE), (@q,'loop 5',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment ajouter un commentaire une ligne ?', 'SINGLE_CHOICE', '//', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'//',TRUE), (@q,'<!-- -->',FALSE), (@q,'#',FALSE), (@q,'**',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment commenter plusieurs lignes ?', 'SINGLE_CHOICE', '/* ... */', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'/* ... */',TRUE), (@q,'<!-- ... -->',FALSE), (@q,'// ...',FALSE), (@q,'# ... #',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Quel est l''opérateur d''égalité stricte ?', 'SINGLE_CHOICE', '===', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'===',TRUE), (@q,'==',FALSE), (@q,'=',FALSE), (@q,'is',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment déclarer un tableau ?', 'SINGLE_CHOICE', '[]', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'[]',TRUE), (@q,'{}',FALSE), (@q,'()',FALSE), (@q,'List',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Quel événement pour un clic ?', 'SINGLE_CHOICE', 'onclick', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'onclick',TRUE), (@q,'onmouse',FALSE), (@q,'onpress',FALSE), (@q,'ontouch',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment trouver un élément par ID ?', 'SINGLE_CHOICE', 'document.getElementById()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'getElementById',TRUE), (@q,'getElement(id)',FALSE), (@q,'selectId',FALSE), (@q,'findId',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Quel est le type de NaN ?', 'SINGLE_CHOICE', 'number', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'number',TRUE), (@q,'NaN',FALSE), (@q,'undefined',FALSE), (@q,'string',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment convertir string en entier ?', 'SINGLE_CHOICE', 'parseInt()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'parseInt()',TRUE), (@q,'Integer.parse()',FALSE), (@q,'toInt()',FALSE), (@q,'parse()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Laquelle est une variable constante ?', 'SINGLE_CHOICE', 'const', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'const',TRUE), (@q,'let',FALSE), (@q,'var',FALSE), (@q,'fixed',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'L''objet global navigateur est ?', 'SINGLE_CHOICE', 'window', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'window',TRUE), (@q,'browser',FALSE), (@q,'navigator',FALSE), (@q,'screen',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Quelle méthode écrit dans la console ?', 'SINGLE_CHOICE', 'console.log()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'console.log()',TRUE), (@q,'print()',FALSE), (@q,'system.out',FALSE), (@q,'log.console()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'NULL est-il identique à undefined ?', 'SINGLE_CHOICE', 'Non, types différents.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Non',TRUE), (@q,'Oui',FALSE), (@q,'Parfois',FALSE), (@q,'En mode strict',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_beginner, 'Comment obtenir la longueur d''un tableau ?', 'SINGLE_CHOICE', '.length', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.length',TRUE), (@q,'.size()',FALSE), (@q,'.len',FALSE), (@q,'.count',FALSE);

-- Difficulty: INTERMEDIATE (20 Questions for JS)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quelle méthode ajoute à la fin d''un tableau ?', 'SINGLE_CHOICE', 'push()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'push()',TRUE), (@q,'pop()',FALSE), (@q,'shift()',FALSE), (@q,'unshift()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quelle méthode supprime le dernier élément ?', 'SINGLE_CHOICE', 'pop()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'pop()',TRUE), (@q,'push()',FALSE), (@q,'last()',FALSE), (@q,'remove()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Que fait DOM ?', 'SINGLE_CHOICE', 'Document Object Model.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Document Object Model',TRUE), (@q,'Data Object Model',FALSE), (@q,'Document Oriented Model',FALSE), (@q,'Digital Order Model',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quel est le résultat de "5" + 2 ?', 'SINGLE_CHOICE', '"52" (concaténation).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'"52"',TRUE), (@q,'7',FALSE), (@q,'NaN',FALSE), (@q,'Error',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quel est le résultat de "5" - 2 ?', 'SINGLE_CHOICE', '3 (conversion implicite).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'3',TRUE), (@q,'"3"',FALSE), (@q,'NaN',FALSE), (@q,'Error',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Comment transformer objet en JSON string ?', 'SINGLE_CHOICE', 'JSON.stringify()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'JSON.stringify()',TRUE), (@q,'JSON.parse()',FALSE), (@q,'toString()',FALSE), (@q,'JSON.to()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Comment transformer JSON string en objet ?', 'SINGLE_CHOICE', 'JSON.parse()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'JSON.parse()',TRUE), (@q,'JSON.stringify()',FALSE), (@q,'JSON.object()',FALSE), (@q,'eval()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quelle est la portée de var ?', 'SINGLE_CHOICE', 'Fonction ou globale.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Fonction/Globale',TRUE), (@q,'Bloc',FALSE), (@q,'Classe',FALSE), (@q,'Module',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quelle est la portée de let ?', 'SINGLE_CHOICE', 'Bloc.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Bloc',TRUE), (@q,'Fonction',FALSE), (@q,'Globale',FALSE), (@q,'Fichier',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Que fait this dans une fonction globale ?', 'SINGLE_CHOICE', 'Référence fenêtre/global.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Window/Global',TRUE), (@q,'Null',FALSE), (@q,'Undefined',FALSE), (@q,'Object',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Comment capturer une erreur ?', 'SINGLE_CHOICE', 'try...catch', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'try...catch',TRUE), (@q,'try...except',FALSE), (@q,'do...catch',FALSE), (@q,'check...error',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quel mot-clé crée une instance de classe ?', 'SINGLE_CHOICE', 'new', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'new',TRUE), (@q,'create',FALSE), (@q,'instance',FALSE), (@q,'init',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Comment timer une action unique ?', 'SINGLE_CHOICE', 'setTimeout()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'setTimeout()',TRUE), (@q,'setInterval()',FALSE), (@q,'setTimer()',FALSE), (@q,'wait()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Comment répéter une action ?', 'SINGLE_CHOICE', 'setInterval()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'setInterval()',TRUE), (@q,'setTimeout()',FALSE), (@q,'loop()',FALSE), (@q,'repeat()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Que signifie AJAX ?', 'SINGLE_CHOICE', 'Asynchronous JavaScript and XML.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Asynchronous JS & XML',TRUE), (@q,'Active Java XML',FALSE), (@q,'Async JSON',FALSE), (@q,'Advanced JS',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quelle méthode change l''URL sans recharger ?', 'SINGLE_CHOICE', 'history.pushState()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'history.pushState()',TRUE), (@q,'location.href',FALSE), (@q,'window.open',FALSE), (@q,'router.go',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Quel sélecteur CSS pour une classe ?', 'SINGLE_CHOICE', '.classe', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.nom',TRUE), (@q,'#nom',FALSE), (@q,'nom',FALSE), (@q,'*nom',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'forEach s''applique à quoi ?', 'SINGLE_CHOICE', 'Tableaux (Array).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Arrays',TRUE), (@q,'Objects',FALSE), (@q,'Strings',FALSE), (@q,'Numbers',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'L''opérateur ternaire ?', 'SINGLE_CHOICE', 'cond ? vrai : faux', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'? :',TRUE), (@q,'if else',FALSE), (@q,'??',FALSE), (@q,'||',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_inter, 'Que fait event.preventDefault() ?', 'SINGLE_CHOICE', 'Empêche l''action par défaut du navigateur.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Empêche défaut',TRUE), (@q,'Arrête propagation',FALSE), (@q,'Ferme fenêtre',FALSE), (@q,'Valide form',FALSE);

-- Difficulty: ADVANCED (20 Questions for JS)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Qu''est-ce qu''une Closure ?', 'SINGLE_CHOICE', 'Fonction qui se souvient de son scope lexical.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Mémoire scope lexical',TRUE), (@q,'Fermeture fenêtre',FALSE), (@q,'Fin de boucle',FALSE), (@q,'Objet privé',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Que fait bind() ?', 'SINGLE_CHOICE', 'Crée une fonction avec un this fixé.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Fixe this',TRUE), (@q,'Appelle fonction',FALSE), (@q,'Lie événement',FALSE), (@q,'Concatène',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Promise.all() fait quoi ?', 'SINGLE_CHOICE', 'Attend que toutes les promesses soient résolues.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Attend toutes',TRUE), (@q,'Attend première',FALSE), (@q,'Annule toutes',FALSE), (@q,'Exécute série',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Qu''est-ce que le Hoisting ?', 'SINGLE_CHOICE', 'Remontée des déclarations en haut du scope.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Remontée déclarations',TRUE), (@q,'Descente variables',FALSE), (@q,'Suppression code',FALSE), (@q,'Chargement async',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Mode strict ("use strict") modifie quoi ?', 'SINGLE_CHOICE', 'Interdit certaines actions non sécurisées.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Sécurité accrue',TRUE), (@q,'Performance',FALSE), (@q,'Syntaxe ES6',FALSE), (@q,'Rien',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Event bubbling c''est quoi ?', 'SINGLE_CHOICE', 'Propagation de l''événement de l''enfant vers le parent.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Enfant vers Parent',TRUE), (@q,'Parent vers Enfant',FALSE), (@q,'Annulation',FALSE), (@q,'Capture',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Difference entre call() et apply() ?', 'SINGLE_CHOICE', 'apply prends un tableau d''arguments.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'apply prend tableau',TRUE), (@q,'call prend tableau',FALSE), (@q,'Aucune',FALSE), (@q,'call est asynchrone',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Qu''est-ce que le prototype ?', 'SINGLE_CHOICE', 'Mécanisme d''héritage de JavaScript.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Mécanisme héritage',TRUE), (@q,'Objet copie',FALSE), (@q,'Fonction constructeur',FALSE), (@q,' JSON',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Async/Await est du sucre syntaxique pour ?', 'SINGLE_CHOICE', 'Promises.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Promises',TRUE), (@q,'Callbacks',FALSE), (@q,'Events',FALSE), (@q,'Threads',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'localStorage est-il sync ou async ?', 'SINGLE_CHOICE', 'Synchrone (bloquant).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Synchrone',TRUE), (@q,'Asynchrone',FALSE), (@q,'Promesse',FALSE), (@q,'Threadé',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Qu''est-ce que IIFE ?', 'SINGLE_CHOICE', 'Immediately Invoked Function Expression.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Fonction invoquée immédiatement',TRUE), (@q,'If Else',FALSE), (@q,'Import Export',FALSE), (@q,'Internal Interface',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Set vs WeakSet ?', 'SINGLE_CHOICE', 'WeakSet tient des références faibles (garbage collected).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Ref faibles',TRUE), (@q,'Taille fixe',FALSE), (@q,'Clés primitives',FALSE), (@q,'Ordonné',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Que retourne map() ?', 'SINGLE_CHOICE', 'Un nouveau tableau.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Nouveau tableau',TRUE), (@q,'Même tableau',FALSE), (@q,'Rien',FALSE), (@q,'Boolean',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Generator function utilise ?', 'SINGLE_CHOICE', 'function* et yield.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'function* / yield',TRUE), (@q,'async / await',FALSE), (@q,'return',FALSE), (@q,'generate',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Qu''est-ce que la Currying ?', 'SINGLE_CHOICE', 'Transformer f(a,b) en f(a)(b).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'f(a)(b)',TRUE), (@q,'Encryption',FALSE), (@q,'Parsing',FALSE), (@q,'Mixing',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Object.freeze() fait quoi ?', 'SINGLE_CHOICE', 'Rend l''objet immuable.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Immuable',TRUE), (@q,'Caché',FALSE), (@q,'Supprimé',FALSE), (@q,'Constant',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Le symbole (Symbol) sert à quoi ?', 'SINGLE_CHOICE', 'Identifiant unique pour propriétés.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ID unique',TRUE), (@q,'String',FALSE), (@q,'Logo',FALSE), (@q,'Constante math',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Quelle structure pour clé objet ?', 'SINGLE_CHOICE', 'Map (vs Object qui stringify clés).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Map',TRUE), (@q,'Set',FALSE), (@q,'Array',FALSE), (@q,'JSON',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'Service Worker sert à quoi ?', 'SINGLE_CHOICE', 'Script background, offline, cache.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Offline/Cache',TRUE), (@q,'UI Thread',FALSE), (@q,'DOM Access',FALSE), (@q,'Database',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_js_adv, 'WebAssembly (Wasm) c''est quoi ?', 'SINGLE_CHOICE', 'Format binaire pour exécution rapide.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Binaire rapide',TRUE), (@q,'Nouveau JS',FALSE), (@q,'Framework',FALSE), (@q,'Base de données',FALSE);
