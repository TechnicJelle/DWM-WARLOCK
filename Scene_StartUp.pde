class Scene_Startup implements Scene {
  float textSize = 48;
  float textEnlargeSpeed = 0.5f;
  float startupTime = 2000; //in millis

  void init() {
    textSize = 48;
    textEnlargeSpeed = 0.5f;
    startupTime = 2000; //in millis
  }

  void update() {
    textSize += 0.5f;
    if (millis() > startupTime) {
      gameState.nextScene();
    }
  }

  void render() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text("Megahard presents...", width/2f, height*0.5);
  }

  void mousePressed() {
    gameState.nextScene();
  }

  void mouseDragged() {
  }

  void mouseReleased() {
  }

  void keyPressed() {
  }

  void keyReleased() {
  }

  void cleanup() {
  }
}
