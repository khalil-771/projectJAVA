# E-Learning Platform - Deployment Guide

## Prerequisites

### Required Software
- **Java JDK 17+** - [Download](https://www.oracle.com/java/technologies/downloads/)
- **Maven 3.6+** - [Download](https://maven.apache.org/download.cgi)
- **MySQL 8.0+** - [Download](https://dev.mysql.com/downloads/mysql/) or use XAMPP
- **Git** (optional) - For version control

### System Requirements
- **OS**: Windows 10/11, macOS, or Linux
- **RAM**: Minimum 4GB (8GB recommended)
- **Disk Space**: 500MB for application + database

---

## Installation Steps

### 1. Database Setup

#### Option A: Using XAMPP (Recommended for Windows)
1. Install XAMPP
2. Start Apache and MySQL from XAMPP Control Panel
3. MySQL will run on `localhost:3306`
4. Default credentials: `root` / (no password)

#### Option B: Standalone MySQL
1. Install MySQL Server
2. Create a root user or note your credentials
3. Ensure MySQL is running on port 3306

**Note**: The application will automatically create the database and tables on first run!

### 2. Application Setup

#### Clone or Download Project
```bash
cd c:\Users\hp\Desktop\newProjectJAVA
```

#### Configure Database Connection (if needed)
Edit `src/main/java/com/app/util/DatabaseConnection.java`:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/elearning_db";
private static final String DB_USER = "root";
private static final String DB_PASS = ""; // Change if you have a password
```

### 3. Build the Application

```bash
mvn clean install
```

This will:
- Download all dependencies
- Compile the code
- Run tests (if any)
- Create executable JAR

### 4. Run the Application

#### Option A: Using Maven
```bash
mvn javafx:run
```

#### Option B: Using IDE
1. Open project in IntelliJ IDEA or Eclipse
2. Right-click on `App.java`
3. Select "Run as Java Application"

#### Option C: Using JAR (after build)
```bash
java -jar target/elearning-platform-1.0.jar
```

---

## First Launch

### Automatic Setup
On first launch, the application will:
1. ✅ Connect to MySQL
2. ✅ Create `elearning_db` database
3. ✅ Create all tables (users, courses, quizzes, questions, etc.)
4. ✅ Create gamification tables (user_stats, badges, leaderboards)
5. ✅ Insert 15 pre-configured badges
6. ✅ Create admin user

### Default Credentials
- **Username**: `admin`
- **Password**: `admin123`

**IMPORTANT**: Change the admin password after first login!

---

## Troubleshooting

### Problem: "Unknown database 'elearning_db'"
**Solution**: 
- Ensure MySQL is running
- Check database connection settings
- The app should auto-create the database, but you can manually run:
  ```sql
  CREATE DATABASE elearning_db;
  ```

### Problem: "Access denied for user 'root'@'localhost'"
**Solution**:
- Check MySQL credentials in `DatabaseConnection.java`
- Reset MySQL root password if needed

### Problem: "Port 3306 already in use"
**Solution**:
- Another MySQL instance is running
- Stop other MySQL services
- Or change port in configuration

### Problem: JavaFX runtime components missing
**Solution**:
- Ensure you're using JDK 17+ with JavaFX bundled
- Or add JavaFX SDK to your project

### Problem: Maven build fails
**Solution**:
```bash
mvn clean
mvn install -U  # Force update dependencies
```

---

## Production Deployment

### 1. Create Executable JAR with Dependencies

Add to `pom.xml`:
```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-shade-plugin</artifactId>
            <version>3.4.1</version>
            <executions>
                <execution>
                    <phase>package</phase>
                    <goals>
                        <goal>shade</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

Build:
```bash
mvn clean package
```

### 2. Database Backup

```bash
mysqldump -u root -p elearning_db > backup.sql
```

### 3. Restore Database

```bash
mysql -u root -p elearning_db < backup.sql
```

### 4. Run as Service (Windows)

Use NSSM (Non-Sucking Service Manager):
```bash
nssm install ELearningPlatform "C:\Program Files\Java\jdk-17\bin\java.exe" "-jar C:\path\to\app.jar"
```

---

## Configuration

### Environment Variables (Optional)

Create `.env` file:
```
DB_HOST=localhost
DB_PORT=3306
DB_NAME=elearning_db
DB_USER=root
DB_PASS=yourpassword
```

### Application Properties

Create `application.properties`:
```properties
# Database
db.url=jdbc:mysql://localhost:3306/elearning_db
db.username=root
db.password=

# Application
app.name=E-Learning Platform
app.version=1.0.0

# Gamification
gamification.enabled=true
leaderboard.refresh.interval=300000
```

---

## Maintenance

### Regular Tasks

1. **Database Backup** (Daily/Weekly)
   ```bash
   mysqldump -u root -p elearning_db > backup_$(date +%Y%m%d).sql
   ```

2. **Clear Old Leaderboard Entries** (Monthly)
   ```sql
   DELETE FROM leaderboard_entries WHERE period_end < DATE_SUB(NOW(), INTERVAL 3 MONTH);
   ```

3. **Monitor Database Size**
   ```sql
   SELECT table_name, ROUND(((data_length + index_length) / 1024 / 1024), 2) AS "Size (MB)"
   FROM information_schema.TABLES
   WHERE table_schema = "elearning_db"
   ORDER BY (data_length + index_length) DESC;
   ```

### Updating the Application

1. Stop the application
2. Backup database
3. Replace JAR file
4. Restart application
5. Database migrations run automatically

---

## Security Recommendations

1. **Change Default Passwords**
   - Admin account
   - MySQL root password

2. **Use Strong Passwords**
   - Minimum 12 characters
   - Mix of letters, numbers, symbols

3. **Enable SSL for MySQL** (Production)
   ```java
   String DB_URL = "jdbc:mysql://localhost:3306/elearning_db?useSSL=true";
   ```

4. **Restrict Database Access**
   - Create dedicated MySQL user
   - Grant only necessary permissions

5. **Regular Updates**
   - Keep Java updated
   - Update Maven dependencies
   - Apply MySQL security patches

---

## Support

For issues or questions:
1. Check console logs
2. Review database connection
3. Verify MySQL is running
4. Check firewall settings

**Logs Location**: Console output or configure log4j for file logging

---

## Quick Reference

| Component | Default Value |
|-----------|--------------|
| Database Name | `elearning_db` |
| MySQL Port | `3306` |
| Admin Username | `admin` |
| Admin Password | `admin123` |
| Application Port | N/A (Desktop app) |

---

**Ready to Deploy!** 🚀

The application is production-ready with:
- ✅ Automatic database setup
- ✅ Gamification system
- ✅ Leaderboards
- ✅ Badge system
- ✅ User profiles
- ✅ Admin panel

Just run it and start learning!
