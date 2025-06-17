class GameOverScreen {
  
    GameOverScreen() {
  }
  
  void display() {
    fill(200, 0, 0, 150);
    rect(0, 0, width, height);
    
    
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("GAME OVER", 200, 150);
   
    textSize(24);
    text("Final Score: " + score, 200, 200); 

    textSize(20);
    text("Press 'R' to Restart", 200, 250);
  }
}
