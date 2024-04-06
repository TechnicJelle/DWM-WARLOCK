import java.util.Optional;

enum FoxState {
  IDLE, EXPLORING, HUNTING
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
    if (potentiallyClosestChicken.isPresent()) {
      state = FoxState.HUNTING;
    } else {
      state = FoxState.EXPLORING;
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
        chickens.remove(c);
      }
      moveDir = diff.normalize();
      move();
      break;
    }
  }

  void render(PGraphics canvas) {
    //strokeWeight(1);
    //stroke(RED);
    //point(x, y);

    canvas.strokeWeight(1);
    canvas.noFill();

    canvas.pushMatrix();
    canvas.translate(pos.x-2, pos.y-40);
    canvas.scale(2);

    //backfill
    canvas.fill(BLACK);
    canvas.beginShape();
    canvas.vertex(6, 10);
    canvas.vertex(6, 12);
    canvas.vertex(7, 13);
    canvas.vertex(7, 14);
    canvas.vertex(6, 20);
    canvas.vertex(5, 20);
    canvas.vertex(7, 20);
    canvas.vertex(8, 14);
    canvas.vertex(9, 13);
    canvas.vertex(10, 13);
    canvas.vertex(11, 15);
    canvas.vertex(10, 20);
    canvas.vertex(9, 20);
    canvas.vertex(11, 20);
    canvas.vertex(12, 15);
    canvas.vertex(14, 13);
    canvas.vertex(21, 13);
    canvas.vertex(23, 15);
    canvas.vertex(25, 16);
    canvas.vertex(25, 18);
    canvas.vertex(24, 20);
    canvas.vertex(23, 20);
    canvas.vertex(25, 20);
    canvas.vertex(27, 15);
    canvas.vertex(26, 13);
    canvas.vertex(27, 11);
    canvas.vertex(29, 10);
    canvas.vertex(33, 12);
    canvas.vertex(36, 12);
    canvas.vertex(37, 12);
    canvas.vertex(41, 11);
    canvas.vertex(39, 10);
    canvas.vertex(42, 9);
    canvas.vertex(39, 8);
    canvas.vertex(40, 7);
    canvas.vertex(36, 6);
    canvas.vertex(34, 6);
    canvas.vertex(33, 6);
    canvas.vertex(29, 7);
    canvas.vertex(23, 5);
    canvas.vertex(20, 5);
    canvas.vertex(16, 4);
    canvas.vertex(13, 4);
    canvas.vertex(11, 3);
    canvas.vertex(10, 3);
    canvas.vertex(9, 0);
    canvas.vertex(8, 2);
    canvas.vertex(7, 2);
    canvas.vertex(6, 0);
    canvas.vertex(5, 2);
    canvas.vertex(4, 2);
    canvas.vertex(3, 4);
    canvas.vertex(0, 4);
    canvas.vertex(0, 6);
    canvas.vertex(2, 8);
    canvas.vertex(4, 8);
    canvas.endShape(CLOSE);

    //hind back leg
    canvas.stroke(ORANGE);
    canvas.fill(BLACK);
    canvas.beginShape();
    canvas.vertex(18, 13);
    canvas.vertex(18, 14);
    canvas.vertex(20, 16);
    canvas.vertex(20, 18);
    canvas.vertex(19, 20);
    canvas.vertex(18, 20);
    canvas.vertex(20, 20);
    canvas.vertex(22, 16);
    canvas.vertex(22, 14);
    canvas.endShape();

    //feets (except back hind leg)
    canvas.stroke(ORANGE);
    canvas.noFill();
    canvas.beginShape();
    canvas.vertex(6, 10);
    canvas.vertex(6, 12);
    canvas.vertex(7, 13);
    canvas.vertex(7, 14);
    canvas.vertex(6, 20);
    canvas.vertex(5, 20);
    canvas.vertex(7, 20);
    canvas.vertex(8, 14);
    canvas.vertex(9, 13);
    canvas.vertex(10, 13);
    canvas.vertex(11, 15);
    canvas.vertex(10, 20);
    canvas.vertex(9, 20);
    canvas.vertex(11, 20);
    canvas.vertex(12, 15);
    canvas.vertex(14, 13);
    canvas.vertex(21, 13);
    canvas.vertex(23, 15);
    canvas.vertex(25, 16);
    canvas.vertex(25, 18);
    canvas.vertex(24, 20);
    canvas.vertex(23, 20);
    canvas.vertex(25, 20);
    canvas.vertex(27, 15);
    canvas.vertex(26, 13);
    canvas.vertex(27, 11);
    canvas.vertex(29, 10);
    canvas.vertex(33, 12);
    canvas.vertex(36, 12);
    canvas.endShape();

    //socks
    canvas.stroke(GREY);
    canvas.beginShape();
    canvas.vertex(7, 14);
    canvas.vertex(6, 20);
    canvas.vertex(5, 20);
    canvas.vertex(7, 20);
    canvas.vertex(8, 14);
    canvas.endShape();
    canvas.beginShape();
    canvas.vertex(11, 15);
    canvas.vertex(10, 20);
    canvas.vertex(9, 20);
    canvas.vertex(11, 20);
    canvas.vertex(12, 15);
    canvas.endShape();
    canvas.beginShape();
    canvas.vertex(20, 16);
    canvas.vertex(20, 18);
    canvas.vertex(19, 20);
    canvas.vertex(18, 20);
    canvas.vertex(20, 20);
    canvas.vertex(22, 16);
    canvas.endShape();
    canvas.beginShape();
    canvas.vertex(25, 16);
    canvas.vertex(25, 18);
    canvas.vertex(24, 20);
    canvas.vertex(23, 20);
    canvas.vertex(25, 20);
    canvas.vertex(27, 16);
    canvas.endShape();

    //tailwhite
    canvas.stroke(WHITE);
    canvas.beginShape();
    canvas.vertex(35, 12);
    canvas.vertex(37, 12);
    canvas.vertex(41, 11);
    canvas.vertex(39, 10);
    canvas.vertex(42, 9);
    canvas.vertex(39, 8);
    canvas.vertex(40, 7);
    canvas.vertex(36, 6);
    canvas.vertex(34, 6);
    canvas.endShape();

    //beard
    canvas.stroke(WHITE);
    canvas.beginShape();
    canvas.vertex(0, 6);
    canvas.vertex(2, 8);
    canvas.vertex(4, 8);
    canvas.vertex(6, 10);
    canvas.vertex(6, 12);
    canvas.endShape();

    //top body
    canvas.stroke(ORANGE);
    canvas.beginShape();
    canvas.vertex(1, 7);
    canvas.vertex(0, 6);
    canvas.vertex(0, 4);
    canvas.vertex(3, 4);
    canvas.vertex(4, 2);
    canvas.vertex(5, 2);
    canvas.vertex(6, 0);
    canvas.vertex(7, 2);
    canvas.vertex(8, 2);
    canvas.vertex(9, 0);
    canvas.vertex(10, 3);
    canvas.vertex(11, 3);
    canvas.vertex(13, 4);
    canvas.vertex(16, 4);
    canvas.vertex(20, 5);
    canvas.vertex(23, 5);
    canvas.vertex(29, 7);
    canvas.vertex(33, 6);
    canvas.vertex(34, 6);
    canvas.endShape();

    //eyes
    canvas.stroke(RED);
    canvas.beginShape();
    canvas.vertex(4, 4);
    canvas.vertex(5, 4);
    canvas.endShape();
    canvas.beginShape();
    canvas.vertex(7, 4);
    canvas.vertex(8, 4);
    canvas.endShape();

    canvas.popMatrix();
  }
}
