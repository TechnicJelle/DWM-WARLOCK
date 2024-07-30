Integer score;
Float timeSinceSaveStart;
float millisAtFoxDeath;

enum PlayState {
  INTRO, SAVE, KILL, REMINICE
}

class Scene_InGame implements Scene {
  float timeSinceSceneStart;
  PVector windowStartedPos;
  int sceneStartMillis;
  boolean windowHasNotBeenMovedYet;
  PVector mouseDownPos;
  World world;

  PlayState playState;
  int saveStartMillis;

  boolean netIsDown;

  float baskSeconds = 5;

  void init() {
    score = 0;
    timeSinceSceneStart = 0f;

    playState = PlayState.INTRO;

    getSurface().setAlwaysOnTop(false);

    statsWindow.getSurface().setVisible(true);
    statsWindow.getSurface().setAlwaysOnTop(true);

    statsWindow.getSurface().setLocation(displayWidth - statsWindow.width - 20, displayHeight - statsWindow.height - 50);

    world = new World();

    sizeToResizeTo = new PVector(400, 400);

    windowDragger.setWindowPos(displayWidth/2 - int(sizeToResizeTo.x)/2, displayHeight/2 - int(sizeToResizeTo.y)/2);
    windowStartedPos = windowDragger.getWinPos();
    windowHasNotBeenMovedYet = true;
    sceneStartMillis = millis();

    netIsDown = false;
  }

  void update() {
    timeSinceSceneStart = (millis() - sceneStartMillis) / 1000f; //in seconds

    if (timeSinceSaveStart != null && (playState == PlayState.SAVE || playState == PlayState.KILL))
      timeSinceSaveStart = (millis() - saveStartMillis) / 1000f; //in seconds

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
  }

  void render() {
    world.render();
    PVector winPos = windowDragger.getWinPos();
    image(world.canvas, -winPos.x, -winPos.y);

    switch(playState) {
    case INTRO:
      if (!windowHasNotBeenMovedYet) {
        playState = PlayState.SAVE;
        timeSinceSaveStart = 0f;
        saveStartMillis = millis();
        world.spawnFox();
      }

      fill(WHITE);
      textSize(20);
      text("↑\nMove the window\n←  by clicking and dragging  →\nanywhere inside\n↓", width/2, height/2);

      textSize(16);
      text("Do not grab the window by the top bar!", width/2, height*0.9);
      break;
    case SAVE:
      if (netIsDown) {
        image(grNetDown, width/2-36, height/2-22);
      } else {
        image(grNetUp, width/2-41, height/2-47);
      }
      if (world.chickens.isEmpty()) {
        playState = PlayState.KILL;
      }
      break;
    case KILL:
      //recticle
      noFill();
      stroke(RED);
      strokeWeight(2);
      circle(width/2, height/2, netIsDown ? 16 : 22);
      line(width/2 - 5, height/2, width/2 - 17, height/2); //left
      line(width/2, height/2 - 5, width/2, height/2 - 17); //top
      line(width/2 + 5, height/2, width/2 + 17, height/2); //right
      line(width/2, height/2 + 5, width/2, height/2 + 17); //bottom

      if (netIsDown) {
        image(grGunFire, width-130, height-190);
      } else {
        image(grGunRest, width-150, height-150);
      }
      break;
    case REMINICE:
      float timeSinceFoxDeath = millis() - millisAtFoxDeath;
      if (timeSinceFoxDeath >= baskSeconds*1000) {
        gameState.nextScene();
      }
    }
  }

  void keyPressed() {
    if (key == ' ' && !netIsDown) {
      netIsDown = true;
      PVector screenSize = new PVector(width/2, height/2);
      PVector screenCenter = windowDragger.getWinPos().add(screenSize);
      switch(playState) {
      case INTRO:
        break;
      case SAVE:
        world.attemptCatchChickenAt(screenCenter);
        break;
      case KILL:
        boolean foxWasShotDead = world.attemptShootFoxAt(screenCenter);
        if (foxWasShotDead) {
          playState = PlayState.REMINICE;
          InWorldPopup popup = new InWorldPopup(PVector.add(fox.pos, new PVector(0, -20)), "Bask in your violence", baskSeconds);
          popup.colour = RED;
          popup.size = 16;
          popup.shakeStrength = 2;
          world.popups.add(popup);
        }
        break;
      case REMINICE:
        break;
      }
    }
  }

  void keyReleased() {
    if (key == ' ') {
      netIsDown = false;
    }
  }

  void mousePressed() {
    //if (mouseButton == RIGHT) {
    //  gameState.nextScene();
    //}

    mouseDownPos = windowDragger.getScreenMouse();
  }

  void mouseDragged() {
    if (mouseDownPos == null) return;
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
    sizeToResizeTo = new PVector(WIDTH, HEIGHT);
    timeSinceSaveStart = null;
  }
}
