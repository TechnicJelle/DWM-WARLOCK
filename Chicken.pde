enum ChickenState {
  IDLE, EXPLORING, FLEEING
};

class Chicken extends Animal {
  ChickenState state = ChickenState.IDLE;

  Chicken(PVector worldSize, PVector pPos, float pMoveSpeed) {
    super(worldSize, pPos, pMoveSpeed);
  }

  void caught() {
  }

  void update() {
    super.update();
    if (keyPressed) {
      if (key == ' ') {
        state = ChickenState.EXPLORING;
        activate();
      }
    }

    switch(state) {
    case IDLE:
      break;
    case EXPLORING:
      explore();
      break;
    case FLEEING:
      break;
    }
  }

  void render(PGraphics canvas) {
    canvas.strokeWeight(1);
    canvas.fill(BLACK);

    canvas.pushMatrix();
    canvas.translate(pos.x-5, pos.y-28);
    canvas.scale(2);

    //beak
    canvas.stroke(YELLOW);
    canvas.beginShape();
    canvas.vertex(3, 4);
    canvas.vertex(0, 6);
    canvas.vertex(3, 8);
    canvas.endShape(CLOSE);

    //leg L
    canvas.beginShape();
    canvas.vertex(5, 11);
    canvas.vertex(5, 14);
    canvas.vertex(4, 14);
    canvas.endShape();
    //leg R
    canvas.beginShape();
    canvas.vertex(8, 11);
    canvas.vertex(8, 14);
    canvas.vertex(7, 14);
    canvas.endShape();

    //crown
    canvas.stroke(RED);
    canvas.beginShape();
    canvas.vertex(3, 3);
    canvas.vertex(7, 3);
    canvas.vertex(8, 1);
    canvas.vertex(6, 1);
    canvas.vertex(5, 0);
    canvas.vertex(4, 1);
    canvas.vertex(2, 1);
    canvas.endShape(CLOSE);

    //body
    canvas.stroke(WHITE);
    canvas.beginShape();
    canvas.vertex(3, 3);
    canvas.vertex(2, 9);
    canvas.vertex(3, 11);
    canvas.vertex(9, 11);
    canvas.vertex(12, 8);
    canvas.vertex(10, 8);
    canvas.vertex(11, 6);
    canvas.vertex(8, 7);
    canvas.vertex(7, 5);
    canvas.vertex(7, 3);
    canvas.endShape(CLOSE);

    //eye
    canvas.beginShape();
    canvas.vertex(5, 4);
    canvas.vertex(5, 6);
    canvas.endShape(CLOSE);

    canvas.popMatrix();
  }
}
