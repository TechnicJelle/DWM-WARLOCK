class InWorldPopup {
  PVector pos;
  String text;
  float time;

  float size = 32;
  color colour = WHITE;

  float startMillis;
  boolean expired;
  int shakeStrength;
  PVector shakeOffset;
  int shakeSpeed;

  InWorldPopup(PVector pos, String text, float time) {
    this.pos = pos;
    this.text = text;
    this.time = time * 1000;

    startMillis = millis();
    expired = false;
    shakeStrength = 0;
    shakeOffset = new PVector(0, 0);
    shakeSpeed = 3; //the higher the number, the slower the shake. cannot go lower than 1.
  }

  void update() {
    expired = millis() - startMillis > time;
  }

  void render(PGraphics canvas) {
    canvas.textFont(OCRA);
    canvas.fill(colour);
    canvas.textSize(size);
    canvas.textAlign(CENTER, CENTER);
    if (shakeStrength != 0) {
      if (frameCount % shakeSpeed == 0) { //only every OTHER frame, not every frame
        shakeOffset.set(random(-shakeStrength, shakeStrength), random(-shakeStrength, shakeStrength));
      }
    }
    canvas.text(text, pos.x + shakeOffset.x, pos.y + shakeOffset.y);
  }
}
