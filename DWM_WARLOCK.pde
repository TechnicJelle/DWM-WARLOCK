import processing.sound.*;

WindowDragger windowDragger;
GameState gameState;

PFont OCRA;
StatsWindow statsWindow;

PShape MEGAHARD;
PShape MOTTO;

PVector sizeToResizeTo;

Table highscores;

SoundFile sfxMenu;
SoundFile sfxTyped;
SoundFile sfxChicken;
SoundFile sfxNet;
SoundFile sfxGun;
SoundFile sfxScorePart;
SoundFile sfxScoreTotal;
SoundFile sfxHighscores;
SoundFile sfxHighscoresTop;

final int WIDTH = 1280;
final int HEIGHT = 720;
void settings() {
  if (isWindows()) {
    size(WIDTH, HEIGHT);
  } else {
    //fullScreen();
    size(WIDTH, HEIGHT);
  }
}

void setup() {
  OCRA = createFont("OCRA.ttf", 24);
  MEGAHARD = loadShape("MEGAHARD.svg");
  MOTTO = loadShape("MOTTO.svg");

  runSketch(new String[]{this.getClass().getName()}, statsWindow = new StatsWindow());
  getSurface().setAlwaysOnTop(true);

  textFont(OCRA);
  //Set the start position of the window here (in screen pixels)
  windowDragger = new WindowDragger(displayWidth/2 - width/2, displayHeight/2 - height/2);

  gameState = new GameState(1,
    new Scene_Startup(),
    new Scene_MainMenu(),
    new Scene_InGame(),
    new Scene_Score()
    );

  highscores = loadTable("data/highscores.csv", "header");
  highscores.setColumnType("score", Table.INT);
  highscores.trim();
  highscores.sortReverse("score");

  sfxMenu = new SoundFile(this, "sfx/menu.wav");
  sfxTyped = new SoundFile(this, "sfx/typed.wav");
  sfxChicken = new SoundFile(this, "sfx/chicken.wav");
  sfxNet = new SoundFile(this, "sfx/net.wav");
  sfxGun = new SoundFile(this, "sfx/gun.wav");
  sfxScorePart = new SoundFile(this, "sfx/score_part.wav");
  sfxScoreTotal = new SoundFile(this, "sfx/score_total.wav");
  sfxHighscores = new SoundFile(this, "sfx/highscores.wav");
  sfxHighscoresTop = new SoundFile(this, "sfx/highscores_top.wav");

  delay(10); //ensure the new sketch has started up enough to be able to be invisible'd
  statsWindow.getSurface().setVisible(false);
  setupGraphics();
}

void draw() {
  background(BLACK);
  gameState.updateCurrentScene();
  gameState.renderCurrentScene();
  if (sizeToResizeTo != null) {
    int x = int(sizeToResizeTo.x);
    int y = int(sizeToResizeTo.y);
    sizeToResizeTo = null;
    windowDragger.setWindowPos(displayWidth/2 - x/2, displayHeight/2 - y/2);
    windowResize(x, y);
    delay(100);
  }
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

void keyPressed() {
  gameState.keyPressedCurrentScene();
}

void keyReleased() {
  gameState.keyReleasedCurrentScene();
}

void exit() {
  saveTable(highscores, "data/highscores.csv");
  super.exit();
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
