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
        if (userDAO.findByUsername(username).isPresent() || userDAO.findByEmail(email).isPresent()) {
            return false; // User already exists
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        User newUser = new User(username, email, hashedPassword, User.Role.ROLE_STUDENT);
        return userDAO.create(newUser);
    }

    public void logout() {
        currentUser = null;
    }

    public static User getCurrentUser() {
        return currentUser;
    }
}
