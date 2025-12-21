# E-Learning Platform - README

## 🎓 Complete Gamified E-Learning Platform

A feature-rich desktop application for interactive learning with gamification, built with JavaFX and MySQL.

---

## ✨ Features

### 🎮 Gamification System
- **Points & Levels**: Earn XP, level up from Beginner to Legend
- **15 Badges**: Achievement, Milestone, Mastery, and Special badges
- **Streak Tracking**: Daily streak system to encourage consistent learning
- **Leaderboards**: Daily, Weekly, and Global rankings

### 📚 Learning Features
- **Multi-Language Quizzes**: Support for 14 programming languages
- **Difficulty Levels**: Beginner, Intermediate, Advanced
- **Animated Feedback**: Points animations and badge notifications
- **Progress Tracking**: Detailed statistics and accuracy rates

### 👤 User Features
- **Dashboard**: Overview of stats, level, badges, and streaks
- **Profile Page**: Complete badge collection (earned & locked)
- **Leaderboard**: Compete with other learners globally or per language
- **Quiz History**: Track your performance over time

### ⚙️ Admin Panel
- **Question Management**: Add, edit, delete questions
- **Badge Management**: View and manage badges
- **Analytics**: User statistics and platform insights (coming soon)

---

## 🚀 Quick Start

### Prerequisites
- Java JDK 17+
- MySQL 8.0+ (or XAMPP)
- Maven 3.6+

### Installation

1. **Start MySQL** (via XAMPP or standalone)

2. **Run the Application**
   ```bash
   cd c:\Users\hp\Desktop\newProjectJAVA
   mvn javafx:run
   ```

3. **Login**
   - Username: `admin`
   - Password: `admin123`

4. **Start Learning!**
   - Click "📊 Dashboard" to see your stats
   - Take quizzes to earn XP and badges
   - Check "🏆 Leaderboard" to see rankings

**That's it!** The database auto-creates on first run.

---

## 📊 System Architecture

```
├── src/main/java/com/app/
│   ├── controller/      # UI Controllers (Dashboard, Leaderboard, Profile, etc.)
│   ├── dao/             # Data Access Objects
│   ├── model/           # Data Models (User, Badge, UserStats, etc.)
│   ├── service/         # Business Logic (StatsService, BadgeService, etc.)
│   └── util/            # Utilities (DatabaseConnection, DatabaseSetup)
├── src/main/resources/
│   ├── view/            # FXML Views
│   └── css/             # Stylesheets
└── database_*.sql       # Database schemas
```

---

## 🎯 Key Components

### Models
- `UserStats` - Points, level, streak, accuracy
- `Badge` - Achievement definitions
- `LeaderboardEntry` - Rankings
- `ProgrammingLanguage` - 14 supported languages
- `DifficultyLevel` - BEGINNER, INTERMEDIATE, ADVANCED

### Services
- `StatsService` - Manage user statistics and level-ups
- `BadgeService` - Award badges based on achievements
- `LeaderboardService` - Calculate rankings
- `QuizService` - Handle quiz logic and scoring

### Controllers
- `DashboardController` - Stats overview
- `LeaderboardController` - Rankings display
- `ProfileController` - User profile with badge collection
- `QuizController` - Quiz interface with animations
- `AdminController` - Admin panel

---

## 🏆 Badge System

### Types of Badges
1. **Achievement** - One-time accomplishments
   - First Steps, Perfect Score, Speed Demon

2. **Milestone** - Progress markers
   - Quiz Enthusiast (10 quizzes), Quiz Master (50 quizzes)

3. **Mastery** - Language expertise
   - Java Beginner, Python Master, HTML Master

4. **Special** - Rare achievements
   - Polyglot (5 languages), Champion (#1 rank)

### How to Earn
- Complete quizzes
- Maintain streaks
- Achieve high accuracy
- Reach top rankings
- Master multiple languages

---

## 📈 Leveling System

| Level | Title | XP Required |
|-------|-------|-------------|
| 1-4 | Beginner | 0-400 |
| 5-9 | Apprentice | 400-1,500 |
| 10-19 | Intermediate | 1,500-5,000 |
| 20-29 | Advanced | 5,000-15,000 |
| 30-39 | Expert | 15,000-35,000 |
| 40-49 | Master | 35,000-70,000 |
| 50+ | Legend | 70,000+ |

**XP Sources:**
- Quiz completion: 10 XP per question × score%
- Perfect score bonus: +50 XP
- Badge rewards: +50 to +1000 XP

---

## 🗄️ Database Schema

### Core Tables
- `users` - User accounts
- `courses` - Learning courses
- `quizzes` - Quiz definitions
- `questions` - Quiz questions
- `answers` - Question answers

### Gamification Tables
- `user_stats` - Points, levels, streaks
- `badges` - Badge definitions
- `user_badges` - Earned badges
- `user_language_stats` - Per-language performance
- `leaderboard_entries` - Rankings

---

## 🎨 UI Features

### Animations
- Fade-in effects for results
- Scale animations for points
- Badge unlock notifications
- Smooth transitions

### Styling
- Modern card-based layouts
- Color-coded difficulty levels
- Progress bars with gradients
- Responsive design

### Navigation
- 📊 Dashboard - Stats overview
- 🏆 Leaderboard - Rankings
- 👤 Profile - Badge collection
- 📚 Courses - Learning content

---

## 🔧 Configuration

### Database Connection
Edit `src/main/java/com/app/util/DatabaseConnection.java`:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/elearning_db";
private static final String DB_USER = "root";
private static final String DB_PASS = "";
```

### Supported Languages
Java, Python, C++, C, HTML, CSS, JavaScript, SQL, Kotlin, PHP, C#, Ruby, Swift, Go

---

## 📝 Development

### Build
```bash
mvn clean install
```

### Run Tests
```bash
mvn test
```

### Package
```bash
mvn package
```

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

---

## 📄 License

This project is licensed under the MIT License.

---

## 🆘 Support

### Common Issues

**Database connection failed**
- Ensure MySQL is running
- Check credentials in `DatabaseConnection.java`

**Login failed**
- Use `admin` / `admin123`
- Database auto-creates on first run

**JavaFX errors**
- Ensure JDK 17+ with JavaFX
- Run with `mvn javafx:run`

### Documentation
- [Deployment Guide](DEPLOYMENT.md)
- [Quick Start Guide](QUICK_START.md)
- [Walkthrough](walkthrough.md)

---

## 🎉 Credits

Built with:
- **JavaFX 17** - UI Framework
- **MySQL 8** - Database
- **Maven** - Build Tool
- **HikariCP** - Connection Pooling
- **BCrypt** - Password Hashing

---

**Happy Learning!** 🚀📚

Start your journey from Beginner to Legend!
"# javaProct" 
