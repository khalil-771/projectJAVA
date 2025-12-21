package com.app.controller;

import javafx.fxml.FXML;
import javafx.scene.control.TextArea;
import javafx.scene.web.WebView;
import javafx.scene.control.Alert;

public class CodeEditorController {

    @FXML
    private TextArea codeArea;
    @FXML
    private WebView outputWebView;

    public void setInitialCode(String code) {
        // Handle common HTML entities or simple strings
        if (code != null) {
            codeArea.setText(code);
            runCode();
        }
    }

    @FXML
    public void runCode() {
        String content = codeArea.getText();
        if (content == null)
            content = "";

        // Basic safety check (optional, heavily simplified)
        // In a real desktop app, we might want to sandbox this,
        // but for a tutorial app, processing plain HTML/JS in WebView is standard.

        outputWebView.getEngine().loadContent(content);
    }

    @FXML
    public void saveSnippet() {
        // Placeholder for saving snippet to DB
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle("Save Code");
        alert.setHeaderText(null);
        alert.setContentText("Feature coming soon: Save your code snippets!");
        alert.showAndWait();
    }
}
