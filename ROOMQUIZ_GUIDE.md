# 🎮 RoomQuiz Multiplayer - Implementation Guide

## Overview
RoomQuiz is the multiplayer battle mode where players compete in real-time quiz battles.

---

## ✅ What's Implemented (Foundation)

### Core Classes
- ✅ `Room.java` - Room management with player tracking
- ✅ `RoomManager.java` - Singleton for managing all rooms
- ✅ `Player.java` - Player representation
- ✅ Room statuses: WAITING, STARTING, IN_PROGRESS, FINISHED

### Features
- ✅ Create/Join/Leave rooms
- ✅ Player management (max players, host)
- ✅ Real-time scoring
- ✅ Leaderboard during quiz
- ✅ Room cleanup

---

## 🚧 What's Needed (To Complete)

### 1. WebSocket Server (Spring Boot)

**Create new project**: `roomquiz-server`

```xml
<!-- pom.xml -->
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-websocket</artifactId>
    </dependency>
</dependencies>
```

**WebSocket Configuration**:
```java
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic");
        config.setApplicationDestinationPrefixes("/app");
    }
    
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/roomquiz").withSockJS();
    }
}
```

**Room Controller**:
```java
@Controller
public class RoomController {
    
    @MessageMapping("/room/create")
    @SendTo("/topic/rooms")
    public Room createRoom(RoomRequest request) {
        return roomManager.createRoom(request.getName(), 
                                     request.getHostId(), 
                                     request.getMaxPlayers());
    }
    
    @MessageMapping("/room/join")
    @SendTo("/topic/room/{roomId}")
    public JoinResponse joinRoom(JoinRequest request) {
        // Handle join logic
    }
    
    @MessageMapping("/quiz/answer")
    @SendTo("/topic/room/{roomId}/scores")
    public ScoreUpdate submitAnswer(AnswerSubmission submission) {
        // Handle answer submission
        // Update scores
        // Broadcast to all players
    }
}
```

### 2. JavaFX WebSocket Client

**Add dependency**:
```xml
<dependency>
    <groupId>org.java-websocket</groupId>
    <artifactId>Java-WebSocket</artifactId>
    <version>1.5.3</version>
</dependency>
```

**WebSocket Client**:
```java
public class RoomQuizClient extends WebSocketClient {
    
    public RoomQuizClient(URI serverUri) {
        super(serverUri);
    }
    
    @Override
    public void onMessage(String message) {
        // Handle incoming messages
        // Update UI
    }
    
    public void createRoom(String roomName, int maxPlayers) {
        send(json("CREATE_ROOM", roomName, maxPlayers));
    }
    
    public void joinRoom(String roomId) {
        send(json("JOIN_ROOM", roomId));
    }
    
    public void submitAnswer(int questionId, List<Integer> answerIds) {
        send(json("SUBMIT_ANSWER", questionId, answerIds));
    }
}
```

### 3. Room Lobby UI

**RoomLobbyController.java**:
```java
public class RoomLobbyController {
    
    @FXML
    private ListView<Room> roomListView;
    @FXML
    private Button createRoomButton;
    @FXML
    private Button joinRoomButton;
    
    private RoomQuizClient client;
    
    public void initialize() {
        connectToServer();
        loadAvailableRooms();
    }
    
    private void connectToServer() {
        try {
            client = new RoomQuizClient(new URI("ws://localhost:8080/roomquiz"));
            client.connect();
        } catch (Exception e) {
            showError("Failed to connect to server");
        }
    }
    
    @FXML
    private void createRoom() {
        // Show create room dialog
        // Send create request to server
    }
    
    @FXML
    private void joinRoom() {
        Room selected = roomListView.getSelectionModel().getSelectedItem();
        if (selected != null) {
            client.joinRoom(selected.getRoomId());
        }
    }
}
```

### 4. Battle UI

**BattleController.java**:
```java
public class BattleController {
    
    @FXML
    private Label questionLabel;
    @FXML
    private VBox answersContainer;
    @FXML
    private TableView<PlayerScore> leaderboardTable;
    @FXML
    private Label timerLabel;
    
    private RoomQuizClient client;
    private Timeline questionTimer;
    
    public void displayQuestion(Question question) {
        questionLabel.setText(question.getText());
        displayAnswers(question.getAnswers());
        startTimer(30); // 30 seconds per question
    }
    
    @FXML
    private void submitAnswer() {
        List<Integer> selectedAnswers = collectAnswers();
        client.submitAnswer(currentQuestion.getId(), selectedAnswers);
    }
    
    public void updateLeaderboard(List<PlayerScore> scores) {
        Platform.runLater(() -> {
            leaderboardTable.setItems(FXCollections.observableArrayList(scores));
        });
    }
}
```

---

## 📋 Implementation Steps

### Phase 1: Server Setup (2-3 days)
1. Create Spring Boot project
2. Configure WebSocket
3. Implement Room endpoints
4. Test with Postman/WebSocket client

### Phase 2: Client Integration (2-3 days)
5. Add WebSocket dependency
6. Create RoomQuizClient
7. Test connection
8. Implement message handling

### Phase 3: UI Development (3-4 days)
9. Create room_lobby.fxml
10. Create battle.fxml
11. Implement controllers
12. Add animations

### Phase 4: Testing & Polish (2-3 days)
13. Test with multiple clients
14. Handle disconnections
15. Add error handling
16. Polish UI

**Total Estimate**: 9-13 days

---

## 🎯 Message Protocol

### Client → Server

**Create Room**:
```json
{
  "type": "CREATE_ROOM",
  "roomName": "Epic Battle",
  "maxPlayers": 4,
  "userId": "user123",
  "username": "Player1"
}
```

**Join Room**:
```json
{
  "type": "JOIN_ROOM",
  "roomId": "abc123",
  "userId": "user456",
  "username": "Player2"
}
```

**Submit Answer**:
```json
{
  "type": "SUBMIT_ANSWER",
  "roomId": "abc123",
  "questionId": 42,
  "answerIds": [1, 3],
  "userId": "user123"
}
```

### Server → Client

**Room List Update**:
```json
{
  "type": "ROOM_LIST",
  "rooms": [
    {
      "roomId": "abc123",
      "roomName": "Epic Battle",
      "players": 2,
      "maxPlayers": 4,
      "status": "WAITING"
    }
  ]
}
```

**Question Broadcast**:
```json
{
  "type": "QUESTION",
  "questionId": 42,
  "questionText": "What is Java?",
  "answers": [
    {"id": 1, "text": "A programming language"},
    {"id": 2, "text": "A coffee brand"}
  ],
  "timeLimit": 30
}
```

**Score Update**:
```json
{
  "type": "SCORE_UPDATE",
  "scores": [
    {"userId": "user123", "username": "Player1", "score": 30},
    {"userId": "user456", "username": "Player2", "score": 20}
  ]
}
```

---

## 🚀 Quick Start (When Implemented)

### Server
```bash
cd roomquiz-server
mvn spring-boot:run
```

### Client
1. Click "🎮 Multiplayer" in main menu
2. See available rooms
3. Create room or join existing
4. Wait for players
5. Host starts quiz
6. Compete in real-time!

---

## 📊 Current Status

✅ **Foundation Ready** (Room, RoomManager classes)  
⚠️ **Server Not Implemented** (Spring Boot WebSocket)  
⚠️ **Client Not Implemented** (JavaFX WebSocket)  
⚠️ **UI Not Implemented** (Lobby, Battle screens)  

**Estimated Completion**: 9-13 days of development

---

## 💡 Alternative: Local Multiplayer

For faster implementation, consider **local multiplayer** (same computer):

```java
// Two players on same machine
public class LocalMultiplayerController {
    private Player player1;
    private Player player2;
    
    // Split screen or turn-based
}
```

This can be done in **1-2 days** vs 9-13 days for full WebSocket implementation.

---

**Foundation is ready! Choose your path:**
- 🌐 Full WebSocket multiplayer (9-13 days)
- 💻 Local multiplayer (1-2 days)
- ⏸️ Skip for now (focus on other features)
