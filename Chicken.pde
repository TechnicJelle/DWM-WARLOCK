enum ChickenState {
  IDLE, EXPLORING, FLEEING
};

class Chicken extends Animal {
  ChickenState state = ChickenState.IDLE;
  
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
      break;
    case EXPLORING:
      explore();
      break;
    case FLEEING:
    flee();
      break;
    }
    checkFoxDistance();
  }
  
  void flee(){
    if (ticCounter <= 0) {
      moveDir = PVector.sub(this.pos, fox.pos).normalize();
      ticCounter = ticSpeed;
    }
    move(moveSpeed*1.25f);
  }

  void checkFoxDistance() {
    if(fox == null) return;
    PVector deltaPos = PVector.sub(this.pos, fox.pos);

    if (deltaPos.magSq() < (fleeDistance * fleeDistance)) {
    println("foxdist: " +deltaPos.mag());
      println("FLEEING!");
      state = ChickenState.FLEEING;
      ticCounter = 0;
    }
    else
    state = ChickenState.EXPLORING;
  }

  void render(PGraphics canvas) {
    canvas.pushStyle();
    canvas.imageMode(CENTER);
    canvas.image(grChicken, pos.x, pos.y);
    canvas.popStyle();
  }
}
