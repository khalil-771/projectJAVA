package com.app.util;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DatabaseSetup {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    public static void initializeDatabase() {
        try {
            System.out.println("Checking database initialization...");

            // Connect to MySQL server
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                    Statement stmt = conn.createStatement()) {

                // Create database if not exists
                stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS quiztests");
                stmt.execute("USE quiztests");

                // NOTE: We checking if tables exist to decide on repair
                boolean tablesExist = false;
                try (java.sql.ResultSet rs = conn.getMetaData().getTables("quiztests", null, "users", null)) {
                    if (rs.next()) {
                        tablesExist = true;
                    }
                }

                if (!tablesExist) {
                    System.out.println("⚠️ Tables missing. Running structure restoration...");
                    runScript(conn, "database_structure.sql");
                }

                // Ensure correct admin user (Idempotent check)
                ensureAdminUser(conn);

                // Ensure a test student user (Idempotent check)
                ensureStudentUser(conn);

                System.out.println("Database check completed. Automatic seeding is disabled.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to initialize database: " + e.getMessage());
        }
    }

    private static void runScript(Connection conn, String fileName) {
        try {
            String path = fileName; // Assume root
            if (Files.exists(Paths.get(path))) {
                String content = new String(Files.readAllBytes(Paths.get(path)));
                String[] statements = content.split(";");
                try (Statement stmt = conn.createStatement()) {
                    for (String sql : statements) {
                        if (sql.trim().isEmpty())
                            continue;
                        try {
                            stmt.execute(sql);
                        } catch (Exception ex) {
                            // System.err.println("Sql warning: " + ex.getMessage());
                        }
                    }
                }
                System.out.println("✅ Script " + fileName + " executed.");
            } else {
                System.err.println("❌ Script " + fileName + " not found!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void ensureAdminUser(Connection conn) {
        try {
            // Check if admin exists
            String checkSql = "SELECT count(*) FROM users WHERE username = 'admin'";
            try (Statement stmt = conn.createStatement();
                    java.sql.ResultSet rs = stmt.executeQuery(checkSql)) {

                if (rs.next() && rs.getInt(1) > 0) {
                    // Admin exists, FORCE UPDATE to ensure password is valid
                    // This fixes the issue where a bad hash might have been inserted manually
                    String updateSql = "UPDATE users SET password_hash = ? WHERE username = 'admin'";
                    try (java.sql.PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                        String hash = org.mindrot.jbcrypt.BCrypt.hashpw("admin123",
                                org.mindrot.jbcrypt.BCrypt.gensalt());
                        pstmt.setString(1, hash);
                        pstmt.executeUpdate();
                        System.out.println("✅ Admin password RE-SYNCED to 'admin123'");
                    }
                } else {
                    // Insert new admin
                    String insertSql = "INSERT INTO users (username, email, password_hash, role) VALUES (?, ?, ?, ?)";
                    try (java.sql.PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                        String hash = org.mindrot.jbcrypt.BCrypt.hashpw("admin123",
                                org.mindrot.jbcrypt.BCrypt.gensalt());
                        pstmt.setString(1, "admin");
                        pstmt.setString(2, "admin@example.com");
                        pstmt.setString(3, hash);
                        pstmt.setString(4, "ROLE_ADMIN");
                        pstmt.executeUpdate();
                        System.out.println("Admin user created.");
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Failed to ensure admin user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void ensureStudentUser(Connection conn) {
        try {
            String checkSql = "SELECT count(*) FROM users WHERE username = 'student'";
            try (Statement stmt = conn.createStatement();
                    java.sql.ResultSet rs = stmt.executeQuery(checkSql)) {

                if (rs.next() && rs.getInt(1) > 0) {
                    // Student exists, FORCE UPDATE
                    String updateSql = "UPDATE users SET password_hash = ? WHERE username = 'student'";
                    try (java.sql.PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                        String hash = org.mindrot.jbcrypt.BCrypt.hashpw("student123",
                                org.mindrot.jbcrypt.BCrypt.gensalt());
                        pstmt.setString(1, hash);
                        pstmt.executeUpdate();
                        System.out.println("✅ Student password RE-SYNCED to 'student123'");
                    }
                } else {
                    // Insert new student
                    String insertSql = "INSERT INTO users (username, email, password_hash, role) VALUES (?, ?, ?, ?)";
                    try (java.sql.PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                        String hash = org.mindrot.jbcrypt.BCrypt.hashpw("student123",
                                org.mindrot.jbcrypt.BCrypt.gensalt());
                        pstmt.setString(1, "student");
                        pstmt.setString(2, "student@example.com");
                        pstmt.setString(3, hash);
                        pstmt.setString(4, "ROLE_STUDENT");
                        pstmt.executeUpdate();
                        System.out.println("Student user created.");
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Failed to ensure student user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // private static void runGamificationScript(Connection conn) { ... } // Removed
    // private static void runSeedScript(Connection conn) { ... } // Removed

}
