//this is for the bullet shoot from the space ship
class Bullet{
  PVector position = new PVector(0,0); //initialize the position of the bullet
  float speed = 8; //the speed of the bullet per frame
  
  //creat a new bullet
  Bullet(PVector location) {
    position = location.copy();
  }

  //update the bullet current location with the speed given
  void update(){
    position.y -= speed;
  }
  
  //draw the bullet
  void display() {
    fill(105, 255, 71);
    noStroke();
    rect(position.x, position.y, 10, 30);
  }
}
