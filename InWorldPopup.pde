class InWorldPopup {
  PVector pos;
  String text;
  float time;
  
  float size = 32;
  color colour = WHITE;

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
    canvas.fill(colour);
    canvas.textSize(size);
    canvas.textAlign(CENTER, CENTER);
    canvas.text(text, pos.x, pos.y);
  }
}
