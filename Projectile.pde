class Projectile {
  float x, y, vx, vy, dam, h;
  int type;
  int r;
  int recover;
  float rot;
  boolean explosive = false;

  Projectile(float ex, float why, float velx, float vely, float damn, float health, int typ, float _rot) {
    x = ex;
    y = why;
    vx = velx;
    vy = vely;
    dam = damn;
    h = health;
    type = typ;
    rot = _rot;
    if (type == 0) {
      r = 15;
    }
    if (type == 1) {
      r = 50;
    }
    if (type == 2) {
      r = 65;
    }
  }

  void display() {
    noStroke();

    if (type == 0) {
      pushMatrix();
      translate(x, y);
      rotate(rot);
      image(bullet, 0, 0, 1.5*r, 1.5*r);
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
  }

  void act() {
    x += timescale*vx;
    y += timescale*vy;
    collide();
    display();
    if (x < 0 || x > 2000 || y < 0 || y > 1500) {
      h = -1;
    }
  }

  void collide() {
    for (Balloon b : balloons) {
      if (dist(b.x, b.y, this.x, this.y) < 50 && recover <= 0) {

        if (b.recover <= 0 && !explosive) {

          b.h -= dam;

          h -= dam;
          b.recover = 5;
          recover = 1;
        }
        if (b.recover <= 0 && explosive) {


          explosions.add(new Explosion(x, y));
          h = 0;
          b.recover = 5;
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
    dur -= timescale*30;
    display();
  }
}