class Bullet{
  PVector position = new PVector(0,0);
  float speed = 8;
  
   Bullet(PVector location) {
    position = location.copy();
  }
