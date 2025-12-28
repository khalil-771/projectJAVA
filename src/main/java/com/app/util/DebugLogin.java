package com.app.util;

import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;

public class DebugLogin {
    public static void main(String[] args) {
        System.out.println("DEBUGGING LOGIN...");
        String url = "jdbc:mysql://localhost:3306/quiztests";
        String user = "root";
        String pass = "";

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            System.out.println("✅ Connected to DB");

            // Check Users
            String sql = "SELECT id, username, password_hash, role FROM users WHERE username='admin'";
            try (Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql)) {

                if (rs.next()) {
                    String hash = rs.getString("password_hash");
                    System.out.println("✅ Found User: admin");
                    System.out.println("   Hash: " + hash);

                    boolean check = BCrypt.checkpw("admin123", hash);
                    System.out.println("   BCrypt Check ('admin123'): " + (check ? "PASS" : "FAIL"));

                    if (!check) {
                        System.out.println("⚠️ Password mismatch! Re-hashing...");
                        String newHash = BCrypt.hashpw("admin123", BCrypt.gensalt());
                        System.out.println("   New Hash: " + newHash);

                        // Fix it
                        PreparedStatement ps = conn
                                .prepareStatement("UPDATE users SET password_hash=? WHERE username='admin'");
                        ps.setString(1, newHash);
                        ps.executeUpdate();
                        System.out.println("✅ Admin password RESET to 'admin123'");
                    }
                } else {
                    System.out.println("❌ User 'admin' NOT FOUND in DB!");

                    // Create it
                    System.out.println("🛠 Creating admin user...");
                    String newHash = BCrypt.hashpw("admin123", BCrypt.gensalt());
                    String insert = "INSERT INTO users (username, email, password_hash, role) VALUES ('admin', 'admin@devquiz.com', ?, 'ROLE_ADMIN')";
                    try (PreparedStatement ps = conn.prepareStatement(insert)) {
                        ps.setString(1, newHash);
                        ps.executeUpdate();
                        System.out.println("✅ Admin User CREATED.");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
