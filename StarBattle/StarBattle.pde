import processing.sound.*;

// === Audio System ===

// Shooting sound effects provide feedback
SoundFile shootSound; 
// Hitting sound effects increase the sense of impact in the game
SoundFile hitSound; 
// Menu music creates a game atmosphere
SoundFile menuMusic; 
// Combat music increases the tension in the game
SoundFile battleMusic;

//=== Music dynamic acceleration system===

//Current music playback speed
float musicRate = 1;
//Maximum acceleration, Avoid music that is too fas
float MAX_MUSIC_RATE = 2;
//Acceleration rate, Controls the smoothness of the tension build-up
float MUSIC_ACCELERATION = 0.00006;

//=== Interface Management ===
GameMenu menu;
GameOverScreen gameOverScreen;


// === Game Status ===

   // Main Menu
  int STATE_MENU = 0;
  // Game in progress
  int STATE_PLAYING = 1;
  // Game over
  int STATE_GAME_OVER = 2;
  // Current default status
  int gameState = 0; 

// === Game Management ===

// Background starry sky effect, use array to call background planets, a total of 40
  Star[] stars = new Star[40];
  
  // Large ball array
  BBall[] Bballs = new BBall[0];
  // Small ball array
  SBall[] Sballs = new SBall[0];
  // Medium ball array
  MBall[] Mballs = new MBall[0];
  
  // Call spaceship
  spaceship spaceship;
  
 // Use arrayList to call bullets, and support multiple bullets at the same time 
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();


// === Game logic ===

//Collision detection, default is false
  boolean hit = false;
  //Game end, default is false
  boolean gameOver = false;
  //Ball update detection, default is true
  boolean ballUpdate = true;
  
  // === Game parameters ===
  
  //Player life is 3
  int lives = 3;
  //Control design interval
  int lastShotTime = 0;
  //Design cooling time to prevent shooting too fast
  int SHOOT_DELAY = 30;
  //Game timer, control generation difficulty, used for the difficulty increasing logic in createBall()
  int gameTimer = 0;
  //Player default score is 0, when player hit small ball add one.
  int score = 0;

void setup() {
  size(400, 400);
  
  //Initialize background effect
  for(int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  //Initialize game object
    spaceship = new spaceship();
    menu = new GameMenu();
    gameOverScreen = new GameOverScreen();
    
  //Load initial music file
  shootSound = new SoundFile(this, "shoot.wav"); 
  hitSound = new SoundFile(this, "hit.wav");
  menuMusic = new SoundFile(this, "menumusic.wav");
  battleMusic = new SoundFile(this, "battlemusic.wav");
  
  //Play background music when the game is enabled
  menuMusic.loop();
  
}


void draw() {
   background(28, 37, 60);
   
   //Continue to display the starry sky background, call the landing and display effects in star.pde
for(int i = 0; i < stars.length; i++) {
    stars[i].fall();
    stars[i].show();
  }
  
  //Display the corresponding game interface according to the status
  if (gameState == 0) {
    menu.display();
  } else if(gameState == 1) {
    runGame();
  } else if(gameState == 2) {
    runGame(); //Continue to run the game
    gameOverScreen.display(); //Overlay end page
  }
  
}

void runGame(){
  fill(255);
  textSize(16);
  
// Speed up the music only during normal gameplay, and stop speeding up when the game ends
    if(gameState == 1) {
    musicRate += MUSIC_ACCELERATION;
    musicRate = constrain(musicRate, 1, MAX_MUSIC_RATE);
    battleMusic.rate(musicRate);
  }
  
  // Display score
  textAlign(RIGHT, TOP);
  text("Score: " + score, width - 10, 10);
  
  //Increase the game timer for ball generation logic, createBall() use this to control the ball falling
  gameTimer++;
  
  //Update and display the spaceship
   spaceship.update();
   spaceship.display(lives);
   
   //Update all bullets and clear bullets that are out of the screen, to make sure the game is not lagging
   for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();
    
    //bullet will be remove when bullet is in y=-30
    if(b.position.y < -30) {
      bullets.remove(i);
    }
  }
  
  // each 120 frame create a ball
   if(frameCount % 120 == 0 && gameState == 1) {
    createBall();
  }
  
  //update and calulate the big ball Collision Detection, any type of ball hit the spaceship game over
  for(int i = 0 ; i < Bballs.length; i++) {
    Bballs[i].update();
    Bballs[i].display();
    if(Bballs[i].hits(spaceship)) {
      //when ball hits spaceship game state 2 (gameOver)
      gameState = 2;
  }
  }
  //update and calulate the medium ball
    for(int i = 0 ; i < Mballs.length; i++) {
    Mballs[i].update();
    Mballs[i].display();
    if(Mballs[i].hits(spaceship)) {
      gameState = 2;
    }
  }
  //update and calulate the small ball
  for(int i = 0 ; i < Sballs.length; i++) {
    Sballs[i].update();
    Sballs[i].display();
    if(Sballs[i].hits(spaceship)) {
      gameState = 2;
    }
  }
  //Handle collision detection and splitting logic between bullets and ball spheres
  bulletHit();
}


void bulletHit(){
  
//Iterate over all bullets and detect collisions with balls
    for(int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    //is bullet hit the ball? used to decide whether to remove the bullet
    boolean bulletHasHit = false;

//caluate the bullet hit the ball's Center and Redius
    float bulletCenterX = bullet.position.x + 5;
    float bulletCenterY = bullet.position.y + 15;
    float bulletRadius = 5; 

//caluate the big ball's collison, when big ball hit sphere to medium ball
    for(int j = Bballs.length - 1; j >= 0; j--) {
      BBall bball = Bballs[j]; 
      float distance = dist(bulletCenterX, bulletCenterY, bball.location.x, bball.location.y);
      
//when bullet hit the ball play hit sound
      if(distance < bulletRadius + (bball.size / 2)) {
        hitSound.play();
  
        //when big ball get hit trun into a new medium ball, Inherit speed
        MBall[] newMballs = new MBall[Mballs.length + 1];
        for(int k = 0; k < Mballs.length; k++) {
          newMballs[k] = Mballs[k];
        }
        MBall newBall = new MBall(bball.location.x, bball.location.y, bball.velocity);
        newMballs[newMballs.length - 1] = newBall;
        Mballs = newMballs;
        
        //remove hit ball's array
        BBall[] newBballs = new BBall[Bballs.length - 1];
        int tempIndex = 0;
        for(int k = 0; k < Bballs.length; k++) {
          if (k != j) {
            newBballs[tempIndex] = Bballs[k];
            tempIndex++;
          }
        }
        Bballs = newBballs;
        
        //when bullet hit target, jump out of the big ball's loop
        bulletHasHit = true;
        break; 
      }
    }

//if bullet has hit, remove the bullet and jump out the detenction
    if(bulletHasHit) {
      bullets.remove(i);
      continue;
    }
//caluate the Medium ball's collison, when Medium ball hit sphere to medium ball
    for(int j = Mballs.length - 1; j >= 0; j--) {
      MBall mball = Mballs[j];
      float distance = dist(bulletCenterX, bulletCenterY, mball.location.x, mball.location.y);
      if(distance < bulletRadius + (mball.size / 2)) {
        
        //when medium ball get hit trun into a new small ball, Inherit speed
        SBall[] newSballs = new SBall[Sballs.length + 1];
        for(int k = 0; k < Sballs.length; k++) {
          newSballs[k] = Sballs[k];
        }
        
        SBall newBall = new SBall(mball.location.x, mball.location.y, mball.velocity);
        newSballs[newSballs.length - 1] = newBall;
        Sballs = newSballs;
        
        hitSound.play();
        
        //remove hit ball's array
        MBall[] newMballs = new MBall[Mballs.length - 1];
        int tempIndex = 0;
        for(int k = 0; k < Mballs.length; k++) {
          if(k != j) {
            newMballs[tempIndex] = Mballs[k];
            tempIndex++;
          }
        }
        Mballs = newMballs;

        bulletHasHit = true;
        break;
      }
    }
    
    if(bulletHasHit) {
      bullets.remove(i);
      continue;
    }

//caluate the small ball hit, when player hit small ball get one point
    for (int j = Sballs.length - 1; j >= 0; j--) {
      SBall sball = Sballs[j];
      float distance = dist(bulletCenterX, bulletCenterY, sball.location.x, sball.location.y);
      if(distance < bulletRadius + (sball.size / 2)) {
        score += 1;
        
        hitSound.play();
        
        //remove small ball from array
        SBall[] newSballs = new SBall[Sballs.length - 1];
        int tempIndex = 0;
        for(int k = 0; k < Sballs.length; k++) {
          if(k != j) {
            newSballs[tempIndex] = Sballs[k];
            tempIndex++;
          }
        }
        Sballs = newSballs;

        bulletHasHit = true;
        break;
      }
    }
    
    if(bulletHasHit) {
      bullets.remove(i);
    }
  }
}

// accouding from ganeTimer's Dynamically adjust the ball generation type to achieve increasing difficulty
void createBall(){
  //use ArrayList to Convenient for dynamically adding elements and then converting back to an array
  ArrayList<SBall> slist = new ArrayList<SBall>();
  ArrayList<MBall> mlist = new ArrayList<MBall>();
  ArrayList<BBall> blist = new ArrayList<BBall>();
  
  //put all the ball into the array
  for(int i = 0; i < Sballs.length; i++){
    slist.add(Sballs[i]);
  }
  for(int i = 0; i < Mballs.length; i++){
    mlist.add(Mballs[i]);
  }
  for(int i = 0; i < Bballs.length; i++){
    blist.add(Bballs[i]);
  }


//at the beginnning of the 10 second create small ball only (for player to understand the game)
  if(gameTimer < 600){
    slist.add(new SBall());
  }
  //when game goes to 10-20 seconds add 1/2% to create small and medium ball
  else if(gameTimer < 1200){
    if(random(1) < 0.5){
      slist.add(new SBall());
    } else {
      mlist.add(new MBall());
    } 
  }
  //when game after 20 seconds add big ball, all ball goes to 1/3 randomly create
  else{
    float r = random(1); 

    if(r < 0.33) {
      slist.add(new SBall());
    }
    else if(r < 0.66){
      mlist.add(new MBall());
    }
    else{
      blist.add(new BBall());
    }
  }

//update array
  Sballs = slist.toArray(new SBall[0]);
  Mballs = mlist.toArray(new MBall[0]);
  Bballs = blist.toArray(new BBall[0]);
}

//reset the game state when game is over
void resetGame() {

  score = 0;
  lives = 3;
  //reset the timer, re-calulate everything
  gameTimer = 0;
  
  //reset everything, to make sure the game is not running when game reset
  Bballs = new BBall[0];
  Mballs = new MBall[0];
  Sballs = new SBall[0];
  bullets.clear();
  
  //spaceship back x=200
  spaceship.position.x = width/2;
  //back to state 1
  gameState = 1;
}

//===Control===

void mousePressed() {
  
  //during the game press left mouse button to shoot
  if(gameState == 1) {
  if(mouseButton == LEFT) {
    //calulate the shoting frame has pass to 30 frame, to make sure player can shooting once each time
    if (frameCount - 0 > 30) {
      //bullet create at the spaceship's position, to make sure the bullet is fired from the spaceship
     bullets.add(new Bullet(new PVector(spaceship.position.x -6, spaceship.position.y - 60)));
     //when shooting spaceship stop moving, until player released the mouse button, to make the game more intersting
    spaceship.canMove = false;
    shootSound.play();
    }
  }
  }
  //main menu, when player pressed the play button to start the game
      else if(gameState == 0) {
        //is calulate in the GameStart, does mouse hit the button?
        //if yes stop menu music and start battle music and game start.
    if(menu.mouseIsOverButton) {
      menuMusic.stop();
      musicRate = 1;
      battleMusic.loop(musicRate, 1, 0, 0);
      gameState = 1;
  }
}
  }


void mouseReleased() {
  //mouse released, when player stop shooting spaceship can move, same as mousePressed, Use with spaceship.canMove = false
  if(mouseButton == LEFT) {
    spaceship.canMove = true;
  }
}


void keyPressed() {
  //when player use A to move left, D to move right
  if(key == 'a' || key == 'A') spaceship.moveL = true;
  if(key == 'd' || key == 'D') spaceship.moveR = true;
  
  //if game is over, press R to restart the game
  else if(gameState == 2) {
    if(key == 'r' || key == 'R') {
      battleMusic.stop();
      //reset the game
      resetGame();
      //back to main menu, not the game, to make sure the player has time to perare
      gameState = 0; 
      menuMusic.loop();
    }
  }
}

void keyReleased(){
  // Stop the spaceship from moving (stop moving when the button is released)
// The false state of these boolean values will be checked in spaceship.update()
  if(key == 'a' || key == 'A') spaceship.moveL = false;
  if(key == 'd' || key == 'D') spaceship.moveR = false;
}
