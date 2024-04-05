class Wolf{
  PVector pos, center;
  float speed;
 
  Wolf(PVector pWindowSize){
    center = new PVector(pWindowSize.x/2, pWindowSize.y/2);
    pos = center;
  }
  
 
  void move(){
    
  }
  
  void render(){
    rectMode(CENTER);
    fill(color(127));
    rect(pos.x+30, pos.y-5, 25,10);
  }
  
}
