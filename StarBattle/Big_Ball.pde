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
    float elapsed = 1/frameRate;

    if (gameState == 1) { 
      location.add(PVector.mult(velocity, elapsed));

          if (gameTimer > 600) {
        velocity.add(PVector.mult(acceleration, elapsed));
    }
  }
  if(location.y > height + size){
    lives--; 
    location.y = -size;
    location.x = random(size, width - size);
    if (lives <= 0) gameState = 2;
  }
}

  void display() {
    fill(181, 147, 48);
    circle(location.x, location.y, size);
    }
    
boolean hits(spaceship s){
    float distance = dist(location.x, location.y, s.position.x, s.position.y); 
    return (distance < (size / 2) + 15); 
}
