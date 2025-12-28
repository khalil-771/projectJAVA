package com.app.controller;

import com.app.model.User;
import com.app.service.AuthenticationService;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Stage;

public class RegisterController {

    @FXML
    private TextField usernameField;
    @FXML
    private TextField emailField;
    @FXML
    private PasswordField passwordField;
    @FXML
    private PasswordField confirmPasswordField;
    @FXML
    private Label errorLabel;
    @FXML
    private Button registerButton;
    @FXML
    private Hyperlink loginLink;

    private final AuthenticationService authService = new AuthenticationService();

    @FXML
    private void handleRegister() {
        String username = usernameField.getText().trim();
        String email = emailField.getText().trim();
        String password = passwordField.getText();
        String confirmPassword = confirmPasswordField.getText();

        // Validation
        if (username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            showError("Tous les champs sont obligatoires!");
            return;
        }

        if (username.length() < 3) {
            showError("Le nom d'utilisateur doit contenir au moins 3 caractères!");
            return;
        }

        if (!email.contains("@")) {
            showError("Email invalide!");
            return;
        }

        if (password.length() < 6) {
            showError("Le mot de passe doit contenir au moins 6 caractères!");
            return;
        }

        if (!password.equals(confirmPassword)) {
            showError("Les mots de passe ne correspondent pas!");
            return;
        }

        // Register user
        System.out.println("RegisterController: Requesting registration for: " + username);
        boolean success = authService.register(username, email, password);

        if (success) {
            System.out.println("RegisterController: Registration SUCCESS for: " + username);
            showSuccess("Inscription réussie! Vous pouvez maintenant vous connecter.");

            // Wait 2 seconds then go to login
            new Thread(() -> {
                try {
                    Thread.sleep(2000);
                    javafx.application.Platform.runLater(this::goToLogin);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }).start();
        } else {
            System.out.println("RegisterController: Registration FAILED for: " + username);
            showError("Échec de l'inscription. Le nom d'utilisateur existe peut-être déjà.");
        }
    }

    @FXML
    private void goToLogin() {
        try {
            com.app.App.setRoot("login");
        } catch (Exception e) {
            e.printStackTrace();
            showError("Erreur de navigation vers la page de connexion.");
        }
    }

    private void showError(String message) {
        errorLabel.setText("❌ " + message);
        errorLabel.setStyle("-fx-text-fill: #F44336; -fx-font-weight: bold;");
    }

    private void showSuccess(String message) {
        errorLabel.setText("✅ " + message);
        errorLabel.setStyle("-fx-text-fill: #4CAF50; -fx-font-weight: bold;");
    }
}
