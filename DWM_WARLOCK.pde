GameState gameState;

void setup() {
  size(1280, 720);
  gameState = new GameState(1,
    new Scene_Startup(),
    new Scene_MainMenu(),
    new Scene_InGame(),
    new Scene_Score()
    );
}

void draw() {
  background(0);
  gameState.updateCurrentScene();
  gameState.renderCurrentScene();
}

void mouseClicked() {
  gameState.mouseClickedCurrentScene();
}
