enum ChickenState {
  IDLE, EXPLORING, FLEEING
};

class Chicken extends Animal {
  ChickenState state = ChickenState.IDLE;

  Chicken(PVector worldSize, PVector pPos, float pMoveSpeed) {
    super(worldSize, pPos, pMoveSpeed);
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
      break;
    }
  }

  void render(PGraphics canvas) {
    canvas.image(grChicken, pos.x, pos.y);
  }
}
