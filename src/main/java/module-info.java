module com.app {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.web;
    requires java.sql;
    requires com.zaxxer.hikari;
    requires jbcrypt;

    opens com.app to javafx.fxml;
    opens com.app.controller to javafx.fxml;

    exports com.app;
    exports com.app.controller;
}
