import processing.sound.*;

SoundFile shootSound; 
SoundFile hitSound; 
SoundFile menuMusic; 
SoundFile battleMusic;

void setup() {
  size(400, 400);
  
  shootSound = new SoundFile(this, "shoot.wav"); 
  hitSound = new SoundFile(this, "hit.wav");
  menuMusic = new SoundFile(this, "menumusic.wav");
  battleMusic = new SoundFile(this, "battlemusic.wav");
  
  menuMusic.loop();
}


void draw(){
  background(28, 37, 60);
}
