import processing.sound.*;

SoundFile shootSound; 
SoundFile hitSound; 
SoundFile menuMusic; 
SoundFile battleMusic;

float musicRate = 1;
float MAX_MUSIC_RATE = 2;
float MUSIC_ACCELERATION = 0.00006;

GameMenu menu;
GameOverScreen gameOverScreen;


  int STATE_MENU = 0;
  int STATE_PLAYING = 1;
  int STATE_GAME_OVER = 2;
  int gameState = 0; 
  
    Star[] stars = new Star[40];
  
  BBall[] Bballs = new BBall[0];
  SBall[] Sballs = new SBall[0];
  MBall[] Mballs = new MBall[0];
  
  spaceship spaceship;
  
    ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  boolean hit = false;
  boolean gameOver = false;
  boolean ballUpdate = true;
  
  
    int lives = 3;
  int lastShotTime = 0;
  int SHOOT_DELAY = 30;
  int gameTimer = 0;
  int score = 0;
  
void setup() {
  size(400, 400);
  
    for(int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
    spaceship = new spaceship();
    menu = new GameMenu();
    gameOverScreen = new GameOverScreen();
  
  shootSound = new SoundFile(this, "shoot.wav"); 
  hitSound = new SoundFile(this, "hit.wav");
  menuMusic = new SoundFile(this, "menumusic.wav");
  battleMusic = new SoundFile(this, "battlemusic.wav");
  
  menuMusic.loop();
}


void draw(){
  background(28, 37, 60);
  
  for(int i = 0; i < stars.length; i++) {
    stars[i].fall();
    stars[i].show();
  }
    if (gameState == 0) {
    menu.display();
  } else if(gameState == 1) {
    runGame();
  } else if(gameState == 2) {
    runGame();
    gameOverScreen.display();
  }
  
}

void runGame(){
  fill(255);
  textSize(16);
  
    if(gameState == 1) {
    musicRate += MUSIC_ACCELERATION;
    musicRate = constrain(musicRate, 1, MAX_MUSIC_RATE);
    battleMusic.rate(musicRate);
  }
  
    textAlign(RIGHT, TOP);
  text("Score: " + score, width - 10, 10);
  
  
  gameTimer++;
  
   spaceship.update();
   spaceship.display(lives);
   
      for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();
    
    if(b.position.y < -30) {
      bullets.remove(i);
    }
  }
  
     if(frameCount % 120 == 0 && gameState == 1) {
    createBall();
  }
  
    for(int i = 0 ; i < Bballs.length; i++) {
    Bballs[i].update();
    Bballs[i].display();
    if(Bballs[i].hits(spaceship)) {
      gameState = 2;
  }
  }
  
      for(int i = 0 ; i < Mballs.length; i++) {
    Mballs[i].update();
    Mballs[i].display();
    if(Mballs[i].hits(spaceship)) {
      gameState = 2;
    }
  }
  
    for(int i = 0 ; i < Sballs.length; i++) {
    Sballs[i].update();
    Sballs[i].display();
    if(Sballs[i].hits(spaceship)) {
      gameState = 2;
    }
  }
  
    bulletHit();
}


void bulletHit(){
  
    for(int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    boolean bulletHasHit = false;
    
    float bulletCenterX = bullet.position.x + 5;
    float bulletCenterY = bullet.position.y + 15;
    float bulletRadius = 5; 
    
    for(int j = Bballs.length - 1; j >= 0; j--) {
    BBall bball = Bballs[j]; 
    float distance = dist(bulletCenterX, bulletCenterY, bball.location.x, bball.location.y);
    
    
    if(distance < bulletRadius + (bball.size / 2)) {
    hitSound.play();
    
    
    MBall[] newMballs = new MBall[Mballs.length + 1];
        for(int k = 0; k < Mballs.length; k++) {
          newMballs[k] = Mballs[k];
        }
        MBall newBall = new MBall(bball.location.x, bball.location.y, bball.velocity);
        newMballs[newMballs.length - 1] = newBall;
        Mballs = newMballs;
        
        BBall[] newBballs = new BBall[Bballs.length - 1];
        int tempIndex = 0;
        for(int k = 0; k < Bballs.length; k++) {
          if (k != j) {
            newBballs[tempIndex] = Bballs[k];
            tempIndex++;
          }
        }
        Bballs = newBballs;
        
        bulletHasHit = true;
        break;
      }
    }

    if(bulletHasHit) {
      bullets.remove(i);
      continue;
    }
