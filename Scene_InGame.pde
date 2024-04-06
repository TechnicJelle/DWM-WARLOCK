Integer score;
Float timeSinceSceneStart;

class Scene_InGame implements Scene {
  PVector windowStartedPos;
  int startMillis;
  boolean windowHasNotBeenMovedYet;
  PVector mouseDownPos;
  World world;

  void init() {
    score = 0;
    timeSinceSceneStart = 0f;

    getSurface().setAlwaysOnTop(false);

    statsWindow.getSurface().setVisible(true);
    statsWindow.getSurface().setAlwaysOnTop(true);

    statsWindow.getSurface().setLocation(displayWidth - statsWindow.width - 20, displayHeight - statsWindow.height - 50);

    world = new World();

    windowResize(400, 400);
    delay(300);

    windowDragger.centerWindow();
    windowStartedPos = windowDragger.getWinPos();
    windowHasNotBeenMovedYet = true;
    mouseDownPos = windowDragger.getScreenMouse();
    startMillis = millis();
  }

  void update() {
    timeSinceSceneStart = (millis() - startMillis) / 1000f; //in seconds

    world.update();

    //Wiggle the window if it hasn't been moved yet, to show the user they can move it themselves.
    if (windowHasNotBeenMovedYet) {
      //designer values:
      float frequency = 9.51; //how ADHD it is
      float decay = 2.34; //damping (how fast it decays)
      float period = 3; //repeats every {period} seconds
      float bounceMagnitude = 40.80; //amount of pixels it shakes
      int cycleCutoff = 3; //after how many swings (left + right) it stops

      //calculations:
      float localTimeSinceSceneStart = timeSinceSceneStart + period/2f; //make the animation start at a rest point, instead of immediately starting with a bounce
      float repeater = localTimeSinceSceneStart % period;
      float offset = bounceMagnitude * exp(-decay * repeater) * sin(frequency * repeater);
      float threshold = (localTimeSinceSceneStart % period) - ((cycleCutoff * PI) / frequency);
      if (threshold > 0) offset = 0;

      //move the window:
      windowDragger.setWindowPos(int(windowStartedPos.x + offset), int(windowStartedPos.y));
    } else {
      windowDragger.clickDragWindow();
    }

    if (random(200) < 1) {
      score++;
      println("bumped score to ", score);
    }
  }

  void render() {
    world.render();
    PVector winPos = windowDragger.getWinPos();
    image(world.canvas, -winPos.x, -winPos.y);

    if (windowHasNotBeenMovedYet) {
      fill(WHITE);
      textSize(20);
      text("↑\nMove the window\n←  by clicking and dragging  →\nanywhere inside\n↓", width/2, height/2);

      textSize(16);
      text("Do not grab the window by the top bar!", width/2, height*0.9);
    }
  }

  void mousePressed() {
    if (mouseButton == RIGHT) {
      gameState.nextScene();
    }

    mouseDownPos = windowDragger.getScreenMouse();
  }

  void mouseDragged() {
    PVector mouseDragPos = windowDragger.getScreenMouse();
    if (windowHasNotBeenMovedYet && mouseDownPos.dist(mouseDragPos) > 50) {
      windowHasNotBeenMovedYet = false;
    }
  }

  void mouseReleased() {
  }

  void cleanup() {
    world.cleanup();
    statsWindow.getSurface().setVisible(false);
    windowResize(WIDTH, HEIGHT);
    if (!isWindows()) {
      delay(300);
    }
    windowDragger.centerWindow();
    timeSinceSceneStart = null;
  }
}
