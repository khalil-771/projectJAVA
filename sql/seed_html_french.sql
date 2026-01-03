-- HTML Questions (60 total)
SET @quiz_html_beginner = (SELECT id FROM quizzes WHERE title='HTML: Quiz Débutant');
SET @quiz_html_inter = (SELECT id FROM quizzes WHERE title='HTML: Quiz Intermédiaire');
SET @quiz_html_adv = (SELECT id FROM quizzes WHERE title='HTML: Quiz Avancé');

-- Difficulty: BEGINNER
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Que signifie HTML ?', 'SINGLE_CHOICE', 'HyperText Markup Language', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'HyperText Markup Language',TRUE), (@q,'HyperText Make Language',FALSE), (@q,'Home Tool Markup Language',FALSE), (@q,'HyperLink Markup Language',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour le plus grand titre ?', 'SINGLE_CHOICE', '<h1>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<h1>',TRUE), (@q,'<h6>',FALSE), (@q,'<head>',FALSE), (@q,'<title>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour un paragraphe ?', 'SINGLE_CHOICE', '<p>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<p>',TRUE), (@q,'<para>',FALSE), (@q,'<text>',FALSE), (@q,'<br>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour un lien ?', 'SINGLE_CHOICE', '<a>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<a>',TRUE), (@q,'<link>',FALSE), (@q,'<href>',FALSE), (@q,'<url>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour une image ?', 'SINGLE_CHOICE', '<img>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<img>',TRUE), (@q,'<image>',FALSE), (@q,'<pic>',FALSE), (@q,'<src>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Attribut pour l''URL d''un lien ?', 'SINGLE_CHOICE', 'href', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'href',TRUE), (@q,'src',FALSE), (@q,'link',FALSE), (@q,'url',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Attribut pour la source d''une image ?', 'SINGLE_CHOICE', 'src', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'src',TRUE), (@q,'href',FALSE), (@q,'source',FALSE), (@q,'path',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour sauter une ligne ?', 'SINGLE_CHOICE', '<br>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<br>',TRUE), (@q,'<lb>',FALSE), (@q,'<break>',FALSE), (@q,'<newline>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour le corps de la page ?', 'SINGLE_CHOICE', '<body>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<body>',TRUE), (@q,'<main>',FALSE), (@q,'<content>',FALSE), (@q,'<page>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour liste à puces ?', 'SINGLE_CHOICE', '<ul>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<ul>',TRUE), (@q,'<ol>',FALSE), (@q,'<li>',FALSE), (@q,'<dl>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour liste numérotée ?', 'SINGLE_CHOICE', '<ol>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<ol>',TRUE), (@q,'<ul>',FALSE), (@q,'<li>',FALSE), (@q,'<list>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour élément de liste ?', 'SINGLE_CHOICE', '<li>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<li>',TRUE), (@q,'<ul>',FALSE), (@q,'<ol>',FALSE), (@q,'<item>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Doctype correct ?', 'SINGLE_CHOICE', '<!DOCTYPE html>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<!DOCTYPE html>',TRUE), (@q,'<DOCTYPE html>',FALSE), (@q,'<html type>',FALSE), (@q,'<xml>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour texte gras ?', 'SINGLE_CHOICE', '<b> ou <strong>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<b>',TRUE), (@q,'<bold>',FALSE), (@q,'<g>',FALSE), (@q,'<big>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour texte italique ?', 'SINGLE_CHOICE', '<i> ou <em>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<i>',TRUE), (@q,'<italic>',FALSE), (@q,'<sl>',FALSE), (@q,'<emp>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour titre de la page (onglet) ?', 'SINGLE_CHOICE', '<title>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<title>',TRUE), (@q,'<head>',FALSE), (@q,'<meta>',FALSE), (@q,'<name>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Commentaire HTML ?', 'SINGLE_CHOICE', '<!-- ... -->', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<!-- -->',TRUE), (@q,'//',FALSE), (@q,'#',FALSE), (@q,'/* */',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour formulaire ?', 'SINGLE_CHOICE', '<form>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<form>',TRUE), (@q,'<input>',FALSE), (@q,'<table>',FALSE), (@q,'<f>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour tableau ?', 'SINGLE_CHOICE', '<table>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<table>',TRUE), (@q,'<grid>',FALSE), (@q,'<tab>',FALSE), (@q,'<t>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_beginner, 'Balise pour ligne de tableau ?', 'SINGLE_CHOICE', '<tr>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<tr>',TRUE), (@q,'<td>',FALSE), (@q,'<th>',FALSE), (@q,'<row>',FALSE);

-- Difficulty: INTERMEDIATE
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Attribut pour ouvrir lien nouvel onglet ?', 'SINGLE_CHOICE', 'target="_blank"', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'target="_blank"',TRUE), (@q,'target="new"',FALSE), (@q,'open="new"',FALSE), (@q,'window="new"',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour cellule de tableau ?', 'SINGLE_CHOICE', '<td>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<td>',TRUE), (@q,'<tr>',FALSE), (@q,'<th>',FALSE), (@q,'<cell>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour en-tête de tableau ?', 'SINGLE_CHOICE', '<th>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<th>',TRUE), (@q,'<td>',FALSE), (@q,'<head>',FALSE), (@q,'<tr>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour méta-données ?', 'SINGLE_CHOICE', '<meta>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<meta>',TRUE), (@q,'<head>',FALSE), (@q,'<info>',FALSE), (@q,'<data>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Input type case à cocher ?', 'SINGLE_CHOICE', 'checkbox', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'checkbox',TRUE), (@q,'check',FALSE), (@q,'radio',FALSE), (@q,'box',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Input type bouton radio ?', 'SINGLE_CHOICE', 'radio', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'radio',TRUE), (@q,'option',FALSE), (@q,'round',FALSE), (@q,'check',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour liste déroulante ?', 'SINGLE_CHOICE', '<select>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<select>',TRUE), (@q,'<dropdown>',FALSE), (@q,'<option>',FALSE), (@q,'<list>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Option dans une liste déroulante ?', 'SINGLE_CHOICE', '<option>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<option>',TRUE), (@q,'<select>',FALSE), (@q,'<item>',FALSE), (@q,'<choice>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour texte important (sémantique) ?', 'SINGLE_CHOICE', '<strong>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<strong>',TRUE), (@q,'<b>',FALSE), (@q,'<big>',FALSE), (@q,'<imp>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour emphase (sémantique) ?', 'SINGLE_CHOICE', '<em>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<em>',TRUE), (@q,'<i>',FALSE), (@q,'<sl>',FALSE), (@q,'<quote>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Attribut texte alternatif image ?', 'SINGLE_CHOICE', 'alt', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'alt',TRUE), (@q,'text',FALSE), (@q,'desc',FALSE), (@q,'title',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour zone de texte multi-lignes ?', 'SINGLE_CHOICE', '<textarea>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<textarea>',TRUE), (@q,'<input type="text">',FALSE), (@q,'<text>',FALSE), (@q,'<box>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour conteneur générique bloc ?', 'SINGLE_CHOICE', '<div>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<div>',TRUE), (@q,'<span>',FALSE), (@q,'<section>',FALSE), (@q,'<block>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour conteneur générique en ligne ?', 'SINGLE_CHOICE', '<span>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<span>',TRUE), (@q,'<div>',FALSE), (@q,'<text>',FALSE), (@q,'<line>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour navigation ?', 'SINGLE_CHOICE', '<nav>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<nav>',TRUE), (@q,'<menu>',FALSE), (@q,'<link>',FALSE), (@q,'<header>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour pied de page ?', 'SINGLE_CHOICE', '<footer>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<footer>',TRUE), (@q,'<bottom>',FALSE), (@q,'<end>',FALSE), (@q,'<section>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Attribut pour infobulle ?', 'SINGLE_CHOICE', 'title', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'title',TRUE), (@q,'alt',FALSE), (@q,'hover',FALSE), (@q,'tooltip',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Type d''input pour soumettre ?', 'SINGLE_CHOICE', 'submit', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'submit',TRUE), (@q,'button',FALSE), (@q,'send',FALSE), (@q,'ok',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour code ?', 'SINGLE_CHOICE', '<code>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<code>',TRUE), (@q,'<pre>',FALSE), (@q,'<var>',FALSE), (@q,'<samp>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_inter, 'Balise pour formatage préformatté ?', 'SINGLE_CHOICE', '<pre>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<pre>',TRUE), (@q,'<code>',FALSE), (@q,'<format>',FALSE), (@q,'<text>',FALSE);

-- Difficulty: ADVANCED
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Balise HTML5 pour contenu principal ?', 'SINGLE_CHOICE', '<main>', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<main>',TRUE), (@q,'<body>',FALSE), (@q,'<content>',FALSE), (@q,'<section>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Attribut pour fusionner colonnes (tableau) ?', 'SINGLE_CHOICE', 'colspan', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'colspan',TRUE), (@q,'rowspan',FALSE), (@q,'merge',FALSE), (@q,'cols',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Attribut pour fusionner lignes (tableau) ?', 'SINGLE_CHOICE', 'rowspan', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'rowspan',TRUE), (@q,'colspan',FALSE), (@q,'merge',FALSE), (@q,'rows',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Balise pour vidéo ?', 'SINGLE_CHOICE', '<video>', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<video>',TRUE), (@q,'<media>',FALSE), (@q,'<movie>',FALSE), (@q,'<film>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Balise pour audio ?', 'SINGLE_CHOICE', '<audio>', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<audio>',TRUE), (@q,'<sound>',FALSE), (@q,'<music>',FALSE), (@q,'<mp3>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Balise pour dessin vectoriel ?', 'SINGLE_CHOICE', '<svg>', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<svg>',TRUE), (@q,'<canvas>',FALSE), (@q,'<vector>',FALSE), (@q,'<img>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Balise pour dessin scripté (bitmap) ?', 'SINGLE_CHOICE', '<canvas>', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<canvas>',TRUE), (@q,'<svg>',FALSE), (@q,'<draw>',FALSE), (@q,'<bitmap>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Attribut pour placeholder input ?', 'SINGLE_CHOICE', 'placeholder', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'placeholder',TRUE), (@q,'value',FALSE), (@q,'hint',FALSE), (@q,'text',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Attribut requis (obligatoire) ?', 'SINGLE_CHOICE', 'required', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'required',TRUE), (@q,'mandatory',FALSE), (@q,'need',FALSE), (@q,'must',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Balise pour iframe ?', 'SINGLE_CHOICE', '<iframe>', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<iframe>',TRUE), (@q,'<frame>',FALSE), (@q,'<window>',FALSE), (@q,'<box>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Meta viewport sert à quoi ?', 'SINGLE_CHOICE', 'Responsive design (mobile).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Responsive',TRUE), (@q,'SEO',FALSE), (@q,'Encodage',FALSE), (@q,'Titre',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Encodage caractères balise ?', 'SINGLE_CHOICE', '<meta charset="UTF-8">', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<meta charset>',TRUE), (@q,'<encoding>',FALSE), (@q,'<xml>',FALSE), (@q,'<type>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Attribut pour compléter auto ?', 'SINGLE_CHOICE', 'autocomplete', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'autocomplete',TRUE), (@q,'autofill',FALSE), (@q,'suggest',FALSE), (@q,'complete',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Input type pour couleur ?', 'SINGLE_CHOICE', 'color', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'color',TRUE), (@q,'paint',FALSE), (@q,'rgb',FALSE), (@q,'palette',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Input type pour date ?', 'SINGLE_CHOICE', 'date', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'date',TRUE), (@q,'calendar',FALSE), (@q,'day',FALSE), (@q,'time',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Balise <section> vs <div> ?', 'SINGLE_CHOICE', '<section> est sémantique.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Sémantique',TRUE), (@q,'Taille',FALSE), (@q,'Couleur',FALSE), (@q,'Pareil',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Balise <article> ?', 'SINGLE_CHOICE', 'Contenu indépendant (article blog).', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Indépendant',TRUE), (@q,'Paragraphe',FALSE), (@q,'Lien',FALSE), (@q,'Image',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Attribut id doit être ?', 'SINGLE_CHOICE', 'Unique dans la page.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Unique',TRUE), (@q,'Multiple',FALSE), (@q,'Numérique',FALSE), (@q,'Caché',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Attribut pour lecture seule ?', 'SINGLE_CHOICE', 'readonly', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'readonly',TRUE), (@q,'disabled',FALSE), (@q,'blocked',FALSE), (@q,'static',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_html_adv, 'Attribut pour désactiver ?', 'SINGLE_CHOICE', 'disabled', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'disabled',TRUE), (@q,'readonly',FALSE), (@q,'off',FALSE), (@q,'stop',FALSE);
