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
    
    textSize(18);
    text("Instructions", 200, 110);

    textAlign(LEFT, CENTER);
    text("•   A / D Keys to Move", 50, 150);
    text("•   Left Mouse Click to Shoot", 50, 175);
    text("•   Game Over if you are hit", 50, 200);
    text("•   Game Over if you miss 3 balls", 50, 225);
    
    textAlign(CENTER, CENTER);
    text("Shoot These:", width/2, 255);
    fill(181, 147, 48);
    circle(150, 285, 30);
    fill(181, 147, 48);
    circle(200, 285, 20);
    fill(181, 147, 48);
    circle(250, 285, 15);
    
   checkMouseOverButton(); 
   
    if (mouseIsOverButton) {
      fill(0, 200, 0);
    } 
    else {
      fill(0, 150, 0);
  }
  
    rect(buttonX, buttonY, buttonW, buttonH, 10);

    fill(255);
    textSize(24);
    textAlign(CENTER, CENTER);
    text("START GAME", 200, buttonY + buttonH/2);
  }
  
  
  void checkMouseOverButton() {
    if (mouseX > buttonX && mouseX < buttonX + buttonW && mouseY > buttonY && mouseY < buttonY + buttonH) {
      mouseIsOverButton = true;
    } 
    else {
      mouseIsOverButton = false;
    }
  }
}
