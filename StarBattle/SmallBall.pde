class SBall {
  float size = 40;
  PVector location = new PVector (random(size, width - size), random(-150, -50)); 
  PVector velocity = new PVector(0,50);
  PVector acceleration = new PVector(0, 2);
  
