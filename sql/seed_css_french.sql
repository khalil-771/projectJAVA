-- CSS Questions (60 total)
SET @quiz_css_beginner = (SELECT id FROM quizzes WHERE title='CSS: Quiz Débutant');
SET @quiz_css_inter = (SELECT id FROM quizzes WHERE title='CSS: Quiz Intermédiaire');
SET @quiz_css_adv = (SELECT id FROM quizzes WHERE title='CSS: Quiz Avancé');

-- Difficulty: BEGINNER
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Que signifie CSS ?', 'SINGLE_CHOICE', 'Cascading Style Sheets', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Cascading Style Sheets',TRUE), (@q,'Colorful Style Sheets',FALSE), (@q,'Computer Style Sheets',FALSE), (@q,'Creative Style Sheets',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Sélecteur pour un élément p ?', 'SINGLE_CHOICE', 'p', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'p',TRUE), (@q,'#p',FALSE), (@q,'.p',FALSE), (@q,'*p',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Changer la couleur du texte ?', 'SINGLE_CHOICE', 'color', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'color',TRUE), (@q,'text-color',FALSE), (@q,'font-color',FALSE), (@q,'bg-color',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Changer la couleur de fond ?', 'SINGLE_CHOICE', 'background-color', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'background-color',TRUE), (@q,'color',FALSE), (@q,'bg',FALSE), (@q,'back',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Changer la taille du texte ?', 'SINGLE_CHOICE', 'font-size', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'font-size',TRUE), (@q,'text-size',FALSE), (@q,'size',FALSE), (@q,'height',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Mettre le texte en gras ?', 'SINGLE_CHOICE', 'font-weight: bold', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'font-weight',TRUE), (@q,'font-style',FALSE), (@q,'text-decoration',FALSE), (@q,'bold',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Sélecteur pour un ID "test" ?', 'SINGLE_CHOICE', '#test', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'#test',TRUE), (@q,'.test',FALSE), (@q,'test',FALSE), (@q,'*test',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Sélecteur pour une classe "test" ?', 'SINGLE_CHOICE', '.test', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'.test',TRUE), (@q,'#test',FALSE), (@q,'test',FALSE), (@q,'class=test',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Centrer le texte ?', 'SINGLE_CHOICE', 'text-align: center', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'text-align: center',TRUE), (@q,'align: center',FALSE), (@q,'center-text',FALSE), (@q,'justify',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Quelle propriété pour la marge externe ?', 'SINGLE_CHOICE', 'margin', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'margin',TRUE), (@q,'padding',FALSE), (@q,'border',FALSE), (@q,'spacing',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Quelle propriété pour la marge interne ?', 'SINGLE_CHOICE', 'padding', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'padding',TRUE), (@q,'margin',FALSE), (@q,'gap',FALSE), (@q,'inner',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Comment insérer CSS dans HTML ?', 'SINGLE_CHOICE', '<style>', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'<style>',TRUE), (@q,'<css>',FALSE), (@q,'<script>',FALSE), (@q,'<link css>',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Changer la police ?', 'SINGLE_CHOICE', 'font-family', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'font-family',TRUE), (@q,'font-style',FALSE), (@q,'font-type',FALSE), (@q,'text-font',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Commentaire CSS ?', 'SINGLE_CHOICE', '/* ... */', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'/* */',TRUE), (@q,'//',FALSE), (@q,'#',FALSE), (@q,'<!-- -->',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Enlever le soulignement d''un lien ?', 'SINGLE_CHOICE', 'text-decoration: none', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'text-decoration: none',TRUE), (@q,'underline: none',FALSE), (@q,'style: none',FALSE), (@q,'link: none',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Largeur d''un élément ?', 'SINGLE_CHOICE', 'width', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'width',TRUE), (@q,'height',FALSE), (@q,'size',FALSE), (@q,'col',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Hauteur d''un élément ?', 'SINGLE_CHOICE', 'height', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'height',TRUE), (@q,'width',FALSE), (@q,'tall',FALSE), (@q,'row',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Bordure style ?', 'SINGLE_CHOICE', 'border-style', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'border-style',TRUE), (@q,'border',FALSE), (@q,'style',FALSE), (@q,'line',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Mettre en italique ?', 'SINGLE_CHOICE', 'font-style: italic', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'font-style',TRUE), (@q,'font-weight',FALSE), (@q,'text-style',FALSE), (@q,'italic',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_beginner, 'Sélectionner tous les éléments ?', 'SINGLE_CHOICE', '*', 'BEGINNER');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'*',TRUE), (@q,'all',FALSE), (@q,'body',FALSE), (@q,'root',FALSE);

-- Difficulty: INTERMEDIATE
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Sélecteur enfant direct ?', 'SINGLE_CHOICE', '>', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'>',TRUE), (@q,'+',FALSE), (@q,'~',FALSE), (@q,'space',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Sélecteur frère adjacent ?', 'SINGLE_CHOICE', '+', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'+',TRUE), (@q,'>',FALSE), (@q,'~',FALSE), (@q,'-',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Pseudo-classe au survol ?', 'SINGLE_CHOICE', ':hover', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,':hover',TRUE), (@q,':focus',FALSE), (@q,':click',FALSE), (@q,':active',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Pseudo-classe lien visité ?', 'SINGLE_CHOICE', ':visited', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,':visited',TRUE), (@q,':link',FALSE), (@q,':active',FALSE), (@q,':seen',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Modèle de boîte (box model) inclut ?', 'SINGLE_CHOICE', 'Content, Padding, Border, Margin.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Padding/Border/Margin',TRUE), (@q,'Color/Font/Size',FALSE), (@q,'Header/Footer',FALSE), (@q,'HTML/CSS',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Changer box-model pour inclure border ?', 'SINGLE_CHOICE', 'box-sizing: border-box', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'border-box',TRUE), (@q,'content-box',FALSE), (@q,'padding-box',FALSE), (@q,'fill-box',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Propriété pour opacité ?', 'SINGLE_CHOICE', 'opacity', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'opacity',TRUE), (@q,'transparent',FALSE), (@q,'visibility',FALSE), (@q,'display',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Cacher un élément (mais garde l''espace) ?', 'SINGLE_CHOICE', 'visibility: hidden', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'visibility: hidden',TRUE), (@q,'display: none',FALSE), (@q,'opacity: 0',FALSE), (@q,'hide: true',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Retirer un élément du flux ?', 'SINGLE_CHOICE', 'display: none', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'display: none',TRUE), (@q,'visibility: hidden',FALSE), (@q,'opacity: 0',FALSE), (@q,'remove: true',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Position relative par rapport à ?', 'SINGLE_CHOICE', 'Sa position normale.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Position normale',TRUE), (@q,'Parent',FALSE), (@q,'Page',FALSE), (@q,'Fenêtre',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Position absolute par rapport à ?', 'SINGLE_CHOICE', 'Premier parent positionné.', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Parent positionné',TRUE), (@q,'Page',FALSE), (@q,'Lui-même',FALSE), (@q,'Body',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Position fixed par rapport à ?', 'SINGLE_CHOICE', 'La fenêtre (viewport).', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Viewport',TRUE), (@q,'Page',FALSE), (@q,'Parent',FALSE), (@q,'Document',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Superposition (Z-axis) ?', 'SINGLE_CHOICE', 'z-index', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'z-index',TRUE), (@q,'stack',FALSE), (@q,'layer',FALSE), (@q,'level',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Flexbox container ?', 'SINGLE_CHOICE', 'display: flex', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'display: flex',TRUE), (@q,'display: block',FALSE), (@q,'position: flex',FALSE), (@q,'flex: 1',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Flexbox direction ?', 'SINGLE_CHOICE', 'flex-direction', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'flex-direction',TRUE), (@q,'flex-flow',FALSE), (@q,'flex-align',FALSE), (@q,'flex-wrap',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Aligner items axe principal (flex) ?', 'SINGLE_CHOICE', 'justify-content', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'justify-content',TRUE), (@q,'align-items',FALSE), (@q,'align-content',FALSE), (@q,'text-align',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Aligner items axe croisé (flex) ?', 'SINGLE_CHOICE', 'align-items', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'align-items',TRUE), (@q,'justify-content',FALSE), (@q,'vertical-align',FALSE), (@q,'text-align',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Arrondir les coins ?', 'SINGLE_CHOICE', 'border-radius', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'border-radius',TRUE), (@q,'corner-radius',FALSE), (@q,'round',FALSE), (@q,'border-round',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Ombre de boîte ?', 'SINGLE_CHOICE', 'box-shadow', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'box-shadow',TRUE), (@q,'shadow',FALSE), (@q,'drop-shadow',FALSE), (@q,'border-shadow',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_inter, 'Image de fond qui ne se répète pas ?', 'SINGLE_CHOICE', 'background-repeat: no-repeat', 'INTERMEDIATE');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'no-repeat',TRUE), (@q,'repeat-x',FALSE), (@q,'repeat-y',FALSE), (@q,'once',FALSE);

-- Difficulty: ADVANCED
INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Grid Layout container ?', 'SINGLE_CHOICE', 'display: grid', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'display: grid',TRUE), (@q,'display: flex',FALSE), (@q,'display: table',FALSE), (@q,'position: grid',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Définir colonnes grille ?', 'SINGLE_CHOICE', 'grid-template-columns', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'grid-template-columns',TRUE), (@q,'grid-columns',FALSE), (@q,'columns',FALSE), (@q,'grid-template',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Unité relative à la racine (html) ?', 'SINGLE_CHOICE', 'rem', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'rem',TRUE), (@q,'em',FALSE), (@q,'%',FALSE), (@q,'vh',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Unité relative au parent ?', 'SINGLE_CHOICE', 'em', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'em',TRUE), (@q,'rem',FALSE), (@q,'px',FALSE), (@q,'pt',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Unité viewport height ?', 'SINGLE_CHOICE', 'vh', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'vh',TRUE), (@q,'vw',FALSE), (@q,'%',FALSE), (@q,'px',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Media Query pour mobile ?', 'SINGLE_CHOICE', '@media (max-width: ...)', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'@media',TRUE), (@q,'@mobile',FALSE), (@q,'@check',FALSE), (@q,'@screen',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Pseudo-élément avant contenu ?', 'SINGLE_CHOICE', '::before', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'::before',TRUE), (@q,'::after',FALSE), (@q,'::first',FALSE), (@q,'::start',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Variable CSS déclaration ?', 'SINGLE_CHOICE', '--nom-variable', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'--',TRUE), (@q,'$',FALSE), (@q,'@',FALSE), (@q,'var-',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Variable CSS utilisation ?', 'SINGLE_CHOICE', 'var(--nom)', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'var()',TRUE), (@q,'val()',FALSE), (@q,'$()',FALSE), (@q,'use()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Animation définition ?', 'SINGLE_CHOICE', '@keyframes', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'@keyframes',TRUE), (@q,'@animate',FALSE), (@q,'@motion',FALSE), (@q,'@frames',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Propriété transition ?', 'SINGLE_CHOICE', 'transition', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'transition',TRUE), (@q,'animation',FALSE), (@q,'transform',FALSE), (@q,'change',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Transformer élément (rotation...) ?', 'SINGLE_CHOICE', 'transform', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'transform',TRUE), (@q,'transition',FALSE), (@q,'rotate',FALSE), (@q,'move',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Valeur important ?', 'SINGLE_CHOICE', '!important', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'!important',TRUE), (@q,'important',FALSE), (@q,'priority',FALSE), (@q,'override',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Calculer valeur ?', 'SINGLE_CHOICE', 'calc()', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'calc()',TRUE), (@q,'math()',FALSE), (@q,'sum()',FALSE), (@q,'val()',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Cacher scrollbar ?', 'SINGLE_CHOICE', 'overflow: hidden', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'overflow: hidden',TRUE), (@q,'scroll: none',FALSE), (@q,'overflow: none',FALSE), (@q,'scrollbar: hidden',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Sticky positioning ?', 'SINGLE_CHOICE', 'position: sticky', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'sticky',TRUE), (@q,'fixed',FALSE), (@q,'absolute',FALSE), (@q,'glue',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Flexbox espace restant ?', 'SINGLE_CHOICE', 'flex-grow', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'flex-grow',TRUE), (@q,'flex-shrink',FALSE), (@q,'flex-basis',FALSE), (@q,'flex-size',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Grid espace entre cellules ?', 'SINGLE_CHOICE', 'gap', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'gap',TRUE), (@q,'margin',FALSE), (@q,'padding',FALSE), (@q,'space',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'CSS Reset ?', 'SINGLE_CHOICE', 'Réinitialiser styles navigateur.', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'Réinitialiser',TRUE), (@q,'Effacer CSS',FALSE), (@q,'Nouveau fichier',FALSE), (@q,'Standardiser IE',FALSE);

INSERT INTO questions (quiz_id, question_text, question_type, explanation, difficulty) VALUES
(@quiz_css_adv, 'Spécificité sélecteur ?', 'SINGLE_CHOICE', 'ID > Class > Tag', 'ADVANCED');
SET @q = LAST_INSERT_ID(); INSERT INTO answers (question_id, answer_text, is_correct) VALUES (@q,'ID > Class > Tag',TRUE), (@q,'Tag > Class > ID',FALSE), (@q,'Class > ID > Tag',FALSE), (@q,'Tag > ID > Class',FALSE);
