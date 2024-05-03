class InWorldPopup {
  PVector pos;
  String text;
  float time;

  float size = 32;
  color colour = WHITE;

  float startMillis;
  boolean expired;
  int shakeStrength;

  InWorldPopup(PVector pos, String text, float time) {
    this.pos = pos;
    this.text = text;
    this.time = time * 1000;

    startMillis = millis();
    expired = false;
    shakeStrength = 0;
  }

  void update() {
    expired = millis() - startMillis > time;
  }

  void render(PGraphics canvas) {
    canvas.textFont(OCRA);
    canvas.fill(colour);
    canvas.textSize(size);
    canvas.textAlign(CENTER, CENTER);
    if (shakeStrength == 0) {
      canvas.text(text, pos.x, pos.y);
    } else {
      canvas.text(text, pos.x + random(-shakeStrength, shakeStrength), pos.y + random(-shakeStrength, shakeStrength));
    }
  }
}
