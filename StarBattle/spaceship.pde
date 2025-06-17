class spaceship {
  float speed = 5;
  boolean moveL = false;
  boolean moveR = false;
  boolean canMove = true;
  float startX = 200;
  float startY = 350;
  float size = 20;
  
  PVector position = new PVector(startX, startY);
  
  void update() {
        if(canMove){
      if(moveL) position.x -= speed;
      if(moveR) position.x += speed;
    }
    position.x = constrain(position.x, 50, 350);
  }
