//this is to draw the background star
class Star {
  PVector location = new PVector (random(width), random(-height, 0)); //give the location ad random x
  float size = random (10, 30); //set the size range of the star
  float dropspeed = size * 0.013; //the dropping speed of the star is related to the size of the star
  float r = 255; //set the r color
  float g = random(100, 255); //set the range of g color
  float b = random(100, 255); //set the range of b color
  
  //this make the y axis change according to the dropspeed of this star
  void fall() {
    location.y = location.y + dropspeed;
  }
  
  //draw the star
  void show() {
    fill(r,g,b); //the color will have a fixed r random g and b which defined ealier
    circle(location.x, location.y, size); //draw the star circle with the location and size defined
    
    //if the star is outside the screen add a new one
    if (location.y > height + size) {
        location.y = random(-200, -100);
    }
  }
}
