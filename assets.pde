color WHITE = color(255);
color RED = color(255,0,0);
color YELLOW = color(255,255,0);
color ORANGE = color(255,122,0);
color GREEN = color(0,0,255);
color BLACK = color(0);

void chicken(int x, int y) {
  strokeWeight(1);
  fill(BLACK);

  translate(x, y);
  scale(2);

  //beak
  stroke(YELLOW);
  beginShape();
  vertex(3,4);
  vertex(0,6);
  vertex(3,8);
  endShape(CLOSE);
  
  //leg L
  beginShape();
  vertex(5,11);
  vertex(5,14);
  vertex(4,14);
  endShape();
  //leg R
  beginShape();
  vertex(8,11);
  vertex(8,14);
  vertex(7,14);
  endShape();
  
  //crown
  stroke(RED);
  beginShape();
  vertex(3,3);
  vertex(7,3);
  vertex(8,1);
  vertex(6,1);
  vertex(5,0);
  vertex(4,1);
  vertex(2,1);
  endShape(CLOSE);
  
    //body
  stroke(WHITE);
  beginShape();
  vertex(3,3);
  vertex(2,9);
  vertex(3,11);
  vertex(9,11);
  vertex(12,8);
  vertex(10,8);
  vertex(11,6);
  vertex(8,7);
  vertex(7,5);
  vertex(7,3);
  endShape(CLOSE);
  
  //eye
  beginShape();
  vertex(5,4);
  vertex(5,6);
  endShape(CLOSE);
}
