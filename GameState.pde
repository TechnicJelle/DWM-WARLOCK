import java.util.List;

interface Scene {
  void init();
  void update();
  void render();
  void mouseClicked();
  void cleanup();
}

class GameState {
  List<Scene> internalScenes;
  int currentScene;
  int defaultScene;

  GameState(int defaultScene, Scene... scenes) {
    internalScenes = List.of(scenes);
    this.defaultScene = defaultScene;
    assert internalScenes.size() > 0;
    currentScene = 0;
  }

  Scene getCurrentScene() {
    return internalScenes.get(currentScene);
  }

  void updateCurrentScene() {
    getCurrentScene().update();
  }

  void renderCurrentScene() {
    getCurrentScene().render();
  }

  void mouseClickedCurrentScene() {
    getCurrentScene().mouseClicked();
  }

  void nextScene() {
    getCurrentScene().cleanup();
    currentScene++;
    if (currentScene > internalScenes.size()-1)
      currentScene = defaultScene;

    getCurrentScene().init();
  }
}
