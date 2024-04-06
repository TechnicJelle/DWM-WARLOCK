GameState gameState;

//move these animals to World class later
ArrayList<Chicken> cs;
Fox f;

void setup() {
  size(1280, 720);
  gameState = new GameState(1,
    new Scene_Startup(),
    new Scene_MainMenu(),
    new Scene_InGame(),
    new Scene_Score()
    );

  //move this setup to World class later
  cs = new ArrayList<Chicken>();
  for (int i=0; i < 10; i++) {
    cs.add(new Chicken(new PVector(random(width), random(height)), random(5, 10)));
  }
  f = new Fox(new PVector(width, height), 10, cs);
}

void draw() {
  background(0);
  gameState.updateCurrentScene();
  gameState.renderCurrentScene();

  //move this rendering and updating to World class later
  for (Chicken c : cs) {
    c.update();
    c.render();
  }

  f.update();
  f.render();
}

void mouseClicked() {
  gameState.mouseClickedCurrentScene();
}
