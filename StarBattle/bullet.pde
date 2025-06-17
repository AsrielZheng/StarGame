class Bullet{
  PVector position = new PVector(0,0);
  float speed = 8;
  
   Bullet(PVector location) {
    position = location.copy();
  }
  
    void update(){
    position.y -= speed;
  }
  
  void display() {
    fill(105, 255, 71);
    noStroke();
    rect(position.x, position.y, 10, 30);
  }
}
