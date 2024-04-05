class Scene_MainMenu implements Scene {
  void init() {
  }

  void update() {
  }

  void render() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("DWM_WARLOCK", width/2f, height*0.2);

    textSize(32);
    fill(128);
    text("Click anywhere to start...", width/2f, height*0.6);
  }

  void mouseClicked() {
    gameState.nextScene();
  }

  void cleanup() {
  }
}
