# 📚 GUIDE : Ajouter des Questions (Corrigé)

Si ChatGPT fait des erreurs, c'est souvent parce qu'il ne connaît pas la structure exacte de vos tables. Ce guide corrige cela.

---

## Étape 1 : Installer l'Outil (Obligatoire)

1.  Ouvrez votre logiciel de base de données (Workbench / PhpMyAdmin).
2.  Ouvrez et exécutez le fichier `SETUP_ADD_QUESTIONS.sql` (que je viens de créer).
    *   *Cela installe la commande `AddQ` qui permet d'insérer proprement sans se soucier des IDs.*

---

## Étape 2 : Le Prompt "Blindé" pour ChatGPT

Copiez ce texte EXACTEMENT et donnez-le à ChatGPT. Il contient la définition de vos tables pour qu'il ne se trompe plus.

**Prompt à Copier :**

```text
Je veux générer des questions SQL pour mon application "DevQuiz".
Tu dois utiliser UNIQUEMENT la procédure stockée `CALL AddQ(...)` pour insérer les données.
NE FAIS PAS de `INSERT INTO questions...` manuels.

Voici la structure de ma commande :
CALL AddQ('TITRE_DU_QUIZ', 'ÉNONCÉ', 'DIFFICULTE', 'BONNE_REPONSE', 'FAUSSE_1', 'FAUSSE_2', 'FAUSSE_3', 'EXPLICATION');

Voici ma base de données (pour contexte uniquement) :
- Table `quizzes` (colonne `title` contient par exemple 'Java - Débutant', 'Python - Avancé')
- Table `questions` (colonne `difficulty` est un ENUM: 'BEGINNER', 'INTERMEDIATE', 'ADVANCED')
- Table `answers`
- Table `courses`

RÈGLES IMPORTANTES :
1. Titres de Quiz Disponibles (Copie-colle exactement) :
   - 'Java - Débutant', 'Java - Intermédiaire', 'Java - Avancé'
   - 'Python - Débutant', 'Python - Intermédiaire', 'Python - Avancé'
   - 'Web - Débutant' (Note: HTML/CSS/JS sont regroupés ou séparés selon ton install, utilise les noms standards : 'HTML - Débutant', 'JavaScript - Débutant')
   - 'C++ - Débutant', 'SQL - Débutant', etc.
2. Difficulté : Utilise UNIQUEMENT 'BEGINNER', 'INTERMEDIATE', ou 'ADVANCED'.
3. Échappement : Si un texte contient une apostrophe (ex: l'objet), écris-le avec deux apostrophes (ex: l''objet).

TA MISSION :
Génère un script SQL contenant 10 appels à `CALL AddQ` pour ajouter des questions techniques sur le langage [CHOISIR LANGAGE ICI] niveau [CHOISIR NIVEAU].
```

---

## Étape 3 : Exécuter

1.  Collez le code fourni par ChatGPT dans votre base de données.
2.  Si une ligne échoue, la procédure `AddQ` vous dira "❌ ERREUR : Quiz introuvable", ce qui vous permet de corriger juste le titre.
