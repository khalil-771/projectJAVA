package com.app.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.stream.Collectors;

public class DatabaseSetup {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    public static void initializeDatabase() {
        try {
            System.out.println("Checking database initialization...");

            // Connect to MySQL server without database specified
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                    Statement stmt = conn.createStatement()) {

                // Read the SQL script
                String sqlPath = "database_setup.sql";

                String content = "";
                if (Files.exists(Paths.get(sqlPath))) {
                    content = new String(Files.readAllBytes(Paths.get(sqlPath)));
                } else {
                    System.err.println("database_setup.sql not found at project root. Skipping auto-init.");
                    return;
                }

                String[] statements = content.split(";");

                for (String sql : statements) {
                    if (sql.trim().isEmpty())
                        continue;
                    try {
                        stmt.execute(sql);
                    } catch (Exception e) {
                        // Ignore
                    }
                }

                // Ensure correct admin password
                ensureAdminUser(conn);

                System.out.println("Database initialization completed.");

                // Run gamification extensions
                runGamificationScript(conn);
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to initialize database: " + e.getMessage());
        }
    }

    private static void ensureAdminUser(Connection conn) {
        try {
            // Need to select database first
            try (Statement stmt = conn.createStatement()) {
                stmt.execute("USE elearning_db");
            }

            String checkSql = "SELECT count(*) FROM users WHERE username = 'admin'";
            try (Statement stmt = conn.createStatement();
                    java.sql.ResultSet rs = stmt.executeQuery(checkSql)) {

                if (rs.next() && rs.getInt(1) > 0) {
                    // Update existing admin password
                    String updateSql = "UPDATE users SET password_hash = ? WHERE username = 'admin'";
                    try (java.sql.PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                        String hash = org.mindrot.jbcrypt.BCrypt.hashpw("admin123",
                                org.mindrot.jbcrypt.BCrypt.gensalt());
                        pstmt.setString(1, hash);
                        pstmt.executeUpdate();
                        System.out.println("Admin password updated to 'admin123'");
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
                        System.out.println("Admin user created with password 'admin123'");
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Failed to ensure admin user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void runGamificationScript(Connection conn) {
        try {
            System.out.println("Running gamification extensions...");

            String gamificationPath = "database_gamification.sql";
            if (!Files.exists(Paths.get(gamificationPath))) {
                System.out.println("Gamification script not found, skipping.");
                return;
            }

            String content = new String(Files.readAllBytes(Paths.get(gamificationPath)));
            String[] statements = content.split(";");

            try (Statement stmt = conn.createStatement()) {
                for (String sql : statements) {
                    if (sql.trim().isEmpty())
                        continue;
                    try {
                        stmt.execute(sql);
                    } catch (Exception e) {
                        // Ignore errors (table might already exist)
                    }
                }
            }

            System.out.println("Gamification extensions completed.");
        } catch (Exception e) {
            System.err.println("Failed to run gamification script: " + e.getMessage());
        }
    }
}
