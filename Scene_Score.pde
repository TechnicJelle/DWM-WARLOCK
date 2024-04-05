class Scene_Score implements Scene {
  void init() {
  }

  void update() {
  }

  void render() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Score:", width/2f, height*0.3);

    textSize(128);
    fill(255);
    text("1234", width/2f, height*0.5);

    textSize(32);
    fill(128);
    text("Click anywhere to go back to the main menu", width/2f, height*0.8);
  }

  void mouseClicked() {
    gameState.nextScene();
  }

  void cleanup() {
  }
}
