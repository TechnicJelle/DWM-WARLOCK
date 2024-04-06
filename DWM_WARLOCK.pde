WindowDragger windowDragger;
GameState gameState;
StatsWindow statsWindow;

final int WIDTH = 1280;
final int HEIGHT = 720;
void settings() {
  if (isWindows()) {
    size(WIDTH, HEIGHT, P2D);
  } else {
    size(WIDTH, HEIGHT);
  }
}

void setup() {
  //Set the start position of the window here (in screen pixels)
  windowDragger = new WindowDragger(displayWidth/2 - width/2, displayHeight/2 - height/2);

  gameState = new GameState(1,
    new Scene_Startup(),
    new Scene_MainMenu(),
    new Scene_InGame(),
    new Scene_Score()
    );

  runSketch(new String[]{this.getClass().getName()}, statsWindow = new StatsWindow());
  getSurface().setAlwaysOnTop(true);

  delay(10); //ensure the new sketch has started up enough to be able to be invisible'd
  statsWindow.getSurface().setVisible(false);
}

void draw() {
  background(BLACK);
  gameState.updateCurrentScene();
  gameState.renderCurrentScene();
  windowDragger.applyWindowPos();
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

boolean isWindows() {
  String os = System.getProperty("os.name").toLowerCase();
  return os.contains("windows");
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
