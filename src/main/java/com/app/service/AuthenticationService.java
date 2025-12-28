package com.app.service;

import com.app.dao.UserDAO;
import com.app.dao.impl.UserDAOImpl;
import com.app.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.util.Optional;

public class AuthenticationService {

    private final UserDAO userDAO;
    private static User currentUser;

    public AuthenticationService() {
        this.userDAO = new UserDAOImpl();
    }

    public User login(String username, String password) {
        System.out.println("AuthService: finding user " + username);
        Optional<User> userOpt = userDAO.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            System.out.println("User found. Checking password...");
            if (BCrypt.checkpw(password, user.getPasswordHash())) {
                System.out.println("Password correct!");
                currentUser = user;
                return user;
            } else {
                System.out.println("Password incorrect.");
            }
        } else {
            System.out.println("User not found.");
        }
        return null; // Login failed
    }

    public boolean register(String username, String email, String password) {
        System.out.println("AuthService: Registering user: " + username);
        if (userDAO.findByUsername(username).isPresent()) {
            System.out.println("AuthService: Registration failed - Username already exists: " + username);
            return false;
        }
        if (userDAO.findByEmail(email).isPresent()) {
            System.out.println("AuthService: Registration failed - Email already exists: " + email);
            return false;
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        User newUser = new User(username, email, hashedPassword, User.Role.ROLE_STUDENT);
        boolean created = userDAO.create(newUser);
        System.out.println("AuthService: Registration " + (created ? "SUCCESS" : "FAILED") + " for " + username);
        return created;
    }

    public void logout() {
        currentUser = null;
    }

    public static User getCurrentUser() {
        return currentUser;
    }
}
