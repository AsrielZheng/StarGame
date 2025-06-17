//Draw the spaceship, add the moving function
class spaceship {
  float speed = 5; //set the speed of how fast the spaceship move
  boolean moveL = false; //to store if the user press the key to move left
  boolean moveR = false; //to store if the user press the key to move right
  boolean canMove= true; //to store if the ship can move or not
  float startX = 200; //add the initial start x of the spaceship
  float startY = 350; //add the initial start y of the spaceship
  PVector position = new PVector(startX, startY); //add the current position of the space ship and set it to the initial x and y at the beginning
  float size = 20; //define the size of the space ship for collision detection
   
  //update the new space ship location
  void update(){
    //if the space can move now check which key is pressed and move to that direction
    if(canMove){
      if(moveL) position.x -= speed;
      if(moveR) position.x += speed;
    }
    position.x = constrain(position.x, 50, 350); //prevent the spaceship go ou the screen
  }
  
  //draw the spaceship itself and the light on it to represent the lives remain
  void display(int currentLives){
    //draw the spaceship itself
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
    
    //draw the lights on the spaceships related to the lives remain
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
