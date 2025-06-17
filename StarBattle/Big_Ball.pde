class BBall {
  float size = 100;
  PVector location = new PVector (random(size, width - size), random(-150, -50)); 
  PVector velocity = new PVector(0,50);
  PVector acceleration = new PVector(0, 2);
  
  BBall() {
  }
  
    BBall(float x, float y, PVector initialVelocity) {
    location = new PVector(x, y);
    velocity = initialVelocity.copy(); 
  }

void update() {
  if(location.y > height + size){
    location.y = -size;
    location.x = random(size, width - size);
  }
}

  void display() {
    fill(181, 147, 48);
    circle(location.x, location.y, size);
    }
