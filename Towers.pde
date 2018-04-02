/*

 New Tower Checklist:
 - Create class (duh)
 - Add image to images
 - Add to tows list
 - Add to buypanels class (UI tab)
 - Add to loadData 
 - Add image to to menu
 
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
  boolean cam;
  boolean saved = false, selected = true;
  UpPair[] pairs = {new UpPair("Increases Range", 150, "00-1.2"), new UpPair("Can See Camo", 175, "01-01"), new UpPair("Attacks faster", 275, "02-1.2"), new UpPair("Pops More layers", 250, "03-02")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attack = 1;
  boolean spray;

  Tower(float ex, float why) {
    x = ex;
    y = why;
  }

  void setSpray() {
    spray = true;
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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
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
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 1, 1, 2, rot+HALF_PI, 0)); 
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
  void setUpOn(int u) {
    upgrades.upOn = u;
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
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "Gun Monkey";
  UpPair[] pairs = {new UpPair("Increases Range", 150, "00-1.2"), new UpPair("Can See Camo", 175, "01-01"), new UpPair("Attacks faster", 275, "02-1.2"), new UpPair("Pops More layers", 250, "03-02")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attack = 1;

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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
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
      upgrades.display();
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
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 1, 1, 0, rot+HALF_PI, 0)); 
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
    String s = "0";
    if (cam) {
      s = "0";
    }
    return (int)x+"-"+(int)y+"-00-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn;
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
  float range = 800;
  Pair offset = new Pair(0, 0);
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "God Monkey";
  UpPair[] pairs = {new UpPair("Global Range", 1150, "00-1.9"), new UpPair("Lazer Vision", 2700, "03-05"), new UpPair("Plasma Balls", 3500, "03-05"), new UpPair("The True God", 6000, "03-05")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attackc = 1;
  int attack = attackc;


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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
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
      upgrades.display();
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
      if (attack == attackc) {
        proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), attack, 5000, 0, rot+HALF_PI, 0));
      }
      if (attack == attackc+5) {
        proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), attack, 5000, 4, rot+HALF_PI, 0));
      }
      if (attack == attackc+10) {
        proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), attack, 5000, 1, rot+HALF_PI, 0));
      }
      if (attack == attackc+15) {
        proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), attack, 5000, 3, rot+HALF_PI, 0));
      }
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
    String s = "0";
    if (cam) {
      s = "0";
    }
    return (int)x+"-"+(int)y+"-05-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn;
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
  float range = 450;
  Pair offset = new Pair(0, 0);
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "Cannon";
  UpPair[] pairs = {new UpPair("Increases Range", 300, "00-1.2"), new UpPair("MAX Range", 550, "00-1.2"), new UpPair("Attacks faster", 275, "02-1.2"), new UpPair("Super Speed", 800, "02-1.5")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attack = 1;

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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
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
      upgrades.display();
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
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), attack, 1, 2, rot+HALF_PI, 0)); 
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
    String s = "0";
    if (cam) {
      s = "0";
    }
    return (int)x+"-"+(int)y+"-02-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn;
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
  boolean cam = false;
  UpPair[] pairs = {new UpPair("Fast barrel spin", 600, "02-1.5"), new UpPair("Faster darts", 1050, "02-1.5"), new UpPair("Pops more layers", 1200, "03-01"), new UpPair("Balloon shredder", 2500, "03-03")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attack = 1;

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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
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
      upgrades.display();
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
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), attack, 5000, 0, rot+HALF_PI, 0)); 
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
    if (playing) {
      if (inRange()) {
        getTarg();
        shoot();
      }
    }

    display();
  }
  String saveString() {
    saved = true;
    String s = "0";
    if (cam) {
      s = "0";
    }
    return (int)x+"-"+(int)y+"-04-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn;
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
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "Sniper Monkey";
  UpPair[] pairs = {new UpPair("Faster Reload", 350, "02-2"), new UpPair("Night Vision", 175, "01-01"), new UpPair("Layer Demolisher", 275, "03-36"), new UpPair("Hyper Speed", 250, "02-3.5")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attack = 1;
  float tx, ty;

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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
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
      upgrades.display();
    }
    pushMatrix();
    if(tx != 0){
      translate(tx, ty);
    } else {
      translate(x, y);  
    }
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
      balloons[maxpos].h -= attack;
      balloons[maxpos].recover = 5;
      reload = reloadc;
      tx = x-(15*cos(rot));
      ty = y-(15*sin(rot));
    }
    if(reload < reloadc*0.95){
      tx = 0;
      ty = 0;
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
    String s = "0";
    if (cam) {
      s = "0";
    }
    return (int)x+"-"+(int)y+"-03-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn;
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
  UpPair[] pairs = {new UpPair("Bigger Range", 150, "00-1.2"), new UpPair("Extra Attack Speed", 175, "02-1.2"), new UpPair("Pops more layers", 275, "03-02"), new UpPair("Fires twice the bullets", 250, "04-01")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);

  int attack = 1;
  boolean spray;


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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
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
      upgrades.display();
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
      if (!spray) {
        for (float i = 0; i < TWO_PI; i += (QUARTER_PI)) {
          proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(i), shotspeed*sin(i), attack, 1, 0, i+HALF_PI, 0));

          reload = reloadc;
        }
      } else {
        for (float i = 0; i < TWO_PI; i += (QUARTER_PI/2)) {
          proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(i), shotspeed*sin(i), attack, 1, 0, i+HALF_PI, 0));

          reload = reloadc;
        }
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
    String s = "0";
    if (cam) {
      s = "0";
    }
    String str = "0";
    if (spray) {
      str = "1";
    }
    return (int)x+"-"+(int)y+"-01-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn+"-"+str;
  }
  void setSpray() {
    spray = true;
  }
}

class BoomerangMonkey extends Tower {
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
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "Boomerang Monkey";
  UpPair[] pairs = {new UpPair("Increases Range", 150, "00-1.2"), new UpPair("Can See Camo", 175, "01-01"), new UpPair("Attacks faster", 275, "02-1.2"), new UpPair("Pops More layers", 250, "03-02")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attack = 1;

  BoomerangMonkey(float ex, float why) {
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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
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
      upgrades.display();
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(rot+HALF_PI);
    imageMode(CENTER);
    image(boomerangmonkey, 0, 0, 100, 100);

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
      proj.add(new Projectile(x+temp[0][0], y+temp[1][0], shotspeed*cos(rot), shotspeed*sin(rot), 1, 50, 6, rot+HALF_PI, 180)); 

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
    String s = "0";
    if (cam) {
      s = "0";
    }
    return (int)x+"-"+(int)y+"-06-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn;
  }
  void setselected() {
    selected = true;
  }
}

class WizardMonkey extends Tower {
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
  boolean cam = false;
  boolean saved = false, selected = true;
  String name = "Wizard Monkey";
  UpPair[] pairs = {new UpPair("Increases Range", 150, "00-1.2"), new UpPair("Can See Camo", 175, "01-01"), new UpPair("Attacks faster", 275, "02-1.2"), new UpPair("Pops More layers", 250, "03-02")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attack = 1;
  Pair[] ltarg = new Pair[4];

  WizardMonkey(float ex, float why) {
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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
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
      upgrades.display();
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
    rotate(rot+HALF_PI);
    imageMode(CENTER);
    image(wizardmonkey, 0, 0, 100, 100);


    popMatrix();
    fill(0);
    for (Pair p : ltarg) {
      //ellipse(p.x, p.y, 100, 100);
    }
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
      bolts.add(new Lightning(ltarg)); 
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
    int rad = 100;
    Balloon targB = balloons[maxpos];
    float frameTravel = 1;
    float fx = targB.x + (frameTravel*targB.s*targB.dir.x);
    float fy = targB.y + (frameTravel*targB.s*targB.dir.y);
    r = atan2(fy-y, fx-x);
    for (int i = 0; i < ltarg.length; i++) {
      if (i == 0) {
        ltarg[i] = new Pair(x, y);
      } else if (i == 1) {
        ltarg[i] = new Pair(targB.x, targB.y);
      } else {
        ltarg[i] = new Pair(ltarg[i-1].x+(rad*cos( (acos(-1*targB.dir.x))+radians(random(-20, 20)))), ltarg[i-1].y+(rad*sin((asin(-1*targB.dir.y))+radians(random(-20, 20)))));
      }
    }
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
    String s = "0";
    if (cam) {
      s = "0";
    }
    return (int)x+"-"+(int)y+"-07-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn;
  }
  void setselected() {
    selected = true;
  }
}

class PlaneMonkey extends Tower {
  float x;
  float y;
  float px;
  float py;
  float prot;
  float reloadc = 70;
  float reload = reloadc;
  Pair targ;
  float maxdist;
  int maxpos;
  float rot = 0;
  float shotspeed = 30;
  float range = 80;
  Pair offset = new Pair(0, 0);
  boolean saved = false, selected = true;
  String name = "Plane Monkey";
  boolean cam = false;
  UpPair[] pairs = {new UpPair("Faster Reload", 350, "02-1.5"), new UpPair("Dart Storm", 175, "04-01"), new UpPair("Attacks faster", 275, "02-1.2"), new UpPair("Pops More layers", 250, "03-02")};
  UpPanel upgrades = new UpPanel(new UpPath(pairs), this, 0);
  int attack = 3;
  int rad = 300;
  int d = 0;
  boolean spray = false;

  PlaneMonkey(float ex, float why) {
    super(ex, why);
    x = ex;
    y = why;
    px = x;
    py = y;
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
  void setRange(float r) {
    range = r;
  }
  void setCamo(boolean c) {
    cam = c;
  }
  float getReload() {
    return reloadc;
  }
  void setReload(int r) {
    reloadc = r;
  }
  void setAttack(int a) {
    attack = a;
  }
  int getAttack() {
    return attack;
  }
  void setUpOn(int u) {
    upgrades.upOn = u;
  }
  void setSpray(){
    spray = true;  
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
      ellipse(x, y, 150, 150);
      upgrades.display();
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    noStroke();
   
    imageMode(CENTER);
    rectMode(CENTER);
    rect(0, 0, 100, 100);
    rectMode(CORNER);

    popMatrix();
    fill(0, 100);
    pushMatrix();
    translate(px, py);
    rotate(radians(d)+PI);
    if(frameCount%12 <= 5){
      image(planemonkey, 0, 0, 300, 300);
    } else {
      image(planemonkey2, 0, 0, 300, 300);  
    }
    popMatrix();
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
      if (!spray) {
        for (float i = 0; i < TWO_PI; i += (QUARTER_PI/2)) {
          proj.add(new Projectile(px+temp[0][0], py+temp[1][0], shotspeed*cos(i), shotspeed*sin(i), attack, 1, 0, i+HALF_PI, 0));

          reload = reloadc;
        }
      } else {
        for (float i = 0; i < TWO_PI; i += (QUARTER_PI/4)) {
          proj.add(new Projectile(px+temp[0][0], py+temp[1][0], shotspeed*cos(i), shotspeed*sin(i), attack, 1, 0, i+HALF_PI, 0));

          reload = reloadc;
        }
      }
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
    px = x+(rad*cos(radians(d)));
    py = y+(rad*sin(radians(d)));
    d+=2*timescale;
    if (playing) {
      if (inRange()) {
        getTarg();
        shoot();
      }
    }

    display();
  }
  String saveString() {
    saved = true;
    String s = "0";
    if (cam) {
      s = "0";
    }
    String str = "0";
    if (spray) {
      str = "1";
    }
    return (int)x+"-"+(int)y+"-08-"+range+"-"+s+"-"+attack+"-"+reloadc+"-"+upgrades.upOn+"-"+str;
  }
  void setselected() {
    selected = true;
  }
}