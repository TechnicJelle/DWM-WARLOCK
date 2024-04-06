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
    canvas.rectMode(CENTER);
    canvas.fill(color(255));
    canvas.rect(pos.x, pos.y, 15, 20);

    canvas.rectMode(CENTER);
    canvas.fill(color(255, 0, 0));
    canvas.rect(pos.x, pos.y-10, 5, 8);

    canvas.rectMode(CENTER);
    canvas.fill(color(255, 255, 0));
    canvas.rect(pos.x-8, pos.y-2, 6, 4);

    canvas.rectMode(CENTER);
    canvas.fill(color(255, 255, 0));
    canvas.rect(pos.x-3, pos.y+12, 3, 4);

    canvas.rectMode(CENTER);
    canvas.fill(color(255, 255, 0));
    canvas.rect(pos.x+3, pos.y+12, 3, 4);
  }
}
