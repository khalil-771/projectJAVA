package com.app.controller;

import com.app.model.User;
import com.app.service.AuthenticationService;
import com.app.App;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import java.io.IOException;

public class LoginController {

    @FXML
    private TextField usernameField;
    @FXML
    private PasswordField passwordField;
    @FXML
    private javafx.scene.control.Label errorLabel;

    private final AuthenticationService authService = new AuthenticationService();

    @FXML
    private void handleLogin() throws IOException {
        String username = usernameField.getText();
        String password = passwordField.getText();

        if (username.isEmpty() || password.isEmpty()) {
            showError("Veuillez remplir tous les champs.");
            return;
        }

        try {
            User user = authService.login(username, password);
            if (user != null) {
                // Navigate to main application
                App.setRoot("main_layout");
            } else {
                showError("Nom d'utilisateur ou mot de passe invalide.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            showError("Erreur lors de la connexion. Veuillez réessayer.");
        }
    }

    @FXML
    private void goToRegister() throws IOException {
        App.setRoot("register");
    }

    private void showError(String message) {
        if (errorLabel != null) {
            errorLabel.setText("❌ " + message);
        }
    }
}
