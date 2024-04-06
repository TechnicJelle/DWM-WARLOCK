class StatsWindow extends PApplet {
  void settings() {
    size(128, 128);
  }

  void setup() {
    removeExitEvent(getSurface());
    windowTitle("Stats");

    frameRate(1);
    stroke(#FFFF00);
    strokeWeight(5);
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    fill(255);

    if (chickensAlive != null) {
      textSize(16);
      text("Chickens Alive:", width/2, height*0.15);
      textSize(32);
      text(chickensAlive, width/2, height * 0.35);
    }

    if (timeSinceSceneStart != null) {
      textSize(16);
      text("Time Spent:", width/2, height*0.6);
      textSize(32);
      text(timeSinceSceneStart, width/2, height * 0.8);
    }
  }

  @Override void exit() {
  }
}

static final void removeExitEvent(final PSurface surf) {
  final java.awt.Window win = ((processing.awt.PSurfaceAWT.SmoothCanvas) surf.getNative()).getFrame();

  for (final java.awt.event.WindowListener evt : win.getWindowListeners())
    win.removeWindowListener(evt);
}
