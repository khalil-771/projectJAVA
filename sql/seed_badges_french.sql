-- Seed Badges
INSERT IGNORE INTO badges (name, description, icon_path, badge_type, points_reward, rule_condition) VALUES
('Premier Quiz', 'Complétez votre premier quiz avec succès.', '/badges/first_quiz.png', 'SPECIAL', 50, 'FIRST_QUIZ'),
('Sans Faute', 'Obtenez 100% à un quiz.', '/badges/perfect_score.png', 'SCORE', 100, 'PERFECT_SCORE'),
('Maître Python', 'Complétez tous les niveaux de Python.', '/badges/python_master.png', 'COURSE_COMPLETION', 200, 'COURSE_PYTHON'),
('Maître Java', 'Complétez tous les niveaux de Java.', '/badges/java_master.png', 'COURSE_COMPLETION', 200, 'COURSE_JAVA'),
('Série de 3', 'Utilisez l''application 3 jours de suite.', '/badges/streak_3.png', 'STREAK', 150, 'STREAK_3');
