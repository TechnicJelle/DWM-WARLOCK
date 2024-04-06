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
    moveDir = new PVector(1, 1).normalize();
    ticSpeed = 100;
  }

  void move() {
    pos.add(PVector.mult(moveDir, moveSpeed));
    ticCounter -= 1;
  }

  void explore() {
    if (ticCounter <= 0) {
      moveDir = PVector.random2D();
      ticCounter = ticSpeed;
    }
    move();
  }

  void update() {
    bounceOffBorders();
  }

  abstract void render(PGraphics canvas);
}
