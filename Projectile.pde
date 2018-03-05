class Projectile {
  float x, y, vx, vy, dam, h;
  int type;
  int r;
  int recover;

  Projectile(float ex, float why, float velx, float vely, float damn, float health, int typ) {
    x = ex;
    y = why;
    vx = velx;
    vy = vely;
    dam = damn;
    h = health;
    type = typ;
    if (type == 0) {
      r = 15;
    }
  }

  void display() {
    noStroke();

    if (type == 0) {
      fill(0);
      ellipse(x, y, r, r);
    }
  }

  void act() {
    x += vx;
    y += vy;
    collide();
    display();
  }

  void collide() {
    for (Balloon b : balloons) {
      if (dist(b.x, b.y, this.x, this.y) < 50) {
        println("ye");
        if (b.recover == 0) {
          println("yeeee");
          b.h -= dam;
          println(b.h);
          h -= dam;
          b.recover = 5;
          recover = 1;
        }
      }
    }
    if(recover == 1){
      recover--;  
    }
  }

  boolean dead() {
    return h <= 0;
  }
}