class Star {
   PVector location = new PVector (random(width), random(-height, 0));
   float size = random (10, 30);
   float dropspeed = size * 0.013;
   
   void fall() {
     location.y = location.y + dropspeed;
   }
   
   void show(){
     fill(255);
      circle(location.x, location.y, size);
          if (location.y > height + size) {
        location.y = random(-200, -100);
    }
  }
}
