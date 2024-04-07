class Scene_MainMenu implements Scene {
  PGraphics background;

  void init() {
    background = createGraphics(width, height);
    drawBackground(background);
  }

  void update() {
  }

  void render() {
    image(background, 0, 0);
    textAlign(CENTER, CENTER);
    image(grLogo, (width-grLogo.width)/2, height*0.3);
    textSize(32);
    fill(WHITE);
    text("Click anywhere to start...", width/2f, height*0.6);

    image(grChicken, 269, 123);
    image(grChicken, 1194, 650);
    image(grChicken, 40, 627);
    image(grChicken, 815, 598);
    image(grChicken, 1041, 527);
    image(grChicken, 1099, 159);
    image(grChicken, 80, 316);
    image(grChicken, 230, 476);
    image(grChicken, 864, 195);
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
