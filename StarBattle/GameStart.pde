class GameMenu {
  
  
    float buttonW = 200;
  float buttonX = width/2 - buttonW/2;
  float buttonY = height - 100;;
  float buttonH = 50;
  
  boolean mouseIsOverButton = false;
  
   void display() {
    
    fill(28, 37, 60, 200);
    rect(0, 0, width, height);
   
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(40);
    text("Star Battle", 200, 50);
