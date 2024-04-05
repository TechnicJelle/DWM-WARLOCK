enum FoxState {
  IDLE, EXPLORING, HUNTING
};


class Fox {

  PVector pos, winSize, target, moveDir = new PVector(0, 0);
  float moveSpeed = 0f;
  int ticSpeed, ticCounter = 0;

  ArrayList<Chicken> chickens;

  FoxState state = FoxState.IDLE;

  Fox(PVector pWindowSize, float pMoveSpeed, ArrayList<Chicken> pChickens) {
    winSize = new PVector(pWindowSize.x, pWindowSize.y);
    pos = new PVector(winSize.x*0.5f + 100, winSize.y *0.5f -5);
    moveSpeed = pMoveSpeed;
    chickens = pChickens;
  }

  void move() {
    pos.add(PVector.mult(moveDir, moveSpeed));
    ticCounter -= 1;
  }

  void checkBorders() {
    if (pos.x <= 0 || pos.x >= winSize.x) {
      moveDir.x = -moveDir.x;
    }
    if (pos.y <= 0 || pos.y >= winSize.y) {
      moveDir.y = -moveDir.y;
    }
  }

  Chicken getClosestChicken() {
    Chicken closest = chickens.get(0);
    float distance = 99999999;

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
    checkBorders();
    if (keyPressed) {
      if (key == ' ' ) {
        state = FoxState.HUNTING;
        moveDir = new PVector(1, 1);
        ticSpeed = 100;
      }
    }

    switch(state) {
    case IDLE:
      break;
    case EXPLORING:
      if (ticCounter <= 0) {
        moveDir = PVector.random2D();
        ticCounter = ticSpeed;
      }
      move();
      break;
    case HUNTING:
      moveDir =  PVector.sub(getClosestChicken().pos, pos).normalize();
      move();
      break;
    }
    println(chickens.size());
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
