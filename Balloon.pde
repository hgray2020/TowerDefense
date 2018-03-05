class Balloon {
  float x;
  float y;
  int l;
  int h;
  float s;
  Pair dir = new Pair(0, 0);
  int p;
  int popTime = 0;
  Pair distance = new Pair(0, 0);
  int recover = 0;
  
  Balloon(float ex, float why, int _l) {
    x = ex;
    y = why;
    l = _l;
    h = lhealth[l];
    s = (l+2);
    
  }

  void display() {
    getP();
    noStroke();
    imageMode(CENTER);
    if (l == 0) {
      image(red, x, y, 52, 65);
    } else if (l == 1) {
      image(blue, x, y, 60, 75);
    } else if (l == 2) {
      image(green, x, y, 68, 85);
    }
    
  }
  void move() {
    for (Point p : paths[pathOn].points) {
      if (dist(this.x, this.y, p.x, p.y) < 4) {
        dir = p.dir;
        if(p.be == 2){
          health--;
          l = -1;
        }
        
      }
    }
    x += (s*dir.x);
    y += (s*dir.y);
    distance.x += (s*dir.x);
    distance.y += (s*dir.y);
  }
  
  void think(){
    if(l > 0){
      if(h <= lhealth[l-1]){
         popTime = 6;
         
         
         l--; 
         
      }
    }
    if(l == 0){
      if(h <= 0){
         popTime = 6;
         
         
         l--; 
         h = l+1;
      }
    }
    if(recover > 0){
     recover--; 
    }
    if(popTime > 0){
     pop(); 
    }
    
  }
  
  void pop(){
    image(pop, x+5, y+25, 150, 150);
    popTime--;
  }
  
  void act() {
     display();
    think();
    move();
   
  }
  
  void getP() {
    for (int i = 0; i < balloons.length; i++) {
      if (balloons[i].x == this.x && balloons[i].y == this.y && this.l == balloons[i].l) {
        p = i;
      }
    }
  }
}