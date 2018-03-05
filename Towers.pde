class Tower {
  float x, y;
  
  Tower(float ex, float why){
    x = ex;
    y = why;
  }
  
  void act(){
    
  }
  
}

class GunMonkey extends Tower {
  float x;
  float y;
  float reloadc = 50;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = 0;
  float shotspeed = 30;
  float range = 1300;

  GunMonkey(float ex, float why) {
    super(ex, why);
    x = ex;
    y = why;
    targ = new Pair(x, y);
    maxdist = 0;
    maxpos = 0;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(rot);
    rect(-25, -25, 50, 50);
    popMatrix();
    fill(0, 100);
    ellipse(x, y, range, range);
  }

  void getTarg() {

    maxdist = 0;
    maxpos = 0;
    for (int p = 0; p < balloons.length; p++) {
      if (dist(balloons[p].x, balloons[p].y, x, y) < range/2) { 
        if (sqrt(sq(balloons[p].distance.x)+sq(balloons[p].distance.y)) > maxdist) {
          maxdist = sqrt(sq(balloons[p].distance.x)+sq(balloons[p].distance.y));
          maxpos = p;
        }
      }
    }

    targ = new Pair(balloons[maxpos].x, balloons[maxpos].y);
    rot = predictTarg();
  }

  void shoot() {
    if (reload == 0) {
      proj.add(new Projectile(x, y, shotspeed*cos(rot), shotspeed*sin(rot), 6, 1, 0)); 
      reload = reloadc;
    }
    if (reload > 0) {
      reload--;
    }
  }

  boolean inRange() {
    for (Balloon b : balloons) {
      if (dist(b.x, b.y, x, y) < range/2) { 
        return true;
      }
    }
    return false;
  }
  
  float predictTarg(){
    float r = 0;
    Balloon targB = balloons[maxpos];
    float fx = targB.x + (3*targB.s*targB.dir.x);
    float fy = targB.y + (2*targB.s*targB.dir.y);
    r = atan2(fy-y, fx-x);
    
    return r;
  }

  void act() {
    if (balloons.length > 0) {
      if (inRange()) {
        getTarg();
        shoot();
      }
    }
    display();
  }
}