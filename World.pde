class World {
  int Width = -1;
  int Height = -1;

  PGraphics background;
  PGraphics canvas;

  ArrayList<Chicken> chickens;
  int amountOfChickensToSpawn = 10;
  Fox fox;

  World() {
    Width = displayWidth;
    Height = displayHeight;
    canvas = createGraphics(Width, Height);
    background = createGraphics(Width, Height);
    drawBackground();

    PVector worldSize = new PVector(Width, Height);
    chickens = new ArrayList<Chicken>();
    for (int i = 0; i < amountOfChickensToSpawn; i++) {
      PVector pos = new PVector(random(Width), random(Height));
      chickens.add(new Chicken(worldSize, pos, random(5, 10)));
    }
    PVector pos = new PVector(random(Width), random(Height));
    fox = new Fox(worldSize, pos, 10, chickens);
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

  void render() {
    canvas.beginDraw();
    canvas.image(background, 0, 0);
    //Draw stuff in the world here (on the canvas) -->

    //move this rendering and updating to World class later
    for (Chicken chicken : chickens) {
      chicken.update();
      chicken.render(canvas);
    }

    fox.update();
    fox.render(canvas);

    //<-- Draw stuff in the world here (on the canvas)
    canvas.endDraw();
  }
}
