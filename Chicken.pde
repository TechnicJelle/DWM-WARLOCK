enum ChickenState {
  IDLE, EXPLORING, FLEEING
};

class Chicken extends Animal {
  ChickenState state = ChickenState.EXPLORING;

  float fleeDistance = 400;

  Chicken(PVector worldSize, PVector pPos, float pMoveSpeed) {
    super(worldSize, pPos, pMoveSpeed);
    ticSpeed = int(random(5, 25));
    state = ChickenState.EXPLORING;
    activate();
  }

  void caught() {
  }

  void update() {
    super.update();

    switch(state) {
    case IDLE:
      idle(idleAngle);
      if (int(random(0, 70)) == 0) {
        state = ChickenState.EXPLORING;
      }
      break;
    case EXPLORING:
      explore();
      if (int(random(0, 256)) == 0) {
        state = ChickenState.IDLE;
        idlePos = pos;
        idleAngle = random(-0.04f, 0.04f)*moveSpeed;
      }
      break;
    case FLEEING:
      flee();
      break;
    }
    checkFoxDistance();
  }

  void flee() {
    if (ticCounter <= 0) {
      moveDir = PVector.sub(this.pos, fox.pos).normalize();
      ticCounter = ticSpeed;
    }
    move(moveSpeed*1.5f);
  }

  void checkFoxDistance() {
    if (fox == null) return;
    PVector deltaPos = PVector.sub(this.pos, fox.pos);

    if (deltaPos.magSq() < (fleeDistance * fleeDistance)) {
      state = ChickenState.FLEEING;
      ticCounter = 0;
    } else if (state == ChickenState.FLEEING)
      state = ChickenState.EXPLORING;
  }

  void render(PGraphics canvas) {
    canvas.pushStyle();
    canvas.imageMode(CENTER);
    canvas.image(grChicken, pos.x, pos.y);
    canvas.popStyle();
  }
}
