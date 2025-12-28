module com.app {
    requires transitive javafx.graphics;
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.web;
    requires java.sql;
    requires com.zaxxer.hikari;
    requires jbcrypt;
    requires com.fasterxml.jackson.databind;
    requires com.fasterxml.jackson.core;
    requires com.fasterxml.jackson.annotation;

    opens com.app to javafx.fxml;
    opens com.app.controller to javafx.fxml;
    opens com.app.model to javafx.base;
    opens com.app.roomquiz to com.fasterxml.jackson.databind;

    exports com.app;
    exports com.app.controller;
    exports com.app.network;
    exports com.app.roomquiz;
}
