class Balloon {
  float x;
  float y;
  int l; //red, blue, green, yellow, pink, black or white, zebra (lead (99) goes to black but is the end of its own path), rainbow, ceramic
  int h;
  float s;
  Pair dir = new Pair(0, 0);
  int p;
  int popTime = 0;
  Pair distance = new Pair(0, 0);
  int recover = 0;
  boolean cam = false;
  int hitPoint = -1;

  Balloon(float ex, float why, int _l) {
    x = ex;
    y = why;
    l = _l;

    h = lhealth[l];

    s = (l+2);
  }

  Balloon(float ex, float why, int _l, Pair direction, Pair dist, int _h, boolean c) {
    x = ex;
    y = why;
    h = _h;
    l = _l;
    s = (l+2);
    dir = direction;
    distance = dist;
    cam = c;
  }

  Balloon(float ex, float why, int _l, boolean c) {
    x = ex;
    y = why;
    l = _l;

    h = lhealth[l];

    s = (l+2);
    cam = c;
  }

  void display() {
    getP();
    if (l < 4) {
      s = (l+2);
    } else if(l == 10){
      s = 4; 
    } else if(l == 7){
      s = 4; 
    } else {
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
    } else if (l == 7) {
      image(lead, x, y, 76, 95);
    } else if (l == 5) {
      fill(0);
      image(black, x, y, 52, 65);
    } else if (l == 6) {
      fill(220);
      image(white, x, y, 52, 65);
    } else if (l == 8) {
      image(zebra, x, y, 76, 95);
    } else if (l == 9) {
      image(rainbow, x, y, 76, 95);
    } else if (l == 10) {
      if (h >= 30) {
        image(ceramic1, x, y, 76, 95);
      }
      if (h <= 29 && h >= 20) {
        image(ceramic2, x, y, 76, 95);
      }
      if (h <= 19 && h >= 14) {
        image(ceramic3, x, y, 76, 95);
      }
      if (h <= 13) {
        image(ceramic4, x, y, 76, 95);
      }
    }

    if (cam) {
      if (l < 5) {
        image(camo, x, y, 52+(l*8), 65+(l*10));
      } else if (l == 5 || l == 6) {
        image(camo, x, y, 52, 65);
      } else if (l > 6) {

        image(camo, x, y, 76, 95);
      }
    }
  }
  void move() {
    if (x < -50 || x > 2050 || y < -50 || y > 1550) {
      l = -1;
    }
    boolean b = true;
    for (Point p : paths[pathOn].points) {
      if (dist(this.x, this.y, p.x, p.y) < 8 && hitPoint < p.p) {
        dir = p.dir;
        hitPoint = p.p;

        x = p.x;
        y = p.y;
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

      if (dist(x, y, e.x, e.y) < (0.4)*(e.durmax-e.dur) && recover <= 0 && l != 5) {
        h -= 3;
        recover = 5;
      }
    }
    if (l > 0) {
      if (h <= lhealth[l-1]) {
        popTime = 6;
        if (l == 8) {
          balloons = (Balloon[])append(balloons, new Balloon(x-(4*dir.x), y-(4*dir.y), 5, dir, distance, h, cam));
        }
        if (l != leadL &&  l != 6 && l != 8) {
          l--;
        } else {
          if (l == leadL) {
            l = 5;
          } else if (l == 6) {
            l = 4;
          } else if (l == 8) {
            l = 6;
          }
        }
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