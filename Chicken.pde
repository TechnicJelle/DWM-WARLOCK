enum ChickenState {
  IDLE, EXPLORING, FLEEING
};

class Chicken extends Animal {
  ChickenState state = ChickenState.IDLE;

  Chicken(PVector pPos, float pMoveSpeed) {
    super(pPos, pMoveSpeed);
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

  void render() {
    rectMode(CENTER);
    fill(color(255));
    rect(pos.x, pos.y, 15, 20);

    rectMode(CENTER);
    fill(color(255, 0, 0));
    rect(pos.x, pos.y-10, 5, 8);

    rectMode(CENTER);
    fill(color(255, 255, 0));
    rect(pos.x-8, pos.y-2, 6, 4);

    rectMode(CENTER);
    fill(color(255, 255, 0));
    rect(pos.x-3, pos.y+12, 3, 4);

    rectMode(CENTER);
    fill(color(255, 255, 0));
    rect(pos.x+3, pos.y+12, 3, 4);
  }
}
