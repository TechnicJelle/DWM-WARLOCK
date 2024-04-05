enum ChickenState {
  IDLE, EXPLORING, FLEEING
};

class Chicken {

  PVector pos, winSize, target, moveDir = new PVector(0, 0);
  float moveSpeed = 0f;
  int ticSpeed, ticCounter = 0;

  ChickenState state = ChickenState.IDLE;

  Chicken(PVector pWindowSize, float pMoveSpeed) {
    winSize = new PVector(pWindowSize.x, pWindowSize.y);
    pos = new PVector(winSize.x*0.5f, winSize.y *0.5f);
    moveSpeed = pMoveSpeed;
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

  void Catch() {
  }

  void update() {
    checkBorders();
    if (keyPressed) {
      if (key == ' ' ) {
        state = ChickenState.EXPLORING;
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
    case FLEEING:
      break;
    }
  }

  void render() {
    rectMode(CENTER);
    fill(color(255));
    rect(pos.x, pos.y, 15, 20);
    
    rectMode(CENTER);
    fill(color(255,0,0));
    rect(pos.x, pos.y-10, 5, 8);
    
    rectMode(CENTER);
    fill(color(255,255,0));
    rect(pos.x-8, pos.y-2, 6, 4);
    
    rectMode(CENTER);
    fill(color(255,255,0));
    rect(pos.x-3, pos.y+12, 3, 4);
    
    rectMode(CENTER);
    fill(color(255,255,0));
    rect(pos.x+3, pos.y+12, 3, 4);
  }
}
