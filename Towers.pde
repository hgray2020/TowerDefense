/*

 New Tower Checklist:
 - Create class (duh)
 - Add image to images
 - Add to tows list
 - Add to buypanels class (UI tab)
 - Add to loadData 
 
 */





class Tower {
  float x;
  float y;
  float reloadc = 40;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = 0;
  float shotspeed = 30;
  float range;
  boolean saved = false, selected = true;

  Tower(float ex, float why) {
    x = ex;
    y = why;
  }

  String saveString() {
    return "HI";
  }

  String getName() {
    return "name";
  }

  void display() {
  }

  float getRange() {
    return range;
  }

  void getTarg() {

    maxdist = 0;
    maxpos = 0;
    for (int p = 0; p < balloons.length; p++) {
      if (dist(balloons[p].x, balloons[p].y, x, y) < range/2) { 
        if (balloons[p].distance.x+balloons[p].distance.y > maxdist) {
          maxdist = balloons[p].distance.x+balloons[p].distance.y;
          maxpos = p;
        }
      }
    }

    targ = new Pair(balloons[maxpos].x, balloons[maxpos].y);
    rot = predictTarg();
  }

  void shoot() {
    float[][] ro = rotMatrix(rot+HALF_PI);
    float[][] pos = {{35.0}, {-35.0}};
    float[][] temp = multiply(ro, pos);
    if (reload == 0) {
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 1, 1, 2, rot+HALF_PI)); 
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

  float predictTarg() {
    float r = 0;

    Balloon targB = balloons[maxpos];
    float frameTravel = dist(targB.x, targB.y, x, y)/shotspeed;
    float fx = targB.x + (frameTravel*targB.s*targB.dir.x);
    float fy = targB.y + (frameTravel*targB.s*targB.dir.y);
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
  void setselected() {
    selected = true;
  }
  boolean getSelected() {
    return selected;
  }
}

class GunMonkey extends Tower {
  float x;
  float y;
  float reloadc = 40;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = -HALF_PI;
  float shotspeed = 30;
  float range = 600;
  Pair offset = new Pair(35, -35);
  boolean cam = true;
  boolean saved = false, selected = true;
  String name = "Gun Monkey";

  GunMonkey(float ex, float why) {
    super(ex, why);
    x = ex;
    y = why;
    targ = new Pair(x, y);
    maxdist = 0;
    maxpos = 0;
  }
  boolean getSelected() {
    return selected;
  }
  float getRange() {
    return range;
  }
  String getName() {
    return name;
  }


  void display() {
    if (mouseX > x-50 && mouseX < x+50 && mouseY > y-50 && mouseY < y+50) {
      if (mousePressed) {
        selected = true; 
        sidescreen = 1;
      }
    } else {

      if (mousePressed && mouseX < 1900) {
        selected = false;
      }
    }
    if (selected) {
      sidescreen = 1;
      fill(0, 100);
      ellipse(x, y, range, range);
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(rot+HALF_PI);
    imageMode(CENTER);
    image(gunmonkey, 0, 0, 100, 100);

    popMatrix();
  }

  void getTarg() {

    maxdist = 0;
    maxpos = 0;
    for (int p = 0; p < balloons.length; p++) {
      if (dist(balloons[p].x, balloons[p].y, x, y) < range/2  && (cam || !cam && !balloons[p].cam)) { 
        if (balloons[p].distance.x+balloons[p].distance.y > maxdist) {
          maxdist = balloons[p].distance.x+balloons[p].distance.y;
          maxpos = p;
        }
      }
    }

    targ = new Pair(balloons[maxpos].x, balloons[maxpos].y);
    rot = predictTarg();
  }

  void shoot() {
    float[][] ro = rotMatrix(rot+HALF_PI);
    float[][] pos = {{offset.x}, {offset.y}};
    float[][] temp = multiply(ro, pos);
    if (reload <= 0) {
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 1, 1, 0, rot+HALF_PI)); 
      reload = reloadc;
    }
    if (reload > 0) {
      reload-=timescale;
    }
  }

  boolean inRange() {
    for (Balloon b : balloons) {
      if (dist(b.x, b.y, x, y) < range/2 && (cam || !cam && !b.cam)) { 
        return true;
      }
    }
    return false;
  }

  float predictTarg() {
    float r = 0;

    Balloon targB = balloons[maxpos];
    float frameTravel = (dist(targB.x, targB.y, x, y)/shotspeed)/timescale;
    float fx = targB.x + (frameTravel*targB.s*targB.dir.x);
    float fy = targB.y + (frameTravel*targB.s*targB.dir.y);
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
  String saveString() {
    saved = true;
    return (int)x+"-"+(int)y+"-00";
  }
  void setselected() {
    selected = true;
  }
}

class GodMonkey extends Tower {

  float x;
  float y;
  float reloadc = 2;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = 0;
  float shotspeed = 30;
  float range = 1200;
  Pair offset = new Pair(0, 0);
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "God Monkey";

  GodMonkey(float ex, float why) {
    super(ex, why);
    x = ex;
    y = why;
    targ = new Pair(x, y);
    maxdist = 0;
    maxpos = 0;
  }

  float getRange() {
    return range;
  }
  String getName() {
    return name;
  }
  boolean getSelected() {
    return selected;
  }

  void display() {
    if (mouseX > x-50 && mouseX < x+50 && mouseY > y-50 && mouseY < y+50) {
      if (mousePressed) {
        selected = true; 
        sidescreen = 1;
      }
    } else {

      if (mousePressed && mouseX < 1900) {
        selected = false;
      }
    }
    if (selected) {
      sidescreen = 1;
      fill(0, 100);
      ellipse(x, y, range, range);
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(rot+HALF_PI);
    imageMode(CENTER);
    image(godmonkey, 0, 0, 100, 100);

    popMatrix();
    fill(0, 100);
    // ellipse(x, y, range, range);
  }

  void getTarg() {

    maxdist = 0;
    maxpos = 0;
    for (int p = 0; p < balloons.length; p++) {
      if (dist(balloons[p].x, balloons[p].y, x, y) < range/2  && (cam || !cam && !balloons[p].cam)) { 
        if (balloons[p].distance.x+balloons[p].distance.y > maxdist) {
          maxdist = balloons[p].distance.x+balloons[p].distance.y;
          maxpos = p;
        }
      }
    }

    targ = new Pair(balloons[maxpos].x, balloons[maxpos].y);
    rot = predictTarg();
  }

  void shoot() {
    float[][] ro = rotMatrix(rot+HALF_PI);
    float[][] pos = {{offset.x}, {offset.y}};
    float[][] temp = multiply(ro, pos);
    if (reload <= 0) {
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 5, 5000, 1, rot+HALF_PI)); 
      reload = reloadc;
    }
    if (reload > 0) {
      reload-=timescale;
    }
  }

  boolean inRange() {
    for (Balloon b : balloons) {
      if (dist(b.x, b.y, x, y) < range/2 && (cam || !cam && !b.cam)) { 
        return true;
      }
    }
    return false;
  }

  float predictTarg() {
    float r = 0;

    Balloon targB = balloons[maxpos];
    float frameTravel = (dist(targB.x, targB.y, x, y)/shotspeed)/timescale;
    float fx = targB.x + (frameTravel*targB.s*targB.dir.x);
    float fy = targB.y + (frameTravel*targB.s*targB.dir.y);
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
  String saveString() {
    saved = true;
    return (int)x+"-"+(int)y+"-05";
  }
  void setselected() {
    selected = true;
  }
}

class Cannon extends Tower {
  float x;
  float y;
  float reloadc = 40;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = 0;
  float shotspeed = 30;
  float range = 800;
  Pair offset = new Pair(0, 0);
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "Cannon";

  Cannon(float ex, float why) {
    super(ex, why);
    x = ex;
    y = why;
    targ = new Pair(x, y);
    maxdist = 0;
    maxpos = 0;
  }


  float getRange() {
    return range;
  }
  String getName() {
    return name;
  }
  boolean getSelected() {
    return selected;
  }

  void display() {
    if (mouseX > x-50 && mouseX < x+50 && mouseY > y-50 && mouseY < y+50) {
      if (mousePressed) {
        selected = true; 
        sidescreen = 1;
      }
    } else {

      if (mousePressed && mouseX < 1900) {
        selected = false;
      }
    }
    if (selected) {
      sidescreen = 1;
      fill(0, 100);
      ellipse(x, y, range, range);
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(rot+HALF_PI);
    imageMode(CENTER);
    image(cannon, 0, 0, 100, 100);

    popMatrix();
    fill(0, 100);
    //ellipse(x, y, range, range);
  }

  void getTarg() {

    maxdist = 0;
    maxpos = 0;
    for (int p = 0; p < balloons.length; p++) {
      if (dist(balloons[p].x, balloons[p].y, x, y) < range/2  && (cam || !cam && !balloons[p].cam)) { 
        if (balloons[p].distance.x+balloons[p].distance.y > maxdist) {
          maxdist = balloons[p].distance.x+balloons[p].distance.y;
          maxpos = p;
        }
      }
    }

    targ = new Pair(balloons[maxpos].x, balloons[maxpos].y);
    rot = predictTarg();
  }

  void shoot() {
    float[][] ro = rotMatrix(rot+HALF_PI);
    float[][] pos = {{offset.x}, {offset.y}};
    float[][] temp = multiply(ro, pos);
    if (reload <= 0) {
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 1, 1, 2, rot+HALF_PI)); 
      reload = reloadc;
    }
    if (reload > 0) {
      reload-=timescale;
    }
  }

  boolean inRange() {
    for (Balloon b : balloons) {
      if (dist(b.x, b.y, x, y) < range/2 && (cam || !cam && !b.cam)) { 
        return true;
      }
    }
    return false;
  }

  float predictTarg() {
    float r = 0;

    Balloon targB = balloons[maxpos];
    float frameTravel = (dist(targB.x, targB.y, x, y)/shotspeed)/timescale;
    float fx = targB.x + (frameTravel*targB.s*targB.dir.x);
    float fy = targB.y + (frameTravel*targB.s*targB.dir.y);
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
  String saveString() {
    saved = true;
    return (int)x+"-"+(int)y+"-02";
  }
  void setselected() {
    selected = true;
  }
}

class GatMonkey extends Tower {
  float x;
  float y;
  float reloadc = 4;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = 0;
  float shotspeed = 30;
  float range = 800;
  Pair offset = new Pair(0, -40);
  boolean saved = false, selected = true;
  String name = "Gatling Monkey";

  GatMonkey(float ex, float why) {
    super(ex, why);
    x = ex;
    y = why;
    targ = new Pair(x, y);
    maxdist = 0;
    maxpos = 0;
  }

  float getRange() {
    return range;
  }
  String getName() {
    return name;
  }
  boolean getSelected() {
    return selected;
  }


  void display() {
    if (mouseX > x-50 && mouseX < x+50 && mouseY > y-100 && mouseY < y+100) {
      if (mousePressed) {
        selected = true; 
        sidescreen = 1;
      }
    } else {

      if (mousePressed && mouseX < 1900) {
        selected = false;
      }
    }
    if (selected) {
      sidescreen = 1;
      fill(0, 100);
      ellipse(x+20, y, 150, 150);
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(rot+HALF_PI);
    imageMode(CENTER);
    if ((frameCount%6) < 3) {
      image(gatmonkey, 0, -54, 100, 200);
    } else {
      image(gatmonkey2, 0, -54, 100, 200);
    }

    popMatrix();
    fill(0, 100);
    //ellipse(x, y, range, range);
  }

  void getTarg() {
    targ = new Pair(mouseX, mouseY);
    rot = atan2(targ.y-y, targ.x-x);
  }

  void shoot() {
    float[][] ro = rotMatrix(rot+HALF_PI);
    float[][] pos = {{offset.x}, {offset.y}};
    float[][] temp = multiply(ro, pos);
    if (reload <= 0) {
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 1, 1, 0, rot+HALF_PI)); 
      reload = reloadc;
    }
    if (reload > 0) {
      reload-=timescale;
    }
  }

  boolean inRange() {
    return true;
  }

  float predictTarg() {
    float r = 0;

    Balloon targB = balloons[maxpos];
    float frameTravel = (dist(targB.x, targB.y, x, y)/shotspeed)/timescale;
    float fx = targB.x + (frameTravel*targB.s*targB.dir.x);
    float fy = targB.y + (frameTravel*targB.s*targB.dir.y);
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
  String saveString() {
    saved = true;
    return (int)x+"-"+(int)y+"-04";
  }
  void setselected() {
    selected = true;
  }
}

class SniperMonkey extends Tower {
  float x;
  float y;
  float reloadc = 70;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = 0;
  float shotspeed = 30;
  float range = 800;
  Pair offset = new Pair(0, -40);
  boolean cam = true;
  boolean saved = false, selected = true;
  String name = "Sniper Monkey";

  SniperMonkey(float ex, float why) {
    super(ex, why);
    x = ex;
    y = why;
    targ = new Pair(x, y);
    maxdist = 0;
    maxpos = 0;
  }

  String getName() {
    return name;
  }
  float getRange() {
    return range;
  }
  boolean getSelected() {
    return selected;
  }


  void display() {
    if (mouseX > x-50 && mouseX < x+50 && mouseY > y-100 && mouseY < y+100) {
      if (mousePressed) {
        selected = true; 
        sidescreen = 1;
      }
    } else {

      if (mousePressed && mouseX < 1900) {
        selected = false;
      }
    }
    if (selected) {
      sidescreen = 1;
      fill(0, 100);
      ellipse(x+20, y, 150, 150);
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(rot+HALF_PI);
    imageMode(CENTER);
    image(snipermonkey, 0, -54, 100, 200);

    popMatrix();
    fill(0, 100);
    //ellipse(x, y, range, range);
  }

  void getTarg() {

    maxdist = 0;
    maxpos = 0;
    for (int p = 0; p < balloons.length; p++) {

      if (balloons[p].distance.x+balloons[p].distance.y > maxdist && (cam || !cam && !balloons[p].cam)) {
        maxdist = balloons[p].distance.x+balloons[p].distance.y;
        maxpos = p;
      }
    }

    targ = new Pair(balloons[maxpos].x, balloons[maxpos].y);
    rot = predictTarg();
  }

  void shoot() {

    if (reload <= 0) {
      //proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 5, 1, 0, rot+HALF_PI)); 
      balloons[maxpos].h -= 5;
      balloons[maxpos].recover = 5;
      reload = reloadc;
    }
    if (reload > 0) {
      reload-=timescale;
    }
  }

  boolean inRange() {
    return true;
  }

  float predictTarg() {
    float r = 0;

    Balloon targB = balloons[maxpos];
    float frameTravel = 1;
    float fx = targB.x + (frameTravel*targB.s*targB.dir.x);
    float fy = targB.y + (frameTravel*targB.s*targB.dir.y);
    r = atan2(fy-y, fx-x);
    shotspeed = dist(fx, fy, x, y);

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
  String saveString() {
    saved = true;
    return (int)x+"-"+(int)y+"-03";
  }
  void setselected() {
    selected = true;
  }
}

class SprayTower extends Tower {
  float x;
  float y;
  float reloadc = 40;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = 0;
  float shotspeed = 30;
  float range = 300;
  Pair offset = new Pair(0, 0);
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "Spray Tower";


  SprayTower(float ex, float why) {
    super(ex, why);
    x = ex;
    y = why;
    targ = new Pair(x, y);
    maxdist = 0;
    maxpos = 0;
  }


  float getRange() {
    return range;
  }
  String getName() {
    return name;
  }
  void setselected() {
    selected = true;
  }
  boolean getSelected() {
    return selected;
  }

  void display() {
    if (mouseX > x-50 && mouseX < x+50 && mouseY > y-50 && mouseY < y+50) {
      if (mousePressed) {
        selected = true; 
        sidescreen = 1;
      }
    } else {

      if (mousePressed && mouseX < 1900) {
        selected = false;
      }
    }
    if (selected) {
      sidescreen = 1;
      fill(0, 100);
      ellipse(x, y, range, range);
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(HALF_PI);
    imageMode(CENTER);
    if (reload/reloadc <= 0.2 && reload/reloadc >= 0.025) {
      image(spraytower2, 0, 0, 100, 100);
    } else {
      image(spraytower, 0, 0, 100, 100);
    }

    popMatrix();
    fill(0, 100);
    //ellipse(x, y, range, range);
  }

  void getTarg() {


    targ = new Pair(x, y);
  }

  void shoot() {
    float[][] ro = rotMatrix(rot+HALF_PI);
    float[][] pos = {{offset.x}, {offset.y}};
    float[][] temp = multiply(ro, pos);
    if (reload <= 0) {
      for (float i = 0; i < TWO_PI; i += (QUARTER_PI)) {
        proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(i), shotspeed*sin(i), 1, 1, 0, i+HALF_PI));

        reload = reloadc;
      }
    }
    if (reload > 0) {
      reload-=timescale;
    }
  }

  boolean inRange() {
    for (Balloon b : balloons) {
      if (dist(b.x, b.y, x, y) < range/2 && (cam || !cam && !b.cam)) { 
        return true;
      }
    }
    return false;
  }

  float predictTarg() {
    float r = 0;

    Balloon targB = balloons[maxpos];
    float frameTravel = (dist(targB.x, targB.y, x, y)/shotspeed)/timescale;
    float fx = targB.x + (frameTravel*targB.s*targB.dir.x);
    float fy = targB.y + (frameTravel*targB.s*targB.dir.y);
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

  String saveString() {
    saved = true;
    return (int)x+"-"+(int)y+"-01";
  }
}