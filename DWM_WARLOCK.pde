WindowDragger windowDragger;
GameState gameState;

final int WIDTH = 1280;
final int HEIGHT = 720;
void settings() {
  size(WIDTH, HEIGHT);
}

//move these animals to World class later
ArrayList<Chicken> cs;
Fox f;

void setup() {
  //Set the start position of the window here (in screen pixels)
  windowDragger = new WindowDragger(displayWidth/2 - width/2, displayHeight/2 - height/2);

  gameState = new GameState(1,
    new Scene_Startup(),
    new Scene_MainMenu(),
    new Scene_InGame(),
    new Scene_Score()
    );

  //move this setup to World class later
  cs = new ArrayList<Chicken>();
  for (int i=0; i < 10; i++) {
    cs.add(new Chicken(new PVector(random(width), random(height)), random(5, 10)));
  }
  f = new Fox(new PVector(width, height), 10, cs);
}

void draw() {
  background(BLACK);
  gameState.updateCurrentScene();
  gameState.renderCurrentScene();
  windowDragger.applyWindowPos();

  //move this rendering and updating to World class later
  for (Chicken c : cs) {
    c.update();
    c.render();
  }

  f.update();
  f.render();
}

void mousePressed() {
  gameState.mousePressedCurrentScene();
}

void mouseDragged() {
  gameState.mouseDraggedCurrentScene();
}

void mouseReleased() {
  gameState.mouseReleasedCurrentScene();
}

void drawDebugDot(PVector v) {
  drawDebugDot(v.x, v.y);
}

void drawDebugDot(float x, float y) {
  push();
  stroke(255, 0, 0);
  strokeWeight(5);
  point(x, y);
  pop();
}

void drawDebugDot(PGraphics pg, PVector v) {
  drawDebugDot(pg, v.x, v.y);
}

void drawDebugDot(PGraphics pg, float x, float y) {
  pg.push();
  pg.stroke(255, 0, 0);
  pg.strokeWeight(5);
  pg.point(x, y);
  pg.pop();
}
