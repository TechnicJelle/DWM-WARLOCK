class InWorldPopup {
  PVector pos;
  String text;
  float time;

  float startMillis;
  boolean expired;

  InWorldPopup(PVector pos, String text, float time) {
    this.pos = pos;
    this.text = text;
    this.time = time * 1000;

    startMillis = millis();
    expired = false;
  }

  void update() {
    expired = millis() - startMillis > time;
  }

  void render(PGraphics canvas) {
    canvas.textFont(OCRA);
    canvas.fill(255);
    canvas.textSize(32);
    canvas.textAlign(CENTER, CENTER);
    canvas.text(text, pos.x, pos.y);
  }
}
