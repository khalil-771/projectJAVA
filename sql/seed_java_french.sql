-- Java Questions (60 total)
SET @quiz_java_beginner = (SELECT id FROM quizzes WHERE title='Java: Quiz Débutant');
SET @quiz_java_inter = (SELECT id FROM quizzes WHERE title='Java: Quiz Intermédiaire');
SET @quiz_java_adv = (SELECT id FROM quizzes WHERE title='Java: Quiz Avancé');

-- Difficulty: BEGINNER (20 Questions)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel mot-clé définit une classe ?', 'SINGLE_CHOICE', 'class définit une classe.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'class',TRUE), (@q,'struct',FALSE), (@q,'def',FALSE), (@q,'instance',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel est le point d''entrée d''un programme Java ?', 'SINGLE_CHOICE', 'main() est le point d''entrée.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'main()',TRUE), (@q,'start()',FALSE), (@q,'init()',FALSE), (@q,'run()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel type stocke des entiers ?', 'SINGLE_CHOICE', 'int stocke des entiers.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int',TRUE), (@q,'Integer',FALSE), (@q,'num',FALSE), (@q,'String',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel type stocke "Vrai" ou "Faux" ?', 'SINGLE_CHOICE', 'boolean stocke true/false.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'boolean',TRUE), (@q,'bool',FALSE), (@q,'bit',FALSE), (@q,'binary',FALSE);

-- Note: inserting simplified for brevity in this batch, using loop or bulk insert is better but exact strings needed per user.
-- Proceeding with full individual inserts for quality.

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Comment déclarer une variable x égale à 5 ?', 'SINGLE_CHOICE', 'int x = 5;', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'int x = 5;',TRUE), (@q,'x = 5;',FALSE), (@q,'float x = 5;',FALSE), (@q,'num x = 5;',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quelle est l''extension d''un fichier source Java ?', 'SINGLE_CHOICE', '.java est l''extension source.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.java',TRUE), (@q,'.class',FALSE), (@q,'.js',FALSE), (@q,'.txt',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel opérateur est utilisé pour l''addition ?', 'SINGLE_CHOICE', '+ additionne.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'+',TRUE), (@q,'-',FALSE), (@q,'*',FALSE), (@q,'/',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Comment afficher un message dans la console ?', 'SINGLE_CHOICE', 'System.out.println() affiche.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'System.out.println()',TRUE), (@q,'console.log()',FALSE), (@q,'print()',FALSE), (@q,'echo()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel symbole termine une instruction ?', 'SINGLE_CHOICE', '; termine l''instruction.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,';',TRUE), (@q,':',FALSE), (@q,'.',FALSE), (@q,',',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel mot-clé crée une instance d''objet ?', 'SINGLE_CHOICE', 'new crée l''objet.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'new',TRUE), (@q,'create',FALSE), (@q,'make',FALSE), (@q,'init',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Comment faire une boucle avec un nombre d''itérations connu ?', 'SINGLE_CHOICE', 'for est pour les itérations connues.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'for',TRUE), (@q,'while',FALSE), (@q,'do-while',FALSE), (@q,'repeat',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel type pour des nombres à virgule ?', 'SINGLE_CHOICE', 'double ou float.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'double',TRUE), (@q,'int',FALSE), (@q,'boolean',FALSE), (@q,'String',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Java est-il orienté objet ?', 'SINGLE_CHOICE', 'Oui, Java est OOP.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Oui',TRUE), (@q,'Non',FALSE), (@q,'Partiellement',FALSE), (@q,'Uniquement fonctionnel',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel mot-clé signifie "ne change pas" ?', 'SINGLE_CHOICE', 'final.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'final',TRUE), (@q,'static',FALSE), (@q,'const',FALSE), (@q,'var',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Les indices de tableau commencent à ?', 'SINGLE_CHOICE', '0.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'0',TRUE), (@q,'1',FALSE), (@q,'-1',FALSE), (@q,'n',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quelle classe manipule les chaînes de caractères ?', 'SINGLE_CHOICE', 'String.', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'String',TRUE), (@q,'Text',FALSE), (@q,'CharChain',FALSE), (@q,'Word',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel opérateur signifie "ET logique" ?', 'SINGLE_CHOICE', '&&', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'&&',TRUE), (@q,'||',FALSE), (@q,'&',FALSE), (@q,'and',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel opérateur signifie "OU logique" ?', 'SINGLE_CHOICE', '||', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'||',TRUE), (@q,'&&',FALSE), (@q,'or',FALSE), (@q,'|',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Comment commenter plusieurs lignes ?', 'SINGLE_CHOICE', '/* ... */', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'/* ... */',TRUE), (@q,'//',FALSE), (@q,'#',FALSE), (@q,'<!-- -->',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'Quel mot-clé retourne une valeur ?', 'SINGLE_CHOICE', 'return', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'return',TRUE), (@q,'give',FALSE), (@q,'send',FALSE), (@q,'back',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_beginner, 'System.out est un objet de quel type ?', 'SINGLE_CHOICE', 'PrintStream', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'PrintStream',TRUE), (@q,'InputStream',FALSE), (@q,'String',FALSE), (@q,'File',FALSE);

-- Difficulty: INTERMEDIATE (20 Questions for Java)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle collection garde l''ordre d''insertion ?', 'SINGLE_CHOICE', 'ArrayList ou LinkedList (List).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ArrayList',TRUE), (@q,'HashSet',FALSE), (@q,'HashMap',FALSE), (@q,'TreeSet',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quel mot-clé appelle le constructeur parent ?', 'SINGLE_CHOICE', 'super()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'super()',TRUE), (@q,'this()',FALSE), (@q,'parent()',FALSE), (@q,'base()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Une interface peut-elle avoir des méthodes ?', 'SINGLE_CHOICE', 'Oui, default methods depuis Java 8.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Oui (default)',TRUE), (@q,'Non, jamais',FALSE), (@q,'Seulement statiques',FALSE), (@q,'Uniquement privées',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle exception est levée pour une division par zéro (entiers) ?', 'SINGLE_CHOICE', 'ArithmeticException', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ArithmeticException',TRUE), (@q,'NullPointerException',FALSE), (@q,'NumberFormatException',FALSE), (@q,'IOException',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'StringBuilder est-il thread-safe ?', 'SINGLE_CHOICE', 'Non, utiliser StringBuffer pour ça.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Non',TRUE), (@q,'Oui',FALSE), (@q,'Parfois',FALSE), (@q,'S''il est final',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Le mot-clé "protected" donne accès à qui ?', 'SINGLE_CHOICE', 'Package et sous-classes.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Package/Sous-classes',TRUE), (@q,'Tout le monde',FALSE), (@q,'Classe seule',FALSE), (@q,'Package seul',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Comment convertir String en int ?', 'SINGLE_CHOICE', 'Integer.parseInt()', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Integer.parseInt()',TRUE), (@q,'(int)string',FALSE), (@q,'String.toInt()',FALSE), (@q,'Int.parse()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle map n''accepte pas de clé null ?', 'SINGLE_CHOICE', 'Hashtable (et TreeMap selon cas).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Hashtable',TRUE), (@q,'HashMap',FALSE), (@q,'LinkedHashMap',FALSE), (@q,'WeakHashMap',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'D''où héritent toutes les classes ?', 'SINGLE_CHOICE', 'Object.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Object',TRUE), (@q,'Class',FALSE), (@q,'System',FALSE), (@q,'Root',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quel design pattern garantit une seule instance ?', 'SINGLE_CHOICE', 'Singleton.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Singleton',TRUE), (@q,'Factory',FALSE), (@q,'Observer',FALSE), (@q,'Builder',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quel mot-clé pour gérer les exceptions ?', 'SINGLE_CHOICE', 'try/catch/finally.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'try',TRUE), (@q,'attempt',FALSE), (@q,'error',FALSE), (@q,'test',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle méthode est appelée par le Garbage Collector ?', 'SINGLE_CHOICE', 'finalize() (déprécié mais historique).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'finalize()',TRUE), (@q,'delete()',FALSE), (@q,'clean()',FALSE), (@q,'remove()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Qu''est-ce que l''autoboxing ?', 'SINGLE_CHOICE', 'Conversion auto primitif <-> Wrapper.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Primitif <-> Wrapper',TRUE), (@q,'Mise en boîte auto',FALSE), (@q,'Compilation auto',FALSE), (@q,'Héritage auto',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Le mot-clé "transient" sert à quoi ?', 'SINGLE_CHOICE', 'Ignorer lors de la sérialisation.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Ignorer sérialisation',TRUE), (@q,'Variable temporaire',FALSE), (@q,'Variable thread',FALSE), (@q,'Variable globale',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quelle interface pour une tâche sur un thread ?', 'SINGLE_CHOICE', 'Runnable.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Runnable',TRUE), (@q,'Threadable',FALSE), (@q,'Executable',FALSE), (@q,'Task',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Comment synchroniser un bloc de code ?', 'SINGLE_CHOICE', 'synchronized(obj) { }', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'synchronized',TRUE), (@q,'locked',FALSE), (@q,'atomic',FALSE), (@q,'safe',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quel est le scope par défaut (package-private) ?', 'SINGLE_CHOICE', 'Aucun mot-clé.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'(défaut)',TRUE), (@q,'public',FALSE), (@q,'private',FALSE), (@q,'internal',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Peut-on instancier une interface ?', 'SINGLE_CHOICE', 'Non, jamais directement.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Non',TRUE), (@q,'Oui',FALSE), (@q,'Si statique',FALSE), (@q,'En Java 20',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Quel est l''avantage d''un HashSet ?', 'SINGLE_CHOICE', 'Recherche rapide, pas de doublons.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Recherche rapide',TRUE), (@q,'Garde l''ordre',FALSE), (@q,'Thread-safe',FALSE), (@q,'Clés/Valeurs',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_inter, 'Queue suit quel principe ?', 'SINGLE_CHOICE', 'FIFO (First In First Out).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'FIFO',TRUE), (@q,'LIFO',FALSE), (@q,'FILO',FALSE), (@q,'Random',FALSE);

-- Difficulty: ADVANCED (20 Questions for Java)
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Quel Garbage Collector est par défaut en Java 9+ ?', 'SINGLE_CHOICE', 'G1 GC.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'G1 GC',TRUE), (@q,'Parallel GC',FALSE), (@q,'CMS',FALSE), (@q,'Serial',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'À quoi sert Class.forName() ?', 'SINGLE_CHOICE', 'Charger une classe dynamiquement.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Charger dynamiquement',TRUE), (@q,'Créer une instance',FALSE), (@q,'Lister méthodes',FALSE), (@q,'Compiler',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Qu''est-ce que "type erasure" ?', 'SINGLE_CHOICE', 'Suppression des types génériques à la compilation.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Effacement types génériques',TRUE), (@q,'Suppression variables',FALSE), (@q,'Nettoyage mémoire',FALSE), (@q,'Effacement classes',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Quelle classe permet des variables atomiques ?', 'SINGLE_CHOICE', 'AtomicInteger, AtomicReference...', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'AtomicInteger',TRUE), (@q,'VolatileInt',FALSE), (@q,'SyncInt',FALSE), (@q,'LockedInt',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'CompletableFuture sert à quoi ?', 'SINGLE_CHOICE', 'Programmation asynchrone fonctionnelle.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Async fonctionnel',TRUE), (@q,'Future simple',FALSE), (@q,'Thread pool',FALSE), (@q,'Collection',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Quelle annotation marque une interface fonctionnelle ?', 'SINGLE_CHOICE', '@FunctionalInterface.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'@FunctionalInterface',TRUE), (@q,'@Interface',FALSE), (@q,'@Lambda',FALSE), (@q,'@Function',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Quelle méthode est utilisée par try-with-resources ?', 'SINGLE_CHOICE', 'close() de AutoCloseable.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'close()',TRUE), (@q,'end()',FALSE), (@q,'shutdown()',FALSE), (@q,'dispose()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Qu''est-ce que JNI ?', 'SINGLE_CHOICE', 'Java Native Interface (appels C/C++).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Java Native Interface',TRUE), (@q,'Java Net Interface',FALSE), (@q,'Java New Instance',FALSE), (@q,'Just Native It',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Comment rendre une classe immuable ?', 'SINGLE_CHOICE', 'Classe finale, champs privés finaux, pas de setters.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Finale, champs finaux, pas de setters',TRUE), (@q,'Juste mot-clé final',FALSE), (@q,'Tout statique',FALSE), (@q,'Pas de constructeur',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Qu''est-ce que "Happens-Before" ?', 'SINGLE_CHOICE', 'Règle de visibilité mémoire entre threads.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Règle mémoire threads',TRUE), (@q,'Ordre d''événements UI',FALSE), (@q,'Priorité threads',FALSE), (@q,'Règle compilation',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Quel pool de threads est pour les tâches courtes et nombreuses ?', 'SINGLE_CHOICE', 'CachedThreadPool.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'CachedThreadPool',TRUE), (@q,'FixedThreadPool',FALSE), (@q,'SingleThreadExecutor',FALSE), (@q,'ScheduledThreadPool',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'En Spring, quel scope par défaut pour un Bean ?', 'SINGLE_CHOICE', 'Singleton.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Singleton',TRUE), (@q,'Prototype',FALSE), (@q,'Request',FALSE), (@q,'Session',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Qu''est-ce qu''un ClassLoader ?', 'SINGLE_CHOICE', 'Charge les classes en mémoire (Bootstrap, System...).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Charge classes',TRUE), (@q,'Compile classes',FALSE), (@q,'Exécute classes',FALSE), (@q,'Supprime classes',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Reflection permet quoi ?', 'SINGLE_CHOICE', 'Inspecter/modifier classes, méthodes, champs au runtime.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Introspection',TRUE), (@q,'Optimisation',FALSE), (@q,'Sécurité',FALSE), (@q,'Compression',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Quel mot-clé est utilisé pour monitorer un objet ?', 'SINGLE_CHOICE', 'synchronized.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'synchronized',TRUE), (@q,'monitor',FALSE), (@q,'lock',FALSE), (@q,'await',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Qu''est-ce que SoftReference ?', 'SINGLE_CHOICE', 'Référence effacée par GC seulement si mémoire nécessaire.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Effacée si besoin mémoire',TRUE), (@q,'Toujours effacée',FALSE), (@q,'Jamais effacée',FALSE), (@q,'Effacée immédiatement',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'La méthode clone() effectue quoi par défaut ?', 'SINGLE_CHOICE', 'Shallow copy (copie de surface).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Shallow copy',TRUE), (@q,'Deep copy',FALSE), (@q,'Reference copy',FALSE), (@q,'New instance',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Qu''est-ce que l''invoke dynamic (invokedynamic) ?', 'SINGLE_CHOICE', 'Instruction bytecode pour typage dynamique (lambdas).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Instruction pour lambdas',TRUE), (@q,'Appel récursif',FALSE), (@q,'Appel statique',FALSE), (@q,'Appel via JNI',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'String.intern() fait quoi ?', 'SINGLE_CHOICE', 'Met la chaîne dans le String Pool.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Met dans String Pool',TRUE), (@q,'Supprime du pool',FALSE), (@q,'Crée une copie',FALSE), (@q,'Compare strings',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_java_adv, 'Qu''est-ce qu''un daemon thread ?', 'SINGLE_CHOICE', 'Thread qui ne bloque pas la fin de la JVM.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Ne bloque pas arrêt JVM',TRUE), (@q,'Thread prioritaire',FALSE), (@q,'Thread système',FALSE), (@q,'Thread principal',FALSE);
