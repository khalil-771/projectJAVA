# 🚀 Guide de Démarrage Rapide - Plateforme QCM

## ⚡ Lancement Rapide

### 1. Démarrer MySQL
- Ouvrez XAMPP
- Démarrez Apache et MySQL
- MySQL doit tourner sur `localhost:3306`

### 2. Lancer l'Application

**Avec votre IDE (Recommandé):**
1. Ouvrez le projet dans IntelliJ IDEA ou Eclipse
2. Clic droit sur `App.java`
3. Sélectionnez "Run as Java Application"

**Avec Maven (si configuré):**
```bash
cd c:\Users\hp\Desktop\newProjectJAVA
mvn javafx:run
```

### 3. Première Connexion

**Compte Admin:**
- Utilisateur: `admin`
- Mot de passe: `admin123`

**Ou créez un nouveau compte:**
- Cliquez sur "S'inscrire"
- Remplissez le formulaire
- Connectez-vous avec vos identifiants

---

## ✅ Ce qui se passe au premier lancement:

1. ✅ Création automatique de la base de données `elearning_db`
2. ✅ Création de toutes les tables
3. ✅ Chargement de 15 badges
4. ✅ Chargement de 50 questions (HTML, CSS, JS, Java, Python)
5. ✅ Création du compte admin

**Tout est automatique!** 🎉

---

## 🎮 Fonctionnalités Disponibles:

### 📊 Dashboard
- Vue d'ensemble de vos statistiques
- Niveau actuel et XP
- Badges gagnés
- Série de jours consécutifs

### 🏆 Classement
- Classement quotidien
- Classement hebdomadaire
- Classement global
- Filtrage par langage

### 👤 Profil
- Toutes vos statistiques
- Collection complète de badges (gagnés/verrouillés)
- Progression par niveau

### 📝 Quiz
- 50 questions disponibles
- 5 langages (HTML, CSS, JavaScript, Java, Python)
- 3 niveaux de difficulté
- Gagnez des XP et débloquez des badges!

---

## 🏅 Système de Badges

**15 badges à débloquer:**
- 🎯 Premiers Pas - Complétez 1 quiz
- 💯 Score Parfait - Obtenez 100%
- 🔥 Série de 7 jours - Jouez 7 jours consécutifs
- ⭐ Niveau 5 - Atteignez le niveau 5
- 🌟 Et 11 autres badges!

---

## 📏 Tailles d'Écran

**Optimisé pour PC:**
- Résolution: 1280x800
- Minimum: 1024x768
- Interface adaptative

---

## ❓ Problèmes Courants

### La connexion ne fonctionne pas
✅ **Solution:** Vérifiez que MySQL est démarré dans XAMPP

### Pas de questions visibles
✅ **Solution:** Les questions se chargent automatiquement au premier lancement. Si problème, exécutez manuellement:
```sql
USE elearning_db;
SOURCE c:/Users/hp/Desktop/newProjectJAVA/database_sample_data.sql;
```

### Erreur de compilation
✅ **Solution:** Utilisez votre IDE pour compiler au lieu de Maven en ligne de commande

---

## 🎯 Prochaines Étapes

1. **Connectez-vous** avec admin/admin123
2. **Explorez le Dashboard** - Voyez vos stats
3. **Prenez un Quiz** - Cliquez sur un cours dans la barre latérale
4. **Gagnez des XP** - Débloquez votre premier badge!
5. **Consultez le Classement** - Voyez votre rang

---

**Bonne chance!** 🚀📚

De Débutant à Légende - Commencez votre voyage maintenant!
