package com.app.controller;

import com.app.App;
import com.app.model.Course;
import com.app.model.Quiz;
import com.app.roomquiz.Room;
import com.app.roomquiz.RoomManager;
import com.app.service.AuthenticationService;
import com.app.service.CourseService;
import com.app.service.QuizService;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import java.io.IOException;
import java.util.List;

public class RoomController {

    @FXML
    private Label roomNameLabel;
    @FXML
    private Label roomIdLabel;
    @FXML
    private Label statusLabel;
    @FXML
    private ListView<String> playerListView;
    @FXML
    private Button startButton;

    private Room room;
    private final RoomManager roomManager = RoomManager.getInstance();
    private final QuizService quizService = new QuizService();
    private final CourseService courseService = new CourseService(); // Add missing import if needed or use simple logic
    private StackPane contentArea;

    public void setContentArea(StackPane contentArea) {
        this.contentArea = contentArea;
    }

    public void setRoom(Room room) {
        this.room = room;
        updateUI();
        setupNetworkListener();
        // Poller is no longer needed with Sockets!
    }

    private void setupNetworkListener() {
        com.app.network.NetworkManager.getInstance().getClient().setMessageHandler(msg -> {
            Platform.runLater(() -> {
                System.out.println("📺 Room received msg: " + msg.getType());
                if ("JOIN".equals(msg.getType())) {
                    // Refresh room data from DB (simplest way to sync state)
                    refreshRoomData();
                } else if ("START".equals(msg.getType())) {
                    // Remote start triggered!
                    // Content is quiz ID
                    try {
                        int quizId = Integer.parseInt(msg.getContent().replace("\"", ""));
                        navigateToQuiz(quizId);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else if ("CLOSE_ROOM".equals(msg.getType())) {
                    // Host has left, room is closed for everyone
                    javafx.scene.control.Alert alert = new javafx.scene.control.Alert(
                            javafx.scene.control.Alert.AlertType.INFORMATION);
                    alert.setTitle("Salle fermée");
                    alert.setHeaderText(null);
                    alert.setContentText("L'hôte a quitté la salle. Vous allez être redirigé vers le lobby.");
                    alert.show();
                    goBackToLobby();
                }
            });
        });
    }

    @FXML
    public void refreshRoomData() {
        // Fetch fresh room state from DB
        Room updated = roomManager.getRoom(room.getRoomId());
        if (updated != null) {
            this.room = updated;
            updateUI();
        } else {
            // Room no longer exists in DB
            goBackToLobby();
        }
    }

    private void updateUI() {
        roomNameLabel.setText(room.getRoomName());
        roomIdLabel.setText("Room ID: " + room.getRoomId());
        statusLabel.setText("Status: " + room.getStatus());

        playerListView.getItems().clear();
        room.getPlayers().values().forEach(p -> {
            String role = p.getUserId().equals(room.getHostUserId()) ? " (Host)" : "";
            playerListView.getItems().add(p.getUsername() + role);
        });

        // Only host can start
        String myId = String.valueOf(AuthenticationService.getCurrentUser().getId());
        startButton.setVisible(myId.equals(room.getHostUserId()));
    }

    @FXML
    private void leaveRoom() {
        String myId = String.valueOf(AuthenticationService.getCurrentUser().getId());

        // If I am the host, notify others to close the room
        if (myId.equals(room.getHostUserId())) {
            com.app.network.NetworkManager.getInstance().sendMessage("CLOSE_ROOM", room.getRoomName(),
                    room.getRoomId());
        }

        roomManager.leaveRoom(room.getRoomId(), myId);
        goBackToLobby();
    }

    private void goBackToLobby() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/multiplayer_menu.fxml"));
            VBox view = loader.load();
            MultiplayerMenuController controller = loader.getController();
            controller.setContentArea(contentArea);

            contentArea.getChildren().clear();
            contentArea.getChildren().add(view);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @FXML
    private void startGame() {
        try {
            // Find course matching room language (using tag or partial title)
            List<Course> courses = new CourseService().getAllCourses();
            Course targetCourse = null;
            String roomLang = room.getLanguage().toLowerCase();

            for (Course c : courses) {
                String courseTag = c.getLanguageTag() != null ? c.getLanguageTag().toLowerCase() : "";
                String courseTitle = c.getTitle().toLowerCase();

                if (courseTag.equals(roomLang) ||
                        courseTitle.contains(roomLang) ||
                        roomLang.contains(courseTag)) {
                    targetCourse = c;
                    break;
                }
            }

            if (targetCourse == null) {
                if (courses.isEmpty()) {
                    Alert a = new Alert(Alert.AlertType.ERROR, "Aucun cours disponible dans la base de données.");
                    a.show();
                    return;
                }
                targetCourse = courses.get(0);
                System.out
                        .println("⚠️ No exact match for " + roomLang + ", using fallback: " + targetCourse.getTitle());
            }

            List<Quiz> quizzes = quizService.getQuizzesForCourse(targetCourse.getId());
            if (quizzes.isEmpty()) {
                Alert a = new Alert(Alert.AlertType.ERROR,
                        "Aucun quiz trouvé pour le cours: " + targetCourse.getTitle());
                a.show();
                return;
            }

            // Select quiz based on difficulty string matching the title (e.g. " -
            // Débutant")
            String difficulty = room.getDifficulty();
            Quiz selectedQuiz = null;

            for (Quiz q : quizzes) {
                if (q.getTitle() != null && q.getTitle().contains(difficulty)) {
                    selectedQuiz = q;
                    break;
                }
            }

            // Fallback if no specific level found
            if (selectedQuiz == null) {
                selectedQuiz = quizzes.get(0);
            }

            roomManager.startQuiz(room.getRoomId(), selectedQuiz);

            // Notify everyone to start with the specific quiz ID
            com.app.network.NetworkManager.getInstance().sendMessage("START", room.getRoomName(), selectedQuiz.getId());

            // Navigate self
            navigateToQuiz(selectedQuiz.getId());

        } catch (Exception e) {
            e.printStackTrace();
            Alert a = new Alert(Alert.AlertType.ERROR, "Failed to start game: " + e.getMessage());
            a.show();
        }
    }

    private void navigateToQuiz(int quizId) {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("/view/quiz_view.fxml"));
            BorderPane quizView = loader.load();
            QuizController controller = loader.getController();

            // Set difficulty from room state
            controller.setContentArea(contentArea);
            controller.setRoom(this.room);
            controller.loadQuiz(quizId);
            controller.setInitialDifficulty(room.getDifficulty());

            contentArea.getChildren().clear();
            contentArea.getChildren().add(quizView);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
