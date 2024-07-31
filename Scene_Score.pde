import java.util.Date;
import java.text.SimpleDateFormat;


class Scene_Score implements Scene {
  boolean textInputting = true;
  String textInputted = "";
  int totalScore = 0;
  int beepIndex = 0;

  int millisAtSceneInit = -1;
  int millisAFKTimerReset = -1;
  int afkTimerMillis = 1000 * 60;
  int afkCountdownMillis = 1000 * 10; //how many millis must be left before it actually shows the countdown

  int topCount = 10; //amount of players that is visible in the list

  void restartAfkCountdown() {
    millisAFKTimerReset = millis();
  }

  void init() {
    textInputting = true;
    textInputted = "";
    totalScore = 0;
    restartAfkCountdown();
    millisAtSceneInit = millis();
    beepIndex = 0;

    for (Map.Entry<String, Integer> score : scores.entrySet()) {
      Integer amount = score.getValue();
      totalScore += amount;
    }
  }

  void update() {
  }

  void render() {
    int millisSinceSceneInit = millis() - millisAtSceneInit;

    // --- Vertical split line through the middle ---
    stroke(255);
    strokeWeight(2);
    line(width/2, 0, width/2, height);


    // --- AFK Countdown Timer ---
    int millisSinceAFKReset = millis() - millisAFKTimerReset;
    int millisLeftAFK = afkTimerMillis - millisSinceAFKReset;
    if (millisLeftAFK <= afkCountdownMillis) {
      textAlign(CENTER, CENTER);
      int secondsLeft = millisLeftAFK/1000;
      //height
      float alarmness = map(secondsLeft, afkCountdownMillis/1000, 0, 0, 100);
      float textHeight = 48 + alarmness;
      textSize(textHeight);

      //width
      String text = str(secondsLeft + 1);
      float textWidth = textWidth(text);

      rectMode(CENTER);
      fill(0);
      noStroke();
      rect(width/2, height/2, textWidth, textHeight);

      fill(255);
      text(text, width/2, height/2);

      if (millisLeftAFK <= 0) {
        gameState.nextScene();
      }
    }

    fill(255);
    textAlign(CENTER, TOP);


    // --- Score makeup ---

    textSize(52);
    text("Your score:", width/4f, height*0.03);

    {
      int i = 0;
      float padLR = width/80f;
      float y = height*0.09;
      for (Map.Entry<String, Integer> score : scores.entrySet()) {
        if (millisSinceSceneInit < (i+1) * 1000) {
          break;
        }
        if (beepIndex == i) {
          sfxScorePart.play();
          beepIndex++;
        }
        y += height*0.07;
        String reason = score.getKey();
        textSize(34);
        textAlign(LEFT, BOTTOM);
        text(reason + ":", padLR, y);

        Integer amount = score.getValue();
        textSize(50);
        textAlign(RIGHT, BOTTOM);
        text(amount, width/2f-padLR, y);
        i++;
      }

      if (i == scores.size() && millisSinceSceneInit > (i+1) * 1000) {
        if (beepIndex == i) {
          sfxScoreTotal.play();
          beepIndex++;
        }
        y+=height*0.01;
        stroke(128);
        strokeWeight(1);
        line(padLR, y, width/2f - padLR, y);

        y+=height*0.03;
        textAlign(LEFT, TOP);
        textSize(54);
        text("Total:", padLR, y);

        textAlign(RIGHT, TOP);
        textSize(128);
        text(totalScore, width/2f - padLR, y);
      }
    }


    // --- Submit score ---

    textAlign(CENTER, TOP);
    textSize(48);
    text("Name:", width/4, height*0.65);

    textSize(128);
    rectMode(CENTER);
    noStroke();
    float charWidth = 80;
    for (int i = 0; i < 3; i++) {
      float x = (width/4) - charWidth + (charWidth * i);
      float y = height*0.75;
      if (millis() % 1060 > 530 && i == textInputted.length()) {
        fill(255);
      } else {
        fill(255, 50);
      }
      //rect(x, y + 100, charWidth-10, 5); //underline
      rect(x, y + 42, charWidth-10, 100); //block
      if (i < textInputted.length()) {
        fill(255);
        text(textInputted.charAt(i), x, y);
      }
    }

    fill(255);
    if (textInputting) {
      textSize(48);
      if (textInputted.length() != 3) {
        text("Type your user tag!", width/4, height*0.92);
      } else {
        text("Enter to submit!", width/4, height*0.92);
      }
    } else {
      textSize(48);
      text("Click to go the menu", width/4, height*0.92);
    }


    // --- Highscores list ---

    textSize(48);
    text("Highscores:", width/4f*3, height*0.1);

    pushMatrix();
    float w = width/3;
    translate(width/2 + w/4, height*0.2);
    for (int i = 0; i < (highscores.getRowCount() < topCount ? highscores.getRowCount() : topCount); i++) {
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
    restartAfkCountdown();
    if (!textInputting) {
      gameState.nextScene();
    }
  }

  void mouseDragged() {
    restartAfkCountdown();
  }

  void mouseReleased() {
    restartAfkCountdown();
  }

  void keyPressed() {
    restartAfkCountdown();
    if (textInputting) {
      if (key == BACKSPACE || key == DELETE) {
        if (textInputted.length() > 0) {
          textInputted = textInputted.substring(0, textInputted.length() - 1);
          sfxTyped.play();
        }
      } else if ((key == RETURN || key == ENTER) && textInputted.length() == 3) {
        textInputting = false;

        TableRow newRow = highscores.addRow();
        newRow.setString("name", textInputted);
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date now = new Date();
        String strDate = sdfDate.format(now);
        newRow.setString("time", strDate);
        newRow.setInt("score", totalScore);

        highscores.trim();
        highscores.sortReverse("score");
        saveTable(highscores, "data/highscores.csv");

        int index = highscores.findRowIndex(strDate, "time");
        if (index == 0) {
          sfxHighscoresTop.play();
        } else if (index <= topCount) {
          sfxHighscores.play();
        }
      } else if (key != CODED) {
        if (Character.isLetter(key) || Character.isDigit(key)) {
          if (textInputted.length() < 3) {
            textInputted += Character.toUpperCase(key);
            sfxTyped.play();
          }
        }
      }
    }
  }

  void keyReleased() {
    restartAfkCountdown();
  }

  void cleanup() {
  }
}
