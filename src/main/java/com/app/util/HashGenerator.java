package com.app.util;

import org.mindrot.jbcrypt.BCrypt;

public class HashGenerator {
    public static void main(String[] args) {
        String adminPass = BCrypt.hashpw("admin123", BCrypt.gensalt());
        String studentPass = BCrypt.hashpw("student123", BCrypt.gensalt());
        System.out.println("ADMIN_HASH=" + adminPass);
        System.out.println("STUDENT_HASH=" + studentPass);
    }
}
