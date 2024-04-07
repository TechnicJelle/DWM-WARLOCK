import java.util.Date;
import java.text.SimpleDateFormat;

class Scene_Score implements Scene {
  boolean textInputting = true;
  String textInputted = "";

  void init() {
    textInputting = true;
    textInputted = "";
  }

  void update() {
  }

  void render() {
    fill(255);
    textAlign(CENTER, TOP);


    // --- Submit score ---

    textSize(48);
    text("Your score:", width/4f, height*0.1);

    textSize(148);
    text(score, width/4f, height*0.2);

    textSize(48);
    text("Name:", width/4, height*0.5);

    textSize(128);
    text(textInputted, width/4, height*0.6);

    if (textInputting) {
      if (millis() % 2000 < 1000) {
        float x = width/4 + textWidth(textInputted)/2;
        stroke(255);
        strokeWeight(2);
        line(x, height*0.59, x, height*0.73);
      }

      textSize(48);
      if (textInputted.length() != 3) {
        text("Type your user tag!", width/4, height*0.9);
      } else {
        text("Enter to submit!", width/4, height*0.9);
      }
    } else {
      textSize(48);
      text("Click to go the menu", width/4, height*0.9);
    }

    stroke(255);
    strokeWeight(2);
    line(width/2, 0, width/2, height);

    // --- Highscores list ---

    textSize(48);
    text("Highscores:", width/4f*3, height*0.1);

    pushMatrix();
    float w = width/3;
    translate(width/2 + w/4, height*0.2);
    for (int i = 0; i < (highscores.getRowCount() < 10 ? highscores.getRowCount() : 10); i++) {
      float y = i * 50 + 10;
      TableRow tr = highscores.getRow(i);
      textAlign(LEFT, TOP);
      text(tr.getString("name"), 32, y);
      textAlign(RIGHT, TOP);
      text(tr.getInt("score"), w-32, y);
    }
    popMatrix();
  }

  void mousePressed() {
    if (!textInputting) {
      gameState.nextScene();
    }
  }

  void mouseDragged() {
  }

  void mouseReleased() {
  }

  void keyPressed() {
    if (textInputting) {
      if (key == BACKSPACE || key == DELETE) {
        if (textInputted.length() > 0) {
          textInputted = textInputted.substring(0, textInputted.length() - 1);
        }
      } else if ((key == RETURN || key == ENTER) && textInputted.length() == 3) {
        textInputting = false;

        TableRow newRow = highscores.addRow();
        newRow.setString("name", textInputted);
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy/MM/dd HH:mm");
        Date now = new Date();
        String strDate = sdfDate.format(now);
        newRow.setString("time", strDate);
        newRow.setInt("score", score);

        highscores.trim();
        highscores.sortReverse("score");
        saveTable(highscores, "data/highscores.csv");
      } else if (key != CODED) {
        if (Character.isLetter(key) || Character.isDigit(key)) {
          if (textInputted.length() < 3) {
            textInputted += Character.toUpperCase(key);
          }
        }
      }
    }
  }

  void keyReleased() {
  }

  void cleanup() {
  }
}
