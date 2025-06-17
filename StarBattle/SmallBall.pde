//Small meteors size and location
class SBall {
  float size = 40; //the size for the meteors in this class
  PVector location = new PVector (random(size, width - size), random(-150, -50));  //define the initial location of the meteor
  PVector velocity = new PVector(0,50); //define the initial velocity of the meteor
  PVector acceleration = new PVector(0, 2); //define the acceleration of the meteor
  
   //Add the function so main can call it
    SBall() {
  }

  //define the exact x, y and velocity in each fram
SBall(float x, float y, PVector initialVelocity) {
    location = new PVector(x, y);
    velocity = initialVelocity.copy(); 
  }

 //update the actual velocity of the meteor after acceleration
void update() {

  float elapsed = 1/frameRate; //get the number of how long is a frame
  //only update when the game start
  if (gameState == 1) {  

    location.add(PVector.mult(velocity, elapsed));
    //the ball only start to accelerate after 10 seconds in the game
        if (gameTimer > 600) {

      velocity.add(PVector.mult(acceleration, elapsed));
  }
  }

//check if the meteor is outside the screen
  if(location.y > height + size){
    lives--; //one live is used if the ball go out the screen
    location.y = -size; //give the ball a new y axis
    location.x = random(size, width - size); //give the ball a new x axis
    if (lives <= 0) gameState = 2; //the game state is set to 2 (game over) if the remain lives is equal or under 0
    }
  }

  //draw the ball
  void display() {
    fill(181, 147, 48);
    circle(location.x, location.y, size);
    }

  //define the size of the meteor to detect if the spaceship hit the meteor
  boolean hits(spaceship s){
    float distance = dist(location.x, location.y, s.position.x, s.position.y); //get the distance between the the center of the ball and the center of the spaceship
    return (distance < (size / 2) + 15); //check if the distance is less than the sum of the two objects
  }
}
