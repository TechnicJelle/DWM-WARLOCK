enum ChickenState {
  IDLE, EXPLORING, FLEEING
};

class Chicken {

  PVector pos, center, target, moveDir = new PVector(0, 0);
  float speed, thinkSpeed, steps = 0;

  ChickenState state = ChickenState.IDLE;

  Chicken(PVector pWindowSize, float pMoveSpeed) {
    center = new PVector(pWindowSize.x/2, pWindowSize.y/2);
    pos = center;
    speed = pMoveSpeed;
  }


  void move() {
    pos.x += (moveDir.x * speed*0.5f);
    pos.y += (moveDir.y * speed*0.5f);
    steps -= 1;
  }

  void render() {

    thinkSpeed = 10;
    if (keyPressed) {
      if (key == ' ' ) {
        state = ChickenState.EXPLORING;
        moveDir = new PVector(1, 1);
      }
    }

    switch(state) {
    case IDLE:
      break;
    case EXPLORING:
      if (steps <= 0) {
        moveDir = PVector.random2D();
        steps = thinkSpeed;
      }
      move();
      println(steps);
      break;
    case FLEEING:
      break;
    }

    rectMode(CENTER);
    fill(color(255));
    rect(pos.x, pos.y, 15, 20);
  }
}
