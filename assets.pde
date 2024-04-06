color WHITE = color(255);
color RED = color(255,0,0);
color YELLOW = color(255,255,0);
color ORANGE = color(255,122,0);
color GREEN = color(0,255,0);
color BLACK = color(0);
color GREY = color(81);


void chicken(int x, int y) {
  //strokeWeight(1);
  //stroke(RED);
  //point(x,y);
  strokeWeight(1);
  noFill();

  pushMatrix();
  translate(x+0, y+-28);
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
  
  popMatrix();
}

void fox(int x, int y){
  strokeWeight(1);
  stroke(RED);
  point(x,y);
  
  strokeWeight(1);
  noFill();

  pushMatrix();
  translate(x+-2, y+-40);
  scale(2);
  
  //hind back 
  stroke(ORANGE);
  beginShape();
  vertex(18,13);
  vertex(18,14);
  vertex(20,16);
  vertex(20,18);
  vertex(19,20);
  vertex(18,20);
  vertex(20,20);
  vertex(22,16);
  vertex(22,14);
  endShape();
  
  //feets (except back hind leg)
  stroke(ORANGE);
  beginShape();
  vertex(6,10);
  vertex(6,12);
  vertex(7,13);
  vertex(7,14);
  vertex(6,20);
  vertex(5,20);
  vertex(7,20);
  vertex(8,14);
  vertex(9,13);
  vertex(10,13);
  vertex(11,15);
  vertex(10,20);
  vertex(9,20);
  vertex(11,20);
  vertex(12,15);
  vertex(14,13);
  vertex(21,13);
  vertex(23,15);
  vertex(25,16);
  vertex(25,18);
  vertex(24,20);
  vertex(23,20);
  vertex(25,20);
  vertex(27,15);
  vertex(26,13);
  vertex(27,11);
  vertex(29,10);
  vertex(33,12);
  vertex(36,12);
  endShape();
  
  //socks
  stroke(GREY);
  beginShape();
  vertex(7,14);
  vertex(6,20);
  vertex(5,20);
  vertex(7,20);
  vertex(8,14);
  endShape();
  beginShape();
  vertex(11,15);
  vertex(10,20);
  vertex(9,20);
  vertex(11,20);
  vertex(12,15);
  endShape();
  beginShape();
  vertex(20,16);
  vertex(20,18);
  vertex(19,20);
  vertex(18,20);
  vertex(20,20);
  vertex(22,16);
  endShape();
  beginShape();
  vertex(25,16);
  vertex(25,18);
  vertex(24,20);
  vertex(23,20);
  vertex(25,20);
  vertex(27,16);
  endShape();
  
  //tailwhite
  stroke(WHITE);
  beginShape();
  vertex(35,12);
  vertex(37,12);
  vertex(41,11);
  vertex(39,10);
  vertex(42,9);
  vertex(39,8);
  vertex(40,7);
  vertex(36,6);
  vertex(34,6);
  endShape();
  
  //beard
  stroke(WHITE);
  beginShape();
  vertex(0,6);
  vertex(2,8);
  vertex(4,8);
  vertex(6,10);
  vertex(6,12);
  endShape();
  
  //top body
  stroke(ORANGE);
  beginShape();
  vertex(1,7);
  vertex(0,6);
  vertex(0,4);
  vertex(3,4);
  vertex(4,2);
  vertex(5,2);
  vertex(6,0);
  vertex(7,2);
  vertex(8,2);
  vertex(9,0);
  vertex(10,3);
  vertex(11,3);
  vertex(13,4);
  vertex(16,4);
  vertex(20,5);
  vertex(23,5);
  vertex(29,7);
  vertex(33,6);
  vertex(34,6);
  endShape();
  
  //eyes
  stroke(RED);
  beginShape();
  vertex(4,4);
  vertex(5,4);
  endShape();
  beginShape();
  vertex(7,4);
  vertex(8,4);
  endShape();
  
  popMatrix(); 
}
