-- Sample Questions Data for E-Learning Platform
-- This file contains 50+ questions across multiple programming languages

USE elearning_db;

-- ============================================
-- HTML Questions (10 questions)
-- ============================================

INSERT INTO questions (quiz_id, question_text, type, difficulty, language_tag, points, explanation) VALUES
(1, 'What does HTML stand for?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'HTML stands for HyperText Markup Language, the standard markup language for creating web pages.'),
(1, 'Which HTML tag is used to define an internal style sheet?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'The <style> tag is used to define style information (CSS) for a document.'),
(1, 'Which HTML element is used to specify a footer for a document?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'html', 15, 'The <footer> element defines a footer for a document or section.'),
(1, 'What is the correct HTML for creating a hyperlink?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'The <a> tag with href attribute creates a hyperlink.'),
(1, 'Which HTML attribute specifies an alternate text for an image?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'The alt attribute provides alternative text for an image.'),
(1, 'What is the correct HTML for making a checkbox?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'Input type="checkbox" creates a checkbox.'),
(1, 'Which HTML element defines the title of a document?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'The <title> tag defines the document title shown in browser tab.'),
(1, 'What is the correct HTML for inserting an image?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'The <img> tag with src attribute inserts an image.'),
(1, 'Which HTML element is used to display a scalar measurement?', 'SINGLE_CHOICE', 'ADVANCED', 'html', 20, 'The <meter> element represents a scalar measurement within a known range.'),
(1, 'What is the correct HTML for making a text area?', 'SINGLE_CHOICE', 'BEGINNER', 'html', 10, 'The <textarea> tag creates a multi-line text input control.');

-- Answers for HTML questions
INSERT INTO answers (question_id, answer_text, is_correct) VALUES
-- Q1: What does HTML stand for?
(1, 'HyperText Markup Language', TRUE),
(1, 'HighText Machine Language', FALSE),
(1, 'HyperText and links Markup Language', FALSE),
(1, 'Home Tool Markup Language', FALSE),

-- Q2: Which HTML tag is used to define an internal style sheet?
(2, '<style>', TRUE),
(2, '<css>', FALSE),
(2, '<script>', FALSE),
(2, '<link>', FALSE),

-- Q3: Which HTML element is used to specify a footer?
(3, '<footer>', TRUE),
(3, '<bottom>', FALSE),
(3, '<section>', FALSE),
(3, '<div>', FALSE),

-- Q4: What is the correct HTML for creating a hyperlink?
(4, '<a href="url">text</a>', TRUE),
(4, '<link>url</link>', FALSE),
(4, '<hyperlink>url</hyperlink>', FALSE),
(4, '<url>text</url>', FALSE),

-- Q5: Which HTML attribute specifies alternate text for an image?
(5, 'alt', TRUE),
(5, 'title', FALSE),
(5, 'src', FALSE),
(5, 'text', FALSE),

-- Q6: What is the correct HTML for making a checkbox?
(6, '<input type="checkbox">', TRUE),
(6, '<checkbox>', FALSE),
(6, '<input type="check">', FALSE),
(6, '<check>', FALSE),

-- Q7: Which HTML element defines the title of a document?
(7, '<title>', TRUE),
(7, '<head>', FALSE),
(7, '<meta>', FALSE),
(7, '<header>', FALSE),

-- Q8: What is the correct HTML for inserting an image?
(8, '<img src="image.jpg" alt="description">', TRUE),
(8, '<image src="image.jpg">', FALSE),
(8, '<picture>image.jpg</picture>', FALSE),
(8, '<img>image.jpg</img>', FALSE),

-- Q9: Which HTML element is used to display a scalar measurement?
(9, '<meter>', TRUE),
(9, '<gauge>', FALSE),
(9, '<measure>', FALSE),
(9, '<progress>', FALSE),

-- Q10: What is the correct HTML for making a text area?
(10, '<textarea></textarea>', TRUE),
(10, '<input type="textarea">', FALSE),
(10, '<textbox></textbox>', FALSE),
(10, '<text></text>', FALSE);

-- ============================================
-- CSS Questions (10 questions)
-- ============================================

INSERT INTO questions (quiz_id, question_text, type, difficulty, language_tag, points, explanation) VALUES
(2, 'What does CSS stand for?', 'SINGLE_CHOICE', 'BEGINNER', 'css', 10, 'CSS stands for Cascading Style Sheets.'),
(2, 'Which property is used to change the background color?', 'SINGLE_CHOICE', 'BEGINNER', 'css', 10, 'The background-color property sets the background color of an element.'),
(2, 'How do you make text bold in CSS?', 'SINGLE_CHOICE', 'BEGINNER', 'css', 10, 'The font-weight: bold property makes text bold.'),
(2, 'Which CSS property controls the text size?', 'SINGLE_CHOICE', 'BEGINNER', 'css', 10, 'The font-size property sets the size of text.'),
(2, 'How do you select an element with id "demo"?', 'SINGLE_CHOICE', 'BEGINNER', 'css', 10, 'Use #demo to select an element by ID.'),
(2, 'How do you select elements with class "test"?', 'SINGLE_CHOICE', 'BEGINNER', 'css', 10, 'Use .test to select elements by class.'),
(2, 'Which property is used to change the font of an element?', 'SINGLE_CHOICE', 'BEGINNER', 'css', 10, 'The font-family property specifies the font.'),
(2, 'How do you make a list not display bullet points?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'css', 15, 'list-style-type: none removes bullet points.'),
(2, 'What is the default value of position property?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'css', 15, 'The default position value is static.'),
(2, 'Which CSS property is used for flexbox layout?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'css', 15, 'display: flex enables flexbox layout.');

-- Answers for CSS questions
INSERT INTO answers (question_id, answer_text, is_correct) VALUES
-- Q11: What does CSS stand for?
(11, 'Cascading Style Sheets', TRUE),
(11, 'Creative Style Sheets', FALSE),
(11, 'Computer Style Sheets', FALSE),
(11, 'Colorful Style Sheets', FALSE),

-- Q12: Which property is used to change the background color?
(12, 'background-color', TRUE),
(12, 'bgcolor', FALSE),
(12, 'color', FALSE),
(12, 'background', FALSE),

-- Q13: How do you make text bold in CSS?
(13, 'font-weight: bold', TRUE),
(13, 'text-style: bold', FALSE),
(13, 'font: bold', FALSE),
(13, 'text-weight: bold', FALSE),

-- Q14: Which CSS property controls the text size?
(14, 'font-size', TRUE),
(14, 'text-size', FALSE),
(14, 'font-style', FALSE),
(14, 'text-style', FALSE),

-- Q15: How do you select an element with id "demo"?
(15, '#demo', TRUE),
(15, '.demo', FALSE),
(15, 'demo', FALSE),
(15, '*demo', FALSE),

-- Q16: How do you select elements with class "test"?
(16, '.test', TRUE),
(16, '#test', FALSE),
(16, 'test', FALSE),
(16, '*test', FALSE),

-- Q17: Which property is used to change the font?
(17, 'font-family', TRUE),
(17, 'font', FALSE),
(17, 'font-type', FALSE),
(17, 'typeface', FALSE),

-- Q18: How do you make a list not display bullet points?
(18, 'list-style-type: none', TRUE),
(18, 'list-style: none', FALSE),
(18, 'list: none', FALSE),
(18, 'bullets: none', FALSE),

-- Q19: What is the default value of position property?
(19, 'static', TRUE),
(19, 'relative', FALSE),
(19, 'fixed', FALSE),
(19, 'absolute', FALSE),

-- Q20: Which CSS property is used for flexbox layout?
(20, 'display: flex', TRUE),
(20, 'layout: flex', FALSE),
(20, 'flex: display', FALSE),
(20, 'flexbox: true', FALSE);

-- ============================================
-- JavaScript Questions (10 questions)
-- ============================================

INSERT INTO questions (quiz_id, question_text, type, difficulty, language_tag, points, explanation) VALUES
(3, 'Inside which HTML element do we put JavaScript?', 'SINGLE_CHOICE', 'BEGINNER', 'javascript', 10, 'JavaScript code is placed inside <script> tags.'),
(3, 'How do you create a function in JavaScript?', 'SINGLE_CHOICE', 'BEGINNER', 'javascript', 10, 'Functions are created using the function keyword.'),
(3, 'How do you call a function named "myFunction"?', 'SINGLE_CHOICE', 'BEGINNER', 'javascript', 10, 'Functions are called using parentheses: myFunction().'),
(3, 'How do you write an IF statement in JavaScript?', 'SINGLE_CHOICE', 'BEGINNER', 'javascript', 10, 'IF statements use the if keyword with parentheses.'),
(3, 'How does a FOR loop start?', 'SINGLE_CHOICE', 'BEGINNER', 'javascript', 10, 'FOR loops start with for (initialization; condition; increment).'),
(3, 'How do you declare a JavaScript variable?', 'SINGLE_CHOICE', 'BEGINNER', 'javascript', 10, 'Variables are declared using let, const, or var.'),
(3, 'Which operator is used to assign a value to a variable?', 'SINGLE_CHOICE', 'BEGINNER', 'javascript', 10, 'The = operator assigns values.'),
(3, 'What is the correct way to write a JavaScript array?', 'SINGLE_CHOICE', 'BEGINNER', 'javascript', 10, 'Arrays are written with square brackets.'),
(3, 'How do you round the number 7.25 to the nearest integer?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'javascript', 15, 'Math.round() rounds to the nearest integer.'),
(3, 'What is the correct syntax for referring to an external script?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'javascript', 15, 'External scripts use <script src="filename.js">.');

-- Answers for JavaScript questions
INSERT INTO answers (question_id, answer_text, is_correct) VALUES
-- Q21: Inside which HTML element do we put JavaScript?
(21, '<script>', TRUE),
(21, '<javascript>', FALSE),
(21, '<js>', FALSE),
(21, '<scripting>', FALSE),

-- Q22: How do you create a function?
(22, 'function myFunction()', TRUE),
(22, 'function:myFunction()', FALSE),
(22, 'function = myFunction()', FALSE),
(22, 'create myFunction()', FALSE),

-- Q23: How do you call a function?
(23, 'myFunction()', TRUE),
(23, 'call myFunction()', FALSE),
(23, 'call function myFunction()', FALSE),
(23, 'execute myFunction()', FALSE),

-- Q24: How do you write an IF statement?
(24, 'if (i == 5)', TRUE),
(24, 'if i = 5 then', FALSE),
(24, 'if i == 5 then', FALSE),
(24, 'if (i = 5)', FALSE),

-- Q25: How does a FOR loop start?
(25, 'for (i = 0; i < 5; i++)', TRUE),
(25, 'for (i = 0; i < 5)', FALSE),
(25, 'for i = 1 to 5', FALSE),
(25, 'for (i <= 5; i++)', FALSE),

-- Q26: How do you declare a variable?
(26, 'let x = 5', TRUE),
(26, 'variable x = 5', FALSE),
(26, 'v x = 5', FALSE),
(26, 'dim x = 5', FALSE),

-- Q27: Which operator assigns a value?
(27, '=', TRUE),
(27, '==', FALSE),
(27, '===', FALSE),
(27, ':=', FALSE),

-- Q28: Correct way to write an array?
(28, 'let colors = ["red", "green", "blue"]', TRUE),
(28, 'let colors = (1:"red", 2:"green", 3:"blue")', FALSE),
(28, 'let colors = "red", "green", "blue"', FALSE),
(28, 'let colors = 1 = ("red"), 2 = ("green")', FALSE),

-- Q29: How do you round 7.25?
(29, 'Math.round(7.25)', TRUE),
(29, 'round(7.25)', FALSE),
(29, 'Math.rnd(7.25)', FALSE),
(29, 'rnd(7.25)', FALSE),

-- Q30: External script syntax?
(30, '<script src="xxx.js">', TRUE),
(30, '<script href="xxx.js">', FALSE),
(30, '<script name="xxx.js">', FALSE),
(30, '<script file="xxx.js">', FALSE);

-- ============================================
-- Java Questions (10 questions)
-- ============================================

INSERT INTO questions (quiz_id, question_text, type, difficulty, language_tag, points, explanation) VALUES
(4, 'What is the extension of Java code files?', 'SINGLE_CHOICE', 'BEGINNER', 'java', 10, 'Java source files have .java extension.'),
(4, 'Which method is the entry point of a Java program?', 'SINGLE_CHOICE', 'BEGINNER', 'java', 10, 'The main method is the entry point: public static void main(String[] args).'),
(4, 'Which keyword is used to create a class in Java?', 'SINGLE_CHOICE', 'BEGINNER', 'java', 10, 'The class keyword is used to define a class.'),
(4, 'What is the size of int in Java?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'java', 15, 'int is 32 bits (4 bytes) in Java.'),
(4, 'Which package contains the Scanner class?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'java', 15, 'Scanner is in java.util package.'),
(4, 'What is the default value of a boolean variable?', 'SINGLE_CHOICE', 'BEGINNER', 'java', 10, 'Boolean variables default to false.'),
(4, 'Which keyword is used for inheritance in Java?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'java', 15, 'The extends keyword is used for inheritance.'),
(4, 'What is the correct way to create an object?', 'SINGLE_CHOICE', 'BEGINNER', 'java', 10, 'Objects are created using the new keyword.'),
(4, 'Which method is used to compare two strings?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'java', 15, 'The equals() method compares string content.'),
(4, 'What is the parent class of all classes in Java?', 'SINGLE_CHOICE', 'ADVANCED', 'java', 20, 'Object is the parent class of all Java classes.');

-- Answers for Java questions
INSERT INTO answers (question_id, answer_text, is_correct) VALUES
-- Q31: Extension of Java files?
(31, '.java', TRUE),
(31, '.class', FALSE),
(31, '.txt', FALSE),
(31, '.j', FALSE),

-- Q32: Entry point method?
(32, 'public static void main(String[] args)', TRUE),
(32, 'public void main(String[] args)', FALSE),
(32, 'static void main(String[] args)', FALSE),
(32, 'public static main(String[] args)', FALSE),

-- Q33: Keyword to create a class?
(33, 'class', TRUE),
(33, 'Class', FALSE),
(33, 'public', FALSE),
(33, 'struct', FALSE),

-- Q34: Size of int?
(34, '32 bits', TRUE),
(34, '16 bits', FALSE),
(34, '64 bits', FALSE),
(34, '8 bits', FALSE),

-- Q35: Package containing Scanner?
(35, 'java.util', TRUE),
(35, 'java.io', FALSE),
(35, 'java.lang', FALSE),
(35, 'java.scanner', FALSE),

-- Q36: Default value of boolean?
(36, 'false', TRUE),
(36, 'true', FALSE),
(36, '0', FALSE),
(36, 'null', FALSE),

-- Q37: Keyword for inheritance?
(37, 'extends', TRUE),
(37, 'implements', FALSE),
(37, 'inherits', FALSE),
(37, 'inherit', FALSE),

-- Q38: Correct way to create an object?
(38, 'MyClass obj = new MyClass()', TRUE),
(38, 'MyClass obj = MyClass()', FALSE),
(38, 'new MyClass obj = MyClass()', FALSE),
(38, 'MyClass obj', FALSE),

-- Q39: Method to compare strings?
(39, 'equals()', TRUE),
(39, '==', FALSE),
(39, 'compare()', FALSE),
(39, 'compareTo()', FALSE),

-- Q40: Parent class of all classes?
(40, 'Object', TRUE),
(40, 'Class', FALSE),
(40, 'Super', FALSE),
(40, 'Parent', FALSE);

-- ============================================
-- Python Questions (10 questions)
-- ============================================

INSERT INTO questions (quiz_id, question_text, type, difficulty, language_tag, points, explanation) VALUES
(5, 'What is the correct file extension for Python files?', 'SINGLE_CHOICE', 'BEGINNER', 'python', 10, 'Python files use .py extension.'),
(5, 'How do you create a variable in Python?', 'SINGLE_CHOICE', 'BEGINNER', 'python', 10, 'Variables are created by assignment: x = 5.'),
(5, 'Which keyword is used to create a function?', 'SINGLE_CHOICE', 'BEGINNER', 'python', 10, 'The def keyword defines a function.'),
(5, 'How do you insert comments in Python?', 'SINGLE_CHOICE', 'BEGINNER', 'python', 10, 'Comments start with # symbol.'),
(5, 'Which method is used to add an element to a list?', 'SINGLE_CHOICE', 'BEGINNER', 'python', 10, 'The append() method adds elements to a list.'),
(5, 'What is the correct syntax for a for loop?', 'SINGLE_CHOICE', 'BEGINNER', 'python', 10, 'For loops use: for x in range(5).'),
(5, 'How do you create a dictionary?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'python', 15, 'Dictionaries use curly braces: {"key": "value"}.'),
(5, 'Which function is used to get user input?', 'SINGLE_CHOICE', 'BEGINNER', 'python', 10, 'The input() function gets user input.'),
(5, 'What is the output of: print(type([]))?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'python', 15, 'Empty brackets [] create a list type.'),
(5, 'Which keyword is used for exception handling?', 'SINGLE_CHOICE', 'INTERMEDIATE', 'python', 15, 'The try keyword starts exception handling.');

-- Answers for Python questions
INSERT INTO answers (question_id, answer_text, is_correct) VALUES
-- Q41: File extension?
(41, '.py', TRUE),
(41, '.python', FALSE),
(41, '.pt', FALSE),
(41, '.pyt', FALSE),

-- Q42: Create a variable?
(42, 'x = 5', TRUE),
(42, 'int x = 5', FALSE),
(42, 'var x = 5', FALSE),
(42, 'let x = 5', FALSE),

-- Q43: Keyword for function?
(43, 'def', TRUE),
(43, 'function', FALSE),
(43, 'func', FALSE),
(43, 'define', FALSE),

-- Q44: Insert comments?
(44, '# This is a comment', TRUE),
(44, '// This is a comment', FALSE),
(44, '/* This is a comment */', FALSE),
(44, '<!-- This is a comment -->', FALSE),

-- Q45: Add element to list?
(45, 'append()', TRUE),
(45, 'add()', FALSE),
(45, 'insert()', FALSE),
(45, 'push()', FALSE),

-- Q46: For loop syntax?
(46, 'for x in range(5):', TRUE),
(46, 'for (x = 0; x < 5; x++)', FALSE),
(46, 'for x = 1 to 5', FALSE),
(46, 'foreach x in range(5)', FALSE),

-- Q47: Create a dictionary?
(47, '{"name": "John", "age": 30}', TRUE),
(47, '["name": "John", "age": 30]', FALSE),
(47, '("name": "John", "age": 30)', FALSE),
(47, 'dict("name": "John")', FALSE),

-- Q48: Get user input?
(48, 'input()', TRUE),
(48, 'get()', FALSE),
(48, 'read()', FALSE),
(48, 'scan()', FALSE),

-- Q49: Output of type([])?
(49, '<class ''list''>', TRUE),
(49, '<class ''array''>', FALSE),
(49, '<class ''dict''>', FALSE),
(49, '<class ''tuple''>', FALSE),

-- Q50: Exception handling keyword?
(50, 'try', TRUE),
(50, 'catch', FALSE),
(50, 'except', FALSE),
(50, 'handle', FALSE);

-- ============================================
-- Update question IDs to match quiz structure
-- ============================================

-- Note: Adjust quiz_id values based on your actual quiz IDs in the database
-- The above assumes quiz IDs 1-5 for HTML, CSS, JavaScript, Java, Python

COMMIT;

SELECT 'Sample data inserted successfully!' as Status;
SELECT COUNT(*) as TotalQuestions FROM questions;
SELECT COUNT(*) as TotalAnswers FROM answers;
