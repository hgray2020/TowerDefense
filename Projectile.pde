class Projectile {
  float x, y, vx, vy, dam, h;
  int type;
  int r;
  int recover;
  float rot;
  boolean explosive = false;
  boolean enteredPath = false;
  boolean hitPoint = false;
  float d = 180, rad = 100;
  Pair targ = new Pair(0, 0);
  boolean lead; //can pop lead


  Projectile(float ex, float why, float velx, float vely, float damn, float health, int typ, float _rot, float _d) {
    x = ex;
    y = why;
    vx = velx;
    vy = vely;
    dam = damn;
    h = health;
    type = typ;
    rot = _rot;
    d = _d;


    targ = new Pair(ex+(rad*cos(rot-HALF_PI)), why+(rad*sin(rot-HALF_PI))); 
    if (type == 0) {
      r = 15;
    }
    if (type == 1) {
      r = 50;
      lead = true;
    }
    if (type == 2) {
      r = 65;
    }
    if (type == 3) {
      r = 50;
      lead = true;
    }
    if (type == 4) {
      lead = true;
      r = 30;
    }
    if (type == 5) {
      r = 35;
    }
    if (type == 6) {
      r = 50;
    }
  }

  void display() {
    noStroke();

    if (type == 0) {

      pushMatrix();
      translate(x, y);
      rotate(rot);
      image(bullet, 0, 0, 2*r, 2*r);
      popMatrix();
    }
    if (type == 1) {
      fill(0, 30, 200, 200);
      ellipse(x, y, r, r); 
      fill(255, 200);
      ellipse(x, y, 0.75*r, 0.75*r);
      fill(255, 200);
      ellipse(x, y, 0.5*r, 0.5*r);
    }
    if (type == 2) {
      explosive = true;
      fill(0);
      noStroke();
      ellipse(x, y, r, r);
    }
    if (type == 3) {
      fill(255, 255, 117, 200);
      ellipse(x, y, r, r); 
      fill(255, 200);
      ellipse(x, y, 0.75*r, 0.75*r);
      fill(255, 200);
      ellipse(x, y, 0.5*r, 0.5*r);
    }
    if (type == 4) {
      pushMatrix();
      translate(x, y);
      rotate(rot);
      stroke(179, 67, 0, 200);
      strokeWeight(20);

      line(-(r/2), -(r/2), -(r/2), (r/2)); 
      line((r/2), -(r/2), (r/2), (r/2)); 
      stroke(255, 144, 77, 200);
      strokeWeight(15);
      line(-(r/2), -(r/2), -(r/2), (r/2)); 
      line((r/2), -(r/2), (r/2), (r/2)); 
      stroke(255, 200);
      strokeWeight(10);
      line(-(r/2), -(r/2), -(r/2), (r/2)); 
      line((r/2), -(r/2), (r/2), (r/2)); 
      popMatrix();
    }
    if (type == 5) {
      fill(0);
      noStroke();
      ellipse(x, y, r, r);
    }
    if (type == 6) {
      fill(0);
      noStroke();
      pushMatrix();
      translate(x, y);
      rotate(d*10);
      image(boomerang, 0, 0, r, r);
      popMatrix();
    }
  }

  void act() {
    if (type != 5 && type != 6) {
      x += timescale*vx;
      y += timescale*vy;
    } else {
      if (type == 5) {
        if (!paths[pathOn].pointInPath(new Pair(x, y), 20)) {
          x += timescale*vx;
          y += timescale*vy;
        } else {

          if (enteredPath == false) {
            vx = -4*paths[pathOn].nearestPoint(new Pair(x, y)).dir.x;
            vy = -4*paths[pathOn].nearestPoint(new Pair(x, y)).dir.y;

            enteredPath = true;
          }
          if (enteredPath) {
            for (int i = 0; i < paths[pathOn].points.length; i++) {
              Point p = paths[pathOn].points[i];
              if (i == 0) {
                fill(0, 100);
                ellipse(p.x, p.y, 50, 50);
              }
              if (!hitPoint) {
                if (dist(this.x, this.y, p.x, p.y) < 25) {
                  if (!hitPoint) {
                    this.x = p.x;
                    this.y = p.y;
                  }
                  hitPoint = true;
                  if (i > 0) {
                    vx = -4*paths[pathOn].points[i-1].dir.x;
                    vy = -4*paths[pathOn].points[i-1].dir.y;
                  } else {
                    health = -1;
                  }
                  //if (i > 0) {
                  //  r+=1;

                  //  vx = -4*paths[pathOn].points[i-1].dir.x;
                  //  vy = -4*paths[pathOn].points[i-1].dir.y;
                  //} else {
                  //  health = 0;
                  //}
                }
              } else {
                if (dist(this.x, this.y, p.x, p.y) < 8) {
                  if (i > 0) {
                    vx = -4*paths[pathOn].points[i-1].dir.x;
                    vy = -4*paths[pathOn].points[i-1].dir.y;
                  } else {
                    health = -1;
                  }
                }
              }
              //vx = -4*paths[pathOn].nearestPoint(new Pair(x, y)).dir.x;
              //vy = -4*paths[pathOn].nearestPoint(new Pair(x, y)).dir.y;
            }
          }
          x += timescale*vx;
          y += timescale*vy;
        }
      }
      if (type == 6) {
        if (d >= 540) {
          h = -1;
        }
        x = targ.x+(rad*cos(radians(d)));
        y = targ.y+(rad*sin(radians(d)));

        d+=10*timescale;
      }
    }
    collide();
    display();
    if (x < 0 || x > 2000 || y < 0 || y > 1500) {
      h = -1;
    }
  }

  void collide() {
    for (Balloon b : balloons) {
      boolean hitLead = false;
      if (b.l == 7 && lead) {
        hitLead = true;
      } 
      if (b.l != 7) {
        hitLead = true;
      }
      if (dist(b.x, b.y, this.x, this.y) < 50 && recover <= 0) {

        if (b.recover <= 0 && !explosive) {

          if (hitLead) {
            b.h -= dam;
            b.recover = 5;
          }

          h -= dam;

          recover = 1;
        }
        if (b.recover <= 0 && explosive) {


          explosions.add(new Explosion(x, y));
          h = 0;
          b.recover = 0;
        }
      }
    }
    if (recover == 1) {
      recover--;
    }
  }

  boolean dead() {
    return h <= 0;
  }
}

class Explosion {
  float x, y;
  int dur;
  int durmax = 300;

  Explosion(float ex, float why) {
    dur = durmax;
    x = ex;
    y = why;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    image(explosion, 0, 0, durmax-dur, durmax-dur);
    popMatrix();
  }

  void act() {
    dur -= timescale*60;
    display();
  }
}

class Lightning {
  Pair[] points;
  int recover = 0;
  int dam = 3;
  int durc = 5;
  int dur = durc;



  Lightning(Pair[] pnts) {
    points = pnts;
  }

  void display() {

    for (int i = 0; i < points.length-1; i++) {

      strokeWeight(20);
      stroke(184, 114, 255, 130);
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
      strokeWeight(10);
      stroke(230, (1.0*dur/durc)*255);
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
    }
  }

  void collide() {
    for (Balloon b : balloons) {
      for (Pair p : points) {
        if (dist(b.x, b.y, p.x, p.y) < 50 && recover <= 0) {

          if (b.recover <= 0) {

            b.h -= dam;


            b.recover = 5;
          }
        }
      }
    }
    if (recover == 1) {
      recover--;
    }
    dur-=timescale;
  }

  void act() {
    display();
    collide();
  }

  boolean dead() {
    return dur <= 0;
  }
}