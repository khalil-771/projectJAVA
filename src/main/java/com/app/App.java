package com.app;

import com.app.util.DatabaseSetup;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * JavaFX App - Plateforme QCM
 */
public class App extends Application {

    private static Scene scene;
    private static Stage primaryStage;

    @Override
    public void start(Stage stage) throws IOException {
        primaryStage = stage;

        // Initialize database
        DatabaseSetup.initializeDatabase();

        scene = new Scene(loadFXML("login"));

        // Set window size for PC
        stage.setWidth(1280);
        stage.setHeight(800);
        stage.setMinWidth(1024);
        stage.setMinHeight(768);

        stage.setScene(scene);
        stage.setTitle("Plateforme QCM - E-Learning");
        stage.show();
    }

    public static void setRoot(String fxml) throws IOException {
        scene.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("/view/" + fxml + ".fxml"));
        return fxmlLoader.load();
    }

    public static Stage getPrimaryStage() {
        return primaryStage;
    }

    public static void main(String[] args) {
        launch();
    }
}
