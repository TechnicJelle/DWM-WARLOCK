import java.util.Optional;

enum FoxState {
  IDLE, EXPLORING, HUNTING, DEAD
};

class Fox extends Animal {
  FoxState state = FoxState.IDLE;

  ArrayList<Chicken> chickens;

  Fox(PVector worldSize, PVector pPos, float pMoveSpeed, ArrayList<Chicken> pChickens) {
    super(worldSize, pPos, pMoveSpeed);
    chickens = pChickens;
    state = FoxState.HUNTING;
    activate();
  }

  Optional<Chicken> getClosestChicken() {
    if (chickens.isEmpty()) return Optional.empty();

    Chicken closest = chickens.get(0);
    float distance = Float.MAX_VALUE;

    for (Chicken chimken : chickens) {
      PVector deltaPos = PVector.sub(chimken.pos, pos);

      if (deltaPos.magSq() < distance) {
        distance = deltaPos.magSq();
        closest = chimken;
      }
    }

    if (distance > sq(256)) return Optional.empty(); //how far the fox can see

    return Optional.of(closest);
  }

  void update() {
    super.update();
    Optional<Chicken> potentiallyClosestChicken = getClosestChicken();
    if (state != FoxState.DEAD) {
      if (potentiallyClosestChicken.isPresent()) {
        state = FoxState.HUNTING;
      } else {
        state = FoxState.EXPLORING;
      }
    }
    switch(state) {
    case IDLE:
      break;
    case EXPLORING:
      explore();
      break;
    case HUNTING:
      Chicken c = potentiallyClosestChicken.get();
      PVector diff = PVector.sub(c.pos, pos);
      if (diff.mag() < 32) {
        sfxChicken.play();
        chickens.remove(c);
      }
      moveDir = diff.normalize();
      move();
      break;
    case DEAD:
      break;
    }
  }

  void render(PGraphics canvas) {
    canvas.pushStyle();
    canvas.imageMode(CENTER);
    switch(state) {
    case IDLE:
    case EXPLORING:
    case HUNTING:
      canvas.image(grFox, pos.x, pos.y);
      break;
    case DEAD:
      canvas.image(grFoxDead, pos.x, pos.y+10);
      break;
    }
    canvas.popStyle();
  }
}
