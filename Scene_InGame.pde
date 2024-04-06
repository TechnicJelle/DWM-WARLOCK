Integer score;
Float timeSinceSceneStart;

class Scene_InGame implements Scene {
  PVector windowStartedPos;
  int startMillis;
  boolean windowHasNotBeenMovedYet;
  PVector mouseDownPos;
  World world;

  boolean netIsDown;

  void init() {
    score = 0;
    timeSinceSceneStart = 0f;

    getSurface().setAlwaysOnTop(false);

    statsWindow.getSurface().setVisible(true);
    statsWindow.getSurface().setAlwaysOnTop(true);

    statsWindow.getSurface().setLocation(displayWidth - statsWindow.width - 20, displayHeight - statsWindow.height - 50);

    world = new World();

    sizeToResizeTo = new PVector(400, 400);

    windowDragger.setWindowPos(displayWidth/2 - int(sizeToResizeTo.x)/2, displayHeight/2 - int(sizeToResizeTo.y)/2);
    windowStartedPos = windowDragger.getWinPos();
    windowHasNotBeenMovedYet = true;
    mouseDownPos = windowDragger.getScreenMouse();
    startMillis = millis();

    netIsDown = false;
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
    } else {
      if (netIsDown) {
        //////////////////NET TEST
        pushMatrix();
        translate(width/2-36, height/2-22);
        strokeWeight(1);
        noFill();
        scale(2);

        //net outline
        stroke(WHITE);
        beginShape();
        vertex(18, 0);
        vertex(16, 2);
        vertex(14, 6);
        vertex(13, 11);
        vertex(13, 12);
        vertex(14, 13);
        vertex(17, 14);
        vertex(21, 14);
        vertex(24, 13);
        vertex(25, 12);
        vertex(25, 11);
        vertex(24, 6);
        vertex(22, 2);
        vertex(20, 0);
        endShape(CLOSE);

        //netlines
        beginShape();
        vertex(17, 1);
        vertex(24, 8);
        vertex(18, 14);
        endShape();
        beginShape();
        vertex(21, 1);
        vertex(14, 8);
        vertex(20, 14);
        endShape();
        beginShape();
        vertex(15, 4);
        vertex(24, 13);
        endShape();
        beginShape();
        vertex(23, 4);
        vertex(14, 13);
        endShape();

        //hilt
        beginShape();
        vertex(12, 11);
        vertex(12, 13);
        vertex(14, 13);
        vertex(13, 11);
        endShape(CLOSE);

        //stick
        beginShape();
        vertex(0, 12);
        vertex(13, 12);
        endShape();

        popMatrix();
      } else {
        pushMatrix();
        translate(width/2-41, height/2-47);
        strokeWeight(1);
        noFill();
        scale(2);

        //netring
        stroke(WHITE);
        beginShape();
        vertex(10, 14);
        vertex(10, 16);
        vertex(11, 17);
        vertex(13, 17);
        vertex(16, 15);
        vertex(18, 13);
        vertex(20, 10);
        vertex(20, 8);
        vertex(19, 7);
        vertex(17, 7);
        vertex(14, 9);
        vertex(12, 11);
        endShape(CLOSE);

        //net outer
        beginShape();
        vertex(10, 16);
        vertex(8, 14);
        vertex(4, 9);
        vertex(1, 8);
        vertex(0, 5);
        vertex(1, 2);
        vertex(4, 0);
        vertex(9, 0);
        vertex(13, 1);
        vertex(19, 7);
        endShape();

        //net horizontal line #1
        beginShape();
        vertex(1, 3);
        vertex(15, 3);
        endShape();
        //net horizontal line #2
        beginShape();
        vertex(1, 7);
        vertex(17, 7);
        endShape();
        //net horizontal line #3
        beginShape();
        vertex(6, 11);
        vertex(12, 11);
        endShape();
        //net vertical line #1
        beginShape();
        vertex(4, 0);
        vertex(4, 9);
        endShape();
        //net vertical line #2
        beginShape();
        vertex(8, 0);
        vertex(8, 14);
        endShape();
        //net vertical line #3
        beginShape();
        vertex(12, 1);
        vertex(12, 11);
        endShape();
        //net vertical line #4
        beginShape();
        vertex(16, 4);
        vertex(16, 7);
        endShape();

        //hilt
        beginShape();
        vertex(9, 16);
        vertex(10, 17);
        vertex(11, 17);
        endShape();

        //stick
        beginShape();
        vertex(10, 15);
        vertex(1, 25);
        endShape();

        popMatrix();
      }
    }
  }

  void keyPressed() {
    if (key == ' ') {
      netIsDown = true;
      PVector screenSize = new PVector(width/2, height/2);
      world.attemptCatchChickenAt(windowDragger.getWinPos().add(screenSize));
    }
  }

  void keyReleased() {
    if (key == ' ') {
      netIsDown = false;
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
    sizeToResizeTo = new PVector(WIDTH, HEIGHT);
    timeSinceSceneStart = null;
  }
}
