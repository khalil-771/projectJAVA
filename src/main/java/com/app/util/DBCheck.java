package com.app.util;

import java.sql.*;

public class DBCheck {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConnection.getConnection();
                ResultSet rs = conn.getMetaData().getTables(null, null, "%", new String[] { "TABLE" })) {
            System.out.println("--- Table List ---");
            while (rs.next()) {
                System.out.println(rs.getString("TABLE_NAME"));
            }
            System.out.println("------------------");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
