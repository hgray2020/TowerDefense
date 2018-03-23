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
  boolean cam = false;

  Balloon(float ex, float why, int _l) {
    x = ex;
    y = why;
    l = _l;
    h = lhealth[l];
    s = (l+2);
  }

  void display() {
    getP();
    if (l < 4) {
      s = (l+2);
    }
    if (l == 4) {
      s = 7;
    }
    noStroke();
    imageMode(CENTER);
    if (l == 0) {
      image(red, x, y, 52, 65);
    } else if (l == 1) {
      image(blue, x, y, 60, 75);
    } else if (l == 2) {
      image(green, x, y, 68, 85);
    } else if (l == 3) {
      image(yellow, x, y, 76, 95);
    } else if (l == 4) {
      image(pink, x, y, 84, 105);
    }

    if (cam) {
      image(camo, x, y, 52+(l*8), 65+(l*10));
    }
  }
  void move() {
    for (Point p : paths[pathOn].points) {
      if (dist(this.x, this.y, p.x, p.y) < 20) {
        dir = p.dir;
        if (p.be == 2) {
          health-=(l+1);
          l = -1;
        }
      }
    }
    x += timescale*(s*dir.x);
    y += timescale*(s*dir.y);
    distance.x += timescale*Math.abs(s*dir.x);
    distance.y += timescale*Math.abs(s*dir.y);
  }

  void think() {
    for (Explosion e : explosions) {
      if (dist(x, y, e.x, e.y) < (0.4)*(e.durmax-e.dur) && recover <= 0) {
        h -= 3;
        recover = 10;
      }
    }
    if (l > 0) {
      if (h <= lhealth[l-1]) {
        popTime = 6;


        l--;
      }
    }
    if (l == 0) {
      if (h <= 0) {
        popTime = 6;


        l--; 
        h = l+1;
        money+=1;
      }
    }
    if (recover > 0) {
      recover-=timescale;
    }
    if (popTime > 0) {
      pop();
    }
  }

  void pop() {
    pushMatrix();
    translate(x+5, y+25);
    rotate(random(0, TWO_PI));
    image(pop, 0, 0, 150, 150);

    popMatrix();
    popTime-=timescale;
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