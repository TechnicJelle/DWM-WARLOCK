class Scene_InGame implements Scene {
  PVector windowStartedPos;
  int startMillis;
  boolean windowHasNotBeenMovedYet;
  PVector mouseDownPos;
  World world;

  void init() {
    world = new World();
    windowResize(700, 700);
    windowDragger.centerWindow();
    windowStartedPos = windowDragger.getWinPos();
    windowHasNotBeenMovedYet = true;
    mouseDownPos = windowDragger.getScreenMouse();
    startMillis = millis();
  }

  void update() {
    //Wiggle the window if it hasn't been moved yet, to show the user they can move it themselves.
    if (windowHasNotBeenMovedYet) {
      //designer values:
      float frequency = 9.51; //how ADHD it is
      float decay = 2.34; //damping (how fast it decays)
      float period = 3; //repeats every {period} seconds
      float bounceMagnitude = 40.80; //amount of pixels it shakes
      int cycleCutoff = 3; //after how many swings (left + right) it stops

      //calculations:
      float timeSinceSceneStart = (millis() - startMillis) / 1000f; //in seconds
      timeSinceSceneStart += + period/2f; //make the animation start at a rest point, instead of immediately starting with a bounce
      float repeater = timeSinceSceneStart % period;
      float offset = bounceMagnitude * exp(-decay * repeater) * sin(frequency * repeater);
      float threshold = (timeSinceSceneStart % period) - ((cycleCutoff * PI) / frequency);
      if (threshold > 0) offset = 0;

      //move the window:
      windowDragger.setWindowPos(int(windowStartedPos.x + offset), int(windowStartedPos.y));
    } else {
      windowDragger.clickDragWindow();
    }
  }

  void render() {
    world.render();
    PVector winPos = windowDragger.getWinPos();
    image(world.canvas, -winPos.x, -winPos.y);

    if (windowHasNotBeenMovedYet) {
      fill(WHITE);
      textSize(32);
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
    windowResize(WIDTH, HEIGHT);
    windowDragger.centerWindow();
  }
}
