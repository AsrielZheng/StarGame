//this create the game over screen
class GameOverScreen {
  //Add the function so main can call it
  GameOverScreen() {
  }
  
  //draw the game over screen
  void display() {
    fill(200, 0, 0, 150); //give the screen a red filter
    rect(0, 0, width, height); //fill the red filter to the entire screen

    //print the word in the center
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("GAME OVER", 200, 150);
    //print the score
    textSize(24);
    text("Final Score: " + score, 200, 200); 
    //print how to restart the game
    textSize(20);
    text("Press 'R' to Restart", 200, 250);
  }
}
