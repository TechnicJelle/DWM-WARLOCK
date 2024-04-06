class World {
  int Width = -1;
  int Height = -1;

  PGraphics background;
  PGraphics canvas;

  World() {
    Width = displayWidth;
    Height = displayHeight;
    canvas = createGraphics(Width, Height);
    background = createGraphics(Width, Height);

    background.beginDraw();
    background.background(0);
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


    //<-- Draw stuff in the world here (on the canvas)
    canvas.endDraw();
  }
}
