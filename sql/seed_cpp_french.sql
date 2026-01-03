-- C++ Questions (60 total)
SET @quiz_cpp_beginner = (SELECT id FROM quizzes WHERE title='C++: Quiz Débutant');
SET @quiz_cpp_inter = (SELECT id FROM quizzes WHERE title='C++: Quiz Intermédiaire');
SET @quiz_cpp_adv = (SELECT id FROM quizzes WHERE title='C++: Quiz Avancé');

-- Difficulty: BEGINNER
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quelle est l''extension des fichiers C++ ?', 'SINGLE_CHOICE', '.cpp', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.cpp',TRUE), (@q,'.c',FALSE), (@q,'.java',FALSE), (@q,'.py',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quel opérateur affiche dans la console ?', 'SINGLE_CHOICE', 'cout <<', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'cout <<',TRUE), (@q,'cin >>',FALSE), (@q,'print()',FALSE), (@q,'printf',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Comment lire une entrée utilisateur ?', 'SINGLE_CHOICE', 'cin >>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'cin >>',TRUE), (@q,'cout <<',FALSE), (@q,'read()',FALSE), (@q,'input()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quel symbole termine une instruction ?', 'SINGLE_CHOICE', ';', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,';',TRUE), (@q,':',FALSE), (@q,'.',FALSE), (@q,',',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quelle fonction est le point d''entrée ?', 'SINGLE_CHOICE', 'main()', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'main()',TRUE), (@q,'start()',FALSE), (@q,'begin()',FALSE), (@q,'run()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quel mot-clé inclut une librairie ?', 'SINGLE_CHOICE', '#include', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'#include',TRUE), (@q,'import',FALSE), (@q,'using',FALSE), (@q,'require',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quel type pour un nombre entier ?', 'SINGLE_CHOICE', 'int', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int',TRUE), (@q,'float',FALSE), (@q,'double',FALSE), (@q,'string',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Commentaires sur une ligne ?', 'SINGLE_CHOICE', '//', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'//',TRUE), (@q,'/*',FALSE), (@q,'#',FALSE), (@q,'--',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quelle librairie pour entrées/sorties ?', 'SINGLE_CHOICE', 'iostream', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'iostream',TRUE), (@q,'stdio',FALSE), (@q,'conio',FALSE), (@q,'stream',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quelle valeur pour vrai ?', 'SINGLE_CHOICE', 'true', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'true',TRUE), (@q,'1',FALSE), (@q,'vrai',FALSE), (@q,'ok',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quel type pour un caractère ?', 'SINGLE_CHOICE', 'char', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'char',TRUE), (@q,'string',FALSE), (@q,'text',FALSE), (@q,'byte',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Quel namespace standard ?', 'SINGLE_CHOICE', 'std', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'std',TRUE), (@q,'system',FALSE), (@q,'standard',FALSE), (@q,'main',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Opérateur d''égalité ?', 'SINGLE_CHOICE', '==', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'==',TRUE), (@q,'=',FALSE), (@q,'!=',FALSE), (@q,'is',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Opérateur d''affectation ?', 'SINGLE_CHOICE', '=', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'=',TRUE), (@q,'==',FALSE), (@q,'<-',FALSE), (@q,':=',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Boucle tant que ?', 'SINGLE_CHOICE', 'while', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'while',TRUE), (@q,'for',FALSE), (@q,'do',FALSE), (@q,'repeat',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Condition "sinon" ?', 'SINGLE_CHOICE', 'else', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'else',TRUE), (@q,'elif',FALSE), (@q,'other',FALSE), (@q,'default',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Mot-clé pour constante ?', 'SINGLE_CHOICE', 'const', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'const',TRUE), (@q,'final',FALSE), (@q,'static',FALSE), (@q,'let',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Retourner valeur ?', 'SINGLE_CHOICE', 'return', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'return',TRUE), (@q,'back',FALSE), (@q,'send',FALSE), (@q,'out',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Tableau d''entiers ?', 'SINGLE_CHOICE', 'int tab[];', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int tab[];',TRUE), (@q,'array int;',FALSE), (@q,'[int] tab;',FALSE), (@q,'tab : int;',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_beginner, 'Commentaire multi-lignes ?', 'SINGLE_CHOICE', '/* */', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'/* */',TRUE), (@q,'//',FALSE), (@q,'#',FALSE), (@q,'--',FALSE);

-- Difficulty: INTERMEDIATE
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Qu''est-ce qu''un pointeur ?', 'SINGLE_CHOICE', 'Variable stockant une adresse mémoire.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Adresse mémoire',TRUE), (@q,'Valeur directe',FALSE), (@q,'Référence',FALSE), (@q,'Tableau',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Opérateur d''adresse ?', 'SINGLE_CHOICE', '&', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'&',TRUE), (@q,'*',FALSE), (@q,'->',FALSE), (@q,'.',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Opérateur de déréférencement ?', 'SINGLE_CHOICE', '*', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'*',TRUE), (@q,'&',FALSE), (@q,'->',FALSE), (@q,'::',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Mot-clé pour classe ?', 'SINGLE_CHOICE', 'class', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class',TRUE), (@q,'struct',FALSE), (@q,'object',FALSE), (@q,'new',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Accès membre privé ?', 'SINGLE_CHOICE', 'Impossible directement hors classe.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Impossible hors classe',TRUE), (@q,'Public',FALSE), (@q,'Protégé',FALSE), (@q,'Ami',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Constructeur par défaut ?', 'SINGLE_CHOICE', 'Même nom que la classe, sans arguments.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Sans arguments',TRUE), (@q,'argument void',FALSE), (@q,'Méthode init',FALSE), (@q,'Avec return',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Destructeur ?', 'SINGLE_CHOICE', '~NomClasse()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'~NomClasse()',TRUE), (@q,'!NomClasse()',FALSE), (@q,'deleteClasse()',FALSE), (@q,'-NomClasse()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Héritage public ?', 'SINGLE_CHOICE', 'class B : public A', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class B : public A',TRUE), (@q,'class B extends A',FALSE), (@q,'class B implements A',FALSE), (@q,'class B inherits A',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Fonction virtuelle ?', 'SINGLE_CHOICE', 'virtual', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'virtual',TRUE), (@q,'abstract',FALSE), (@q,'override',FALSE), (@q,'dynamic',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Allocation dynamique ?', 'SINGLE_CHOICE', 'new', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'new',TRUE), (@q,'malloc',FALSE), (@q,'alloc',FALSE), (@q,'create',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Libérer mémoire (new) ?', 'SINGLE_CHOICE', 'delete', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'delete',TRUE), (@q,'free',FALSE), (@q,'remove',FALSE), (@q,'drop',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Référence ?', 'SINGLE_CHOICE', 'int& x = y;', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int& x',TRUE), (@q,'int* x',FALSE), (@q,'int x',FALSE), (@q,'ref x',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Surchage de fonction ?', 'SINGLE_CHOICE', 'Même nom, signatures différentes.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Même nom diff signature',TRUE), (@q,'Différent nom',FALSE), (@q,'Même signature',FALSE), (@q,'Impossible',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Bibliothèque vecteur dynamique ?', 'SINGLE_CHOICE', 'std::vector', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'std::vector',TRUE), (@q,'std::list',FALSE), (@q,'std::array',FALSE), (@q,'std::map',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Accéder membre via pointeur ?', 'SINGLE_CHOICE', '->', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'->',TRUE), (@q,'.',FALSE), (@q,'::',FALSE), (@q,':',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Mot-clé fonction amie ?', 'SINGLE_CHOICE', 'friend', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'friend',TRUE), (@q,'buddy',FALSE), (@q,'pal',FALSE), (@q,'classmate',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Portée de résolution ?', 'SINGLE_CHOICE', '::', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'::',TRUE), (@q,'->',FALSE), (@q,'.',FALSE), (@q,'..',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Surchage opérateur ?', 'SINGLE_CHOICE', 'operator+', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'operator+',TRUE), (@q,'function+',FALSE), (@q,'plus()',FALSE), (@q,'add()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'String C++ ?', 'SINGLE_CHOICE', 'std::string', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'std::string',TRUE), (@q,'char*',FALSE), (@q,'String',FALSE), (@q,'text',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_inter, 'Classe abstraite ?', 'SINGLE_CHOICE', 'Au moins une fonction virtuelle pure.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Fonction virtuelle pure',TRUE), (@q,'Mot-clé abstract',FALSE), (@q,'Pas de constructeur',FALSE), (@q,'Pas de données',FALSE);

-- Difficulty: ADVANCED
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Qu''est-ce que RAII ?', 'SINGLE_CHOICE', 'Resource Acquisition Is Initialization.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'RAII',TRUE), (@q,'SOLID',FALSE), (@q,'KISS',FALSE), (@q,'DRY',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Smart pointer propriété unique ?', 'SINGLE_CHOICE', 'unique_ptr', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'unique_ptr',TRUE), (@q,'shared_ptr',FALSE), (@q,'weak_ptr',FALSE), (@q,'auto_ptr',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Smart pointer partagé ?', 'SINGLE_CHOICE', 'shared_ptr', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'shared_ptr',TRUE), (@q,'unique_ptr',FALSE), (@q,'weak_ptr',FALSE), (@q,'auto_ptr',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Qu''est-ce que move semantics ?', 'SINGLE_CHOICE', 'Transférer ressources sans copie (std::move).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Move sans copie',TRUE), (@q,'Copie profonde',FALSE), (@q,'Référence const',FALSE), (@q,'Pointeur null',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Fonction virtuelle pure ?', 'SINGLE_CHOICE', 'virtual void f() = 0;', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'= 0;',TRUE), (@q,'= null;',FALSE), (@q,'= void;',FALSE), (@q,'abstract;',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Cast statique ?', 'SINGLE_CHOICE', 'static_cast<T>(v)', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'static_cast',TRUE), (@q,'dynamic_cast',FALSE), (@q,'reinterpret_cast',FALSE), (@q,'(T)v',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Cast dynamique (polymorphique) ?', 'SINGLE_CHOICE', 'dynamic_cast (RTTI)', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'dynamic_cast',TRUE), (@q,'static_cast',FALSE), (@q,'const_cast',FALSE), (@q,'polymorph_cast',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Qu''est-ce que auto ?', 'SINGLE_CHOICE', 'Inférence de type.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Inférence type',TRUE), (@q,'Automatique',FALSE), (@q,'Boucle',FALSE), (@q,'Variable globale',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Lambda expression ?', 'SINGLE_CHOICE', '[](){}', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'[](){}',TRUE), (@q,'lambda()',FALSE), (@q,'func()',FALSE), (@q,'()=>{}',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Différence struct vs class ?', 'SINGLE_CHOICE', 'Struct public par défaut, Class privé.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Public vs Privé',TRUE), (@q,'Valeur vs Ref',FALSE), (@q,'Fonctions vs Données',FALSE), (@q,'Aucune',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Qu''est-ce que std::map ?', 'SINGLE_CHOICE', 'Arbre binaire équilibré (clé-valeur).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Arbre binaire',TRUE), (@q,'Table hachage',FALSE), (@q,'Vecteur trié',FALSE), (@q,'Liste chaînée',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Qu''est-ce que std::unordered_map ?', 'SINGLE_CHOICE', 'Table de hachage.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Table hachage',TRUE), (@q,'Arbre binaire',FALSE), (@q,'Liste',FALSE), (@q,'Pile',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Mutable lambda ?', 'SINGLE_CHOICE', 'Permet modifier captures par valeur.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Modifier captures',TRUE), (@q,'Changer type',FALSE), (@q,'Devenir const',FALSE), (@q,'Aucune idée',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Diamond Problem solution ?', 'SINGLE_CHOICE', 'Héritage virtuel (virtual inheritance).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Héritage virtuel',TRUE), (@q,'Héritage multiple',FALSE), (@q,'Interface',FALSE), (@q,'Composition',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Qu''est-ce que Rvalue Reference ?', 'SINGLE_CHOICE', 'T&& (pour move semantics).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'T&&',TRUE), (@q,'T&',FALSE), (@q,'T*',FALSE), (@q,'const T&',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Parcourir conteneur (C++11) ?', 'SINGLE_CHOICE', 'Range-based for loop (for(auto x: v)).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Range-based for',TRUE), (@q,'Iterator',FALSE), (@q,'Index loop',FALSE), (@q,'While',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Qu''est-ce que constexpr ?', 'SINGLE_CHOICE', 'Évalué à la compilation.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Compilation',TRUE), (@q,'Exécution',FALSE), (@q,'Chargement',FALSE), (@q,'Runtime constant',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Thread standard ?', 'SINGLE_CHOICE', 'std::thread', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'std::thread',TRUE), (@q,'pthread',FALSE), (@q,'Thread',FALSE), (@q,'Task',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Verrouiller mutex auto ?', 'SINGLE_CHOICE', 'std::lock_guard ou unique_lock.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'lock_guard',TRUE), (@q,'mutex.lock()',FALSE), (@q,'semaphore',FALSE), (@q,'monitor',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_cpp_adv, 'Exception standard racine ?', 'SINGLE_CHOICE', 'std::exception', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'std::exception',TRUE), (@q,'std::error',FALSE), (@q,'Throwable',FALSE), (@q,'Error',FALSE);
