package com.app;

import com.app.util.DatabaseSetup;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class App extends Application {

    private static Scene scene;
    private static Stage primaryStage;

    @Override
    public void start(Stage stage) throws IOException {
        primaryStage = stage;

        DatabaseSetup.initializeDatabase();
        com.app.util.DatabaseSchema.initialize();

        scene = new Scene(loadFXML("login"));

        stage.setWidth(1280);
        stage.setHeight(800);
        stage.setMinWidth(1024);
        stage.setMinHeight(768);

        stage.setScene(scene);
        stage.setTitle("DevQuiz");

        stage.setOnCloseRequest(event -> {
            com.app.network.NetworkManager.getInstance().stopAll();
            System.exit(0);
        });

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
