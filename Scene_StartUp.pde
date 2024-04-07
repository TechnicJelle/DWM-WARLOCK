class Scene_Startup implements Scene {
  float textSize = 48;
  float textEnlargeSpeed = 0.5f;
  float startupTime = 5000; //in millis
  
  Scene_Startup() {
  }

  void init() {
    //textSize = 48;
    //textEnlargeSpeed = 0.5f;
    startupTime = 6000; //in millis
  }

  void update() {
    //textSize += 0.5f;
    if (millis() > startupTime) {
      gameState.nextScene();
    }
  }

  void render() {
    MEGAHARD.disableStyle();
    MOTTO.disableStyle();
    fill(WHITE);
    shape(MEGAHARD,(width-MEGAHARD.width)/2-20,height*0.3);
    shape(MOTTO,(width-MOTTO.width)/2-20,height*0.45);
    noFill();
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
