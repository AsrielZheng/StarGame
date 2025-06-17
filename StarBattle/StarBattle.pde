import processing.sound.*;

SoundFile shootSound; 
SoundFile hitSound; 
SoundFile menuMusic; 
SoundFile battleMusic;

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
}
