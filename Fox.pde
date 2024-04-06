enum FoxState {
  IDLE, EXPLORING, HUNTING
};

class Fox extends Animal {
  FoxState state = FoxState.IDLE;

  ArrayList<Chicken> chickens;

  Fox(PVector pPos, float pMoveSpeed, ArrayList<Chicken> pChickens) {
    super(pPos, pMoveSpeed);
    chickens = pChickens;
  }

  Chicken getClosestChicken() {
    Chicken closest = chickens.get(0);
    float distance = Float.MAX_VALUE;

    for (Chicken chimken : chickens) {
      PVector deltaPos = PVector.sub(chimken.pos, pos);

      if (deltaPos.magSq() < distance) {
        distance = deltaPos.magSq();
        closest = chimken;
      }
    }

    return closest;
  }

  void update() {
    super.update();
    if (keyPressed) {
      if (key == ' ') {
        state = FoxState.HUNTING;
        activate();
      }
    }

    switch(state) {
    case IDLE:
      break;
    case EXPLORING:
      explore();
      break;
    case HUNTING:
      moveDir = PVector.sub(getClosestChicken().pos, pos).normalize();
      move();
      break;
    }
  }

  void render() {
    rectMode(CENTER);
    fill(color(255, 160, 0));
    rect(pos.x, pos.y, 25, 10);

    rectMode(CENTER);
    fill(color(255));
    rect(pos.x+14, pos.y-1, 9, 5);

    rectMode(CENTER);
    fill(color(250, 170, 0));
    rect(pos.x-13, pos.y-3, 9, 9);
  }
}
