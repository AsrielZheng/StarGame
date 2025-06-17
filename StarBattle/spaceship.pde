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
  
  void display() {
        pushMatrix();
    translate(position.x, position.y);
    fill(150, 200, 255);
    stroke(0);
    strokeWeight(1);
    triangle(-50, +30, 0, -10, +50, +30);
    rect(-10, -30, 20, 60);
    triangle(0, -55, -10, -30, +10, -30);
    noStroke();
    fill(255, 255, 0);
    
        if (currentLives >= 1) {
      circle(0, -10, 8);
    } 
    if (currentLives >= 2) {
      circle(0, 0, 8);
    }
    if (currentLives >= 3) {
      circle(0, +10, 8);
    }
    popMatrix();
  }
}
