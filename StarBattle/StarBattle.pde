import processing.sound.*;

SoundFile shootSound; 
SoundFile hitSound; 
SoundFile menuMusic; 
SoundFile battleMusic;

 Star[] stars = new Star[40];

void setup() {
  size(400, 400);
  
    for(int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  
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
}
