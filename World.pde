Integer chickensAlive;

class World implements Scene {
  int Width;
  int Height;

  PGraphics background;
  PGraphics canvas;

  ArrayList<Chicken> chickens;
  int amountOfChickensToSpawn;
  Fox fox;

  ArrayList<InWorldPopup> popups;

  World() {
    Width = displayWidth;
    Height = displayHeight;
    canvas = createGraphics(Width, Height);
    background = createGraphics(Width, Height);
    drawBackground();

    amountOfChickensToSpawn = int(random(10, 20));
    chickensAlive = amountOfChickensToSpawn;

    PVector worldSize = new PVector(Width, Height);
    chickens = new ArrayList<Chicken>();
    for (int i = 0; i < amountOfChickensToSpawn; i++) {
      PVector pos = new PVector(random(Width), random(Height));
      chickens.add(new Chicken(worldSize, pos, random(5, 10)));
    }
    PVector pos = new PVector(random(Width), random(Height));
    fox = new Fox(worldSize, pos, 10, chickens);

    popups = new ArrayList<InWorldPopup>();
  }

  void init() {
  }

  void drawBackground() {
    background.beginDraw();
    background.background(BLACK);
    for (int clumps = 0; clumps < 200; clumps++) {
      PVector clumpPos = new PVector(random(0, Width), random(0, Height));
      for (int blade = 0; blade < random(2, 3); blade++) {
        PVector bladeDir = PVector.fromAngle(PI + HALF_PI + random(-QUARTER_PI, QUARTER_PI)); // random angle like:  \|/
        bladeDir.mult(random(5, 10)); //length of the blade
        PVector bladeEnd = PVector.add(clumpPos, bladeDir);
        background.stroke(GREEN);
        background.strokeWeight(1);
        background.line(clumpPos.x + random(-1, 1), clumpPos.y, bladeEnd.x, bladeEnd.y);
      }
    }
    background.endDraw();
  }

  void attemptCatchChickenAt(PVector pos) {
    for (int i = chickens.size()-1; i >= 0; i--) {
      Chicken c = chickens.get(i);
      if (pos.dist(c.pos) < 32) {
        chickens.remove(i);
        popups.add(new InWorldPopup(c.pos, "Caught!", 2));
        return;
      }
    }
  }


  void update() {
    for (Chicken chicken : chickens) {
      chicken.update();
    }

    fox.update();

    chickensAlive = chickens.size();

    for (int i = popups.size()-1; i >= 0; i--) {
      popups.get(i).update();
      if (popups.get(i).expired) {
        popups.remove(i);
      }
    }
  }


  void render() {
    canvas.beginDraw();
    canvas.image(background, 0, 0);
    //Draw stuff in the world here (on the canvas) -->

    for (Chicken chicken : chickens) {
      chicken.render(canvas);
    }

    fox.render(canvas);

    for (InWorldPopup popup : popups) {
      popup.render(canvas);
    }

    //<-- Draw stuff in the world here (on the canvas)
    canvas.endDraw();
  }

  void cleanup() {
    chickensAlive = null;
  }

  void mousePressed() {
  }

  void mouseDragged() {
  }

  void mouseReleased() {
  }

  void keyPressed() {
  }

  void keyReleased() {
  }
}
