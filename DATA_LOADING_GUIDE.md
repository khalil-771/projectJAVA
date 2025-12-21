# 🎯 Quick Data Loading Guide

## Sample Data Included

Your platform now comes with **50 pre-loaded questions** across 5 programming languages!

### 📚 What's Included:

**HTML (10 questions)**
- Beginner: 7 questions
- Intermediate: 2 questions  
- Advanced: 1 question

**CSS (10 questions)**
- Beginner: 7 questions
- Intermediate: 3 questions

**JavaScript (10 questions)**
- Beginner: 8 questions
- Intermediate: 2 questions

**Java (10 questions)**
- Beginner: 5 questions
- Intermediate: 4 questions
- Advanced: 1 question

**Python (10 questions)**
- Beginner: 7 questions
- Intermediate: 3 questions

---

## 🚀 How to Load Data

### Option 1: Automatic (Recommended)

The data loads automatically when you run the application for the first time!

```bash
# Just run the app
mvn javafx:run
```

The `DatabaseSetup.java` will:
1. ✅ Create database
2. ✅ Create tables
3. ✅ Load gamification data (15 badges)
4. ✅ **Load 50 sample questions** ⭐ NEW!
5. ✅ Create admin user

### Option 2: Manual Loading

If you want to load data manually:

```sql
-- In MySQL Workbench or command line
USE elearning_db;
SOURCE c:/Users/hp/Desktop/newProjectJAVA/database_sample_data.sql;
```

---

## 📊 Data Structure

Each question includes:
- ✅ Question text
- ✅ Difficulty level (BEGINNER/INTERMEDIATE/ADVANCED)
- ✅ Language tag (html, css, javascript, java, python)
- ✅ Points (10-20 based on difficulty)
- ✅ Explanation (why the answer is correct)
- ✅ 4 answer choices (1 correct, 3 wrong)

---

## 🎮 Test It Out!

1. **Login**: `admin` / `admin123`
2. **Navigate** to any course
3. **Take a quiz** - you'll see real questions!
4. **Earn points** - 10-20 XP per question
5. **Unlock badges** - "First Steps", "Perfect Score", etc.

---

## 📝 Sample Questions Preview

**HTML Example:**
```
Q: What does HTML stand for?
A) HyperText Markup Language ✓
B) HighText Machine Language
C) HyperText and links Markup Language
D) Home Tool Markup Language

Explanation: HTML stands for HyperText Markup Language, 
the standard markup language for creating web pages.
```

**Java Example:**
```
Q: Which method is the entry point of a Java program?
A) public static void main(String[] args) ✓
B) public void main(String[] args)
C) static void main(String[] args)
D) public static main(String[] args)

Explanation: The main method is the entry point: 
public static void main(String[] args).
```

---

## 🔧 Customization

Want to add more questions? Edit `database_sample_data.sql`:

```sql
INSERT INTO questions (quiz_id, question_text, type, difficulty, language_tag, points, explanation) VALUES
(1, 'Your question here?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'Your explanation');

INSERT INTO answers (question_id, answer_text, is_correct) VALUES
(51, 'Correct answer', TRUE),
(51, 'Wrong answer 1', FALSE),
(51, 'Wrong answer 2', FALSE),
(51, 'Wrong answer 3', FALSE);
```

---

## ✅ Verification

Check if data loaded successfully:

```sql
-- Count questions
SELECT COUNT(*) as TotalQuestions FROM questions;
-- Should return: 50

-- Count answers
SELECT COUNT(*) as TotalAnswers FROM answers;
-- Should return: 200 (50 questions × 4 answers)

-- Questions by language
SELECT language_tag, COUNT(*) as count 
FROM questions 
GROUP BY language_tag;
```

---

## 🎉 You're Ready!

Your platform now has:
- ✅ 50 questions
- ✅ 200 answers
- ✅ 15 badges
- ✅ 5 languages
- ✅ 3 difficulty levels

**Start learning and earning XP!** 🚀
