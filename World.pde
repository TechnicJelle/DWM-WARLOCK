Integer amountOfChickensToSpawn;
Integer amountOfChickensSaved;
Fox fox;
ArrayList<PVector> corpses;

void drawBackground(PGraphics canvas) {
  canvas.beginDraw();
  canvas.background(BLACK);
  for (int clumps = 0; clumps < 200; clumps++) {
    PVector clumpPos = new PVector(random(0, canvas.width), random(0, canvas.height));
    for (int blade = 0; blade < random(2, 3); blade++) {
      PVector bladeDir = PVector.fromAngle(PI + HALF_PI + random(-QUARTER_PI, QUARTER_PI)); // random angle like:  \|/
      bladeDir.mult(random(5, 10)); //length of the blade
      PVector bladeEnd = PVector.add(clumpPos, bladeDir);
      canvas.stroke(GREEN);
      canvas.strokeWeight(1);
      canvas.line(clumpPos.x + random(-1, 1), clumpPos.y, bladeEnd.x, bladeEnd.y);
    }
  }
  canvas.endDraw();
}

class World implements Scene {
  int Width;
  int Height;
  float sizeModifier = 1080.0f/1080.0f;

  PGraphics background;
  PGraphics canvas;

  ArrayList<Chicken> chickens;


  ArrayList<InWorldPopup> popups;

  World() {
    Width = displayWidth;
    Height = displayHeight;
    canvas = createGraphics(Width, Height);
    background = createGraphics(Width, Height);
    drawBackground(background);

    sizeModifier = float(Height)/1080.0f;

    amountOfChickensToSpawn = 20;

    PVector worldSize = new PVector(Width, Height);
    chickens = new ArrayList<Chicken>();
    for (int i = 0; i < amountOfChickensToSpawn; i++) {
      PVector pos = new PVector(random(Width), random(Height));
      chickens.add(new Chicken(worldSize, pos, random(3, 6.5f)*sizeModifier));
    }

    popups = new ArrayList<InWorldPopup>();
    corpses = new ArrayList<PVector>();

    amountOfChickensSaved = 0;
  }

  void init() {
  }

  void spawnFox() {
    PVector worldSize = new PVector(Width, Height);
    PVector pos = new PVector(random(Width), random(Height));
    fox = new Fox(worldSize, pos, 8*sizeModifier, chickens);
  }

  void attemptCatchChickenAt(PVector pos) {
    sfxNet.play();
    for (int i = chickens.size()-1; i >= 0; i--) {
      Chicken c = chickens.get(i);
      if (pos.dist(c.pos) < 32) {
        chickens.remove(i);
        popups.add(new InWorldPopup(c.pos, "Caught!", 2));
        amountOfChickensSaved++;
        return;
      }
    }
  }

  boolean attemptShootFoxAt(PVector pos) {
    sfxGun.play();
    if (pos.dist(fox.pos) < 32) {
      int chickensSavedScore = round(amountOfChickensSaved * 500);
      scores.put("Chickens Saved (" + amountOfChickensSaved + "/" + amountOfChickensToSpawn + ")", chickensSavedScore);
      int timePenalty = round(-10 * timeSinceSaveStart);
      scores.put("Time Penalty", timePenalty);
      millisAtFoxDeath = millis();

      fox.state = FoxState.DEAD;
      return true;
    }
    return false;
  }

  void update() {
    for (Chicken chicken : chickens) {
      chicken.update();
    }

    if (fox != null)
      fox.update();

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

    if (fox != null)
      fox.render(canvas);

    for (InWorldPopup popup : popups) {
      popup.render(canvas);
    }

    for (PVector corpse : corpses) {
      canvas.image(grChickenDead, corpse.x, corpse.y);
    }

    //<-- Draw stuff in the world here (on the canvas)
    canvas.endDraw();
  }

  void cleanup() {
    amountOfChickensToSpawn = null;
    amountOfChickensSaved = null;
    fox = null;
    corpses.clear();
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
