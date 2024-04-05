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
    pos = new PVector(winSize.x*0.5f + 30, winSize.y *0.5f -5);
    moveSpeed = pMoveSpeed;
    chickens = pChickens;
  }

  void move() {
    PVector dir = new PVector(moveDir.x, moveDir.y); //Needed to not keep multiplying moveDir
    pos.add(dir.mult(moveSpeed));
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

  void update() {
    checkBorders();
    if (keyPressed) {
      if (key == ' ' ) {
        state = FoxState.EXPLORING;
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
      break;
    }
    println(chickens.size());
  }

  void render() {
    rectMode(CENTER);
    fill(color(127));
    rect(pos.x, pos.y, 25, 10);
  }
}
