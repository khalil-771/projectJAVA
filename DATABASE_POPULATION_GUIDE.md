# Guide de Population de la Base de Données

Ce guide vous explique comment générer un script SQL complet pour remplir votre base de données avec du contenu de qualité en français, en utilisant ChatGPT.

## Étape 1 : Préparer ChatGPT

Copiez et collez le prompt suivant dans ChatGPT. Ce prompt contient vos règles strictes pour générer les données.

**Prompt à copier :**

```text
Je développe une application de Quiz pour développeurs (DevQuiz).
J'ai besoin d'un script SQL MySQL complet pour :
1. Vider les tables existantes (TRUNCATE ou DELETE complet) pour repartir à zéro.
2. Insérer des données de test réalistes et de haute qualité EN FRANÇAIS.

Voici mon schéma de base de données (Note : La table 'courses' sert uniquement à stocker les LANGAGES) :

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ROLE_STUDENT', 'ROLE_ADMIN') DEFAULT 'ROLE_STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL, -- Nom du Langage (ex: Java, Python)
    description TEXT,
    language_tag VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    is_final_exam BOOLEAN DEFAULT FALSE,
    passing_score INT DEFAULT 70,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    question_type ENUM('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TRUE_FALSE') NOT NULL, -- Utiliser UNIQUEMENT 'SINGLE_CHOICE' pour ce script
    explanation TEXT,
    difficulty ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') DEFAULT 'BEGINNER',
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

*** INSTRUCTIONS STRICTES DE GÉNÉRATION ***

1. **Nettoyage** : Commence par désactiver les contraintes de clés étrangères, TRUNCATE toutes les tables (users, courses, quizzes, questions, answers, etc.), puis réactive les contraintes.
2. **Admin** : Crée un utilisateur admin (login: 'admin', email: 'admin@devquiz.com', hash pour 'admin123').
3. **Langages (Table 'courses')** : Insère UNIQUEMENT les langages suivants dans la table `courses` :
   - Java
   - Python
   - C++
   - C
   - HTML
   - CSS
   - JavaScript
   - SQL
   - Kotlin
   - PHP
   - C#
   - Ruby
   - Swift

4. **Structure des Quiz** :
   - Pour CHAQUE langage, crée 3 Quiz distincts : "Débutant", "Intermédiaire", "Avancé".
   - Chaque Quiz doit avoir EXACTEMENT **20 Questions**.
   - Ce qui fait un total de 13 langages * 3 niveaux * 20 questions = 780 questions au total. (Tu peux générer une partie si la limite de token est atteinte, mais structure le script pour qu'il soit facile à compléter).

5. **Format des Questions/Réponses** :
   - Toutes les questions doivent être de type `SINGLE_CHOICE`.
   - Chaque question doit avoir EXACTEMENT **4 Réponses** possibles.
   - 1 seule réponse correcte (`is_correct = TRUE`), 3 fausses.
   - Les questions doivent être techniques, pertinentes et EN FRANÇAIS.
   - Ajoute une explication courte mais utile dans le champ `explanation`.

6. **Variables SQL** :
   - Utilise massivement les variables SQL pour gérer les IDs (`SET @course_java = LAST_INSERT_ID();`, `SET @quiz_java_beg = LAST_INSERT_ID();`, etc.) afin que le script soit exécutable sans erreurs d'ID.

Génère-moi le scrip SQL.
```

## Étape 2 : Exécuter le Script

1. Copiez le prompt ci-dessus et envoyez-le à ChatGPT.
2. Copiez le code SQL généré.
3. Exécutez-le dans votre base de données `quiztests` via Workbench ou phpMyAdmin.
