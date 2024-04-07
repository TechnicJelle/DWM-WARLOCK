abstract class Animal {
  PVector pos, worldSize, target, moveDir = new PVector(0, 0);
  float moveSpeed = 0f;
  int ticSpeed, ticCounter = 0;

  Animal(PVector worldSize, PVector pos, float moveSpeed) {
    this.pos = pos;
    this.moveSpeed = moveSpeed;
    this.worldSize = worldSize;
  }

  void bounceOffBorders() {
    if (pos.x <= 0) {
      moveDir.x = -moveDir.x;
      pos.x = 0; //clamp
    }

    if (pos.x >= worldSize.x) {
      moveDir.x = -moveDir.x;
      pos.x = worldSize.x; //clamp
    }

    if (pos.y <= 0) {
      moveDir.y = -moveDir.y;
      pos.y = 0; //clamp
    }

    if (pos.y >= worldSize.y) {
      moveDir.y = -moveDir.y;
      pos.y = worldSize.y; //clamp
    }
  }

  void activate() {
    moveDir = PVector.random2D();
    ticSpeed = int(random(10*moveSpeed, 10*moveSpeed*moveSpeed));
  }

  void move(float pSpeed) {
    pos.add(PVector.mult(moveDir, pSpeed));
    ticCounter -= 1;
  }

  void explore() {
    if (ticCounter <= 0) {
      int chooseDir = int(random(0, 4));
      println(chooseDir);

      switch(chooseDir) {
      case 0:
        congregate();
        break;
      case 1:
        disperse();
        break;
      default:
        moveDir = PVector.random2D();
        break;
      }

      ticCounter = ticSpeed;
    }
    move(moveSpeed);
  }

  void congregate() {
    moveDir = PVector.sub(PVector.mult(worldSize, 0.5f), this.pos).normalize();
  }

  void disperse() {
    moveDir = PVector.sub(this.pos, PVector.mult(worldSize, 0.5f)).normalize();
  }

  void update() {
    bounceOffBorders();
  }

  abstract void render(PGraphics canvas);
}
