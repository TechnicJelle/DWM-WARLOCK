class Scene_MainMenu implements Scene {
  void init() {
  }

  void update() {
  }

  void render() {
    fill(WHITE);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("DWM_WARLOCK", width/2f, height*0.2);

    textSize(32);
    fill(WHITE);
    text("Click anywhere to start...", width/2f, height*0.6);
  }

  void mousePressed() {
    gameState.nextScene();
  }
  
  void mouseDragged() {
  }
  
  void mouseReleased() {
  }

  void cleanup() {
  }
}
