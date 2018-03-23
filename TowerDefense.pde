String[] lvlOne = {"020-00-25"};
String[] lvlTwo = {"020-00-25", "010-00-15"};
String[] lvlThree = {"030-00-25", "015-01-30"};
int lvlOn = 0;
String[][] lvls = {lvlOne, lvlTwo, lvlThree};

PrintWriter output;
PrintWriter output2;

boolean playing;
boolean spawnDone = false;

int sidescreen = 0;
Tower[] tows = {new GunMonkey(0, 0), new SprayTower(0, 0), new Cannon(0, 0), new SniperMonkey(0, 0), new GatMonkey(0, 0), new GodMonkey(0, 0)};
int towerTypes = tows.length;



BuyPanel[] bpanels = {new BuyPanel(1937.5, 0, 0, 300), new BuyPanel(2112.5, 0, 1, 350), new BuyPanel(1937.5, 175, 2, 450), new BuyPanel(2112.5, 175, 3, 800), new BuyPanel(1937.5, 350, 4, 1100), new BuyPanel(2112.5, 350, 5, 3000)};
boolean placing = false;


int bspawn = 0;
Balloon[] balloons = {};
int pathOn = 0;
int[] lhealth = {1, 2, 3, 4, 5};



Point[] mPath = {};

Point[] path1 = {new Point(1700, -50, new Pair(0, 1), 1, 0), new Point(1700, 300, new Pair(-1, 0), 0, 0), new Point(1400, 300, new Pair(0, 1), 0, 0), new Point(1400, 900, new Pair(1, 0), 0, 0), new Point(1700, 900, new Pair(0, 1), 0, 0), new Point(1700, 1200, new Pair(-1, 0), 0, 0), new Point(300, 1200, new Pair(0, -1), 0, 0), new Point(300, 900, new Pair(1, 0), 0, 0), new Point(600, 900, new Pair(0, -1), 0, 0), new Point(600, 300, new Pair(-1, 0), 0, 0), new Point(300, 300, new Pair(0, -1), 0, 0), new Point(300, 0, new Pair(0, -1), 2, 0)};
Point[] path2 = {new Point(800, 200, new Pair(1, 0), 1, 1), new Point(1200, 200, new Pair(sin(PI/4), sin(PI/4)), 0, 1), new Point(1400, 400, new Pair(0, 1), 0, 1), new Point(1400, 800, new Pair(-sin(PI/4), sin(PI/4)), 0, 1), new Point(1200, 1000, new Pair(-1, 0), 0, 1), new Point(800, 1000, new Pair(-sin(PI/4), -sin(PI/4)), 0, 1), new Point(600, 800, new Pair(0, -1), 0, 1), new Point(600, 400, new Pair(sin(PI/4), -sin(PI/4)), 0, 1), new Point(800, 200, new Pair(1, 0), 0, 1)};
Path[] paths = {new Path(path1), new Path(path2), new Path(mPath)};

float[][] a = {{2, 4}, {3, -1}, {-2, 0}};
float[][] b = {{-3, 5, 2}, {0, 2, 1}};
float[][] c = multiply(a, b);

int health = 150;
int money = 6500000;

float[][] rotMatrix(float r) {
  float[][] f = {{cos(-r), sin(-r)}, {-1*sin(-r), cos(-r)}}; 
  return f;
}


ArrayList<Projectile> proj = new ArrayList<Projectile>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();

PImage red, blue, green, yellow, pink;
PImage pop, explosion;
PImage gunmonkey, godmonkey, cannon, gatmonkey, gatmonkey2, snipermonkey, spraytower, spraytower2;
PImage bullet;
PImage camo;

PImage[] images = {gunmonkey, spraytower, cannon, snipermonkey, gatmonkey, godmonkey};


float timescale = 1;
boolean spedup = false;
boolean released;

int j = 0;

String displayText = "";
int displayCost = 0;

String[] saveDat;

GunMonkey g = new GunMonkey(1700, 550);
ArrayList<Tower> towers = new ArrayList<Tower>();
void spawnBalloon(float ex, float why, int el) {
  balloons = (Balloon[])append(balloons, new Balloon(ex, why, el));
}

void mouseReleased() {
  released = true;
}

void saveData() {
  for (Tower t : towers) {
    if (t.saved == false) {
      output.println(t.saveString());
    }
  }
  output2.println(money+"-"+health);
  output2.flush();
  output.flush();
}

void setup() {
  //println(path2.length);
  size(2300, 1500);
  //loadTowers();
  //loadStats();
  money = 6500;
  output = createWriter("towerDat.txt");
  output2 = createWriter("statsDat.txt");
  saveData();

  frameRate(60);



  red = loadImage("red.png");
  blue = loadImage("blue.png");
  green = loadImage("green.png");
  yellow = loadImage("yellow.png");
  pink = loadImage("pink.png");

  pop = loadImage("pop.png");
  explosion = loadImage("explosion.png");

  gunmonkey = loadImage("gunmonkey.png");
  godmonkey = loadImage("godmonkey.png");
  cannon = loadImage("cannon.png");
  gatmonkey = loadImage("gatmonkey.png");
  gatmonkey2 = loadImage("gatmonkey2.png");
  snipermonkey = loadImage("snipermonkey.png");
  spraytower = loadImage("spraytower.png");
  spraytower2 = loadImage("spraytower2.png");
  images[0] = gunmonkey;
  images[1] = spraytower;
  images[2] = cannon;
  images[3] = snipermonkey;
  images[4] = gatmonkey;
  images[5] = godmonkey;




  bullet = loadImage("bullet.png");

  camo = loadImage("camo.png");
  imageMode(CENTER);
}

void loadTowers() {
  // Open the file from the createWriter() example
  BufferedReader reader = createReader("towerDat.txt");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, TAB);
      for (String s : pieces) {
        String[] data = split(s, "-");
        println(data[2]);
        float temp = Integer.parseInt(data[2]);
        float ex = Integer.parseInt(data[0]);
        float why = Integer.parseInt(data[1]);
        if (temp == 0) {
          towers.add(new GunMonkey(ex, why));
        }
        if (temp == 1) {
          towers.add(new SprayTower(ex, why));
        }
        if (temp == 2) {
          towers.add(new Cannon(ex, why));
        }
        if (temp == 3) {
          towers.add(new SniperMonkey(ex, why));
        }
        if (temp == 4) {
          towers.add(new GatMonkey(ex, why));
        }
        if (temp == 5) {
          towers.add(new GodMonkey(ex, why));
        }
      }
    }
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
} 

void loadStats() {
  // Open the file from the createWriter() example
  BufferedReader reader = createReader("statsDat.txt");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, TAB);
      for (String s : pieces) {
        String[] data = split(s, "-");
        money = Integer.parseInt(data[0]);
        health = Integer.parseInt(data[1]);
      }
    }
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
} 

//void levelOne() {
//  if (round(random(0, (5/timescale))) == 0 && bspawn < lvlOne[lvlOne.length-1]) {


//    for (int i = 0; i < lvlOne.length; i++) {
//      if (i > 0) {
//        if (bspawn < lvlOne[i] && bspawn >= lvlOne[i-1]) {
//          spawnBalloon(mPath[0].x, mPath[0].y, i);
//          bspawn++;
//        }
//      } else {
//        if (bspawn < lvlOne[i]) {
//          spawnBalloon(mPath[0].x, mPath[0].y, i);
//          bspawn++;
//        }
//      }
//    }
//  }
//}
int bOn = 0; //balloon type on
void level(int l) {
  if (bOn < lvls[l].length) {
    int n = Integer.parseInt(lvls[l][bOn].substring(0, 3)); //get number to spawn
    int layer = Integer.parseInt(lvls[l][bOn].substring(4, 6)); //get balloon layer
    int spawnspeed = Integer.parseInt(lvls[l][bOn].substring(7)); //get speed to spawn at
    if (j < n) { //while number spawned is less than number needed to spawn, spawn balloons at random intervals
      if (frameCount%(spawnspeed/timescale) == 0) {
        spawnBalloon(paths[pathOn].points[0].x, paths[pathOn].points[0].y, layer);
        j++;
      }
    }
    if (j >= n) {
      j = 0;
      bOn++;
    }
  } else {
    spawnDone = true;
  }



  //println(n, layer, spawnspeed);
}
//if (round(random(0, 5/timescale)) == 0 && bspawn < lvls[l][lvls[l].length-1]) {
//  println(bspawn);

//  for (int i = 0; i < lvls[l].length; i++) {
//    if (i > 0) {
//      if (bspawn < Integer.parseInt(lvls[l][i].substring(0, 3)) && bspawn >= lvls[l][i-1]) {
//        spawnBalloon(paths[pathOn].points[0].x, paths[pathOn].points[0].y, i);
//        bspawn++;
//      }
//    } else {
//      if (bspawn < lvls[l][i]) {
//        spawnBalloon(paths[pathOn].points[0].x, paths[pathOn].points[0].y, i);
//        bspawn++;
//      }
//    }
//  }
//}

float scrollY = 300;
float scrollDist = ((int)(towerTypes/2))*175;
void sideMenu() {
  if (sidescreen == 0) {
    fill(104, 74, 52);
    noStroke();
    rectMode(CORNER);
    rect(1900, 0, 400, 1500);

    pushMatrix();
    translate(0, (-scrollY)+600);
    for (int i = 0; i < towerTypes; i++) {
      fill(94, 66, 47);

      rect(1937.5+((i%2)*175), (((int)(i/2))*175), 150, 150);
    }
    imageMode(CORNER);
    image(gunmonkey, 1937.5, 0, 150, 150);
    image(spraytower, 2112.5, 0, 150, 150);
    image(cannon, 1937.5, 175, 150, 150);
    image(snipermonkey, 2150, 175, 75, 150);
    image(gatmonkey, 1975, 350, 75, 150);
    image(godmonkey, 2112.5, 350, 150, 150);

    imageMode(CENTER);



    popMatrix();
    stroke(73, 52, 36);
    strokeWeight(15);
    line(2281.25, 307.5, 2281.25, 1300);
    stroke(150);

    line(2281.25, scrollY+7.5, 2281.5, scrollY+7.5+87.5);
    if (mouseX > 2275 && mouseX < 2300 && mouseY >= 300 && mouseY < 1205) {
      if (mousePressed) {
        scrollY = mouseY;
      }
    }

    noStroke();
    fill(104, 74, 52);
    rect(1900, 0, 400, 300);
    fill(230);
    textAlign(CENTER);
    textSize(45);
    text(displayText, 2100, 100);
    if (displayCost > 0) {
      text("$"+displayCost, 2100, 150);
    }
  }
  boolean b = true;
  for (Tower t : towers) {
    if (t.getSelected()) {
      b = false;
      break;
    }
  }
  println(b);
  if (b) {
    sidescreen = 0;
  }
  if (sidescreen == 1) {
    Tower sTower = new Tower(0, 0);
    int tlistPos = 0; 
    int towerListPos = 0;
    for(int p = 0; p < towers.size(); p++){
      if(towers.get(p).getSelected()){
        towerListPos = p;
        break;
      }
    }
    
    for(Tower t : towers){
      if(t.getSelected()){
         sTower = t;
      }
    }
    for(int p = 0; p < tows.length; p++){
      if(tows[p].getName() == sTower.getName()){
        tlistPos = p;
        break;
      }
    }
    
    fill(104, 74, 52);
    noStroke();
    rectMode(CORNER);
    rect(1900, 0, 400, 1500);
    fill(230);
    textAlign(CENTER, CENTER);
    textSize(45);
    text(sTower.getName(), 2100, 100);
    stroke(73, 52, 36);
    strokeWeight(4);
    if(mouseX > 1912.5 && mouseX < 2287.5 && mouseY > 1412.5 && mouseY < 1487.5){
      fill(89, 63, 44);
      if(released){
        towers.remove(towerListPos);
        money += (int)((0.8*bpanels[tlistPos].cost));
      }
    } else {
      fill(94, 66, 47);
    }
    rect(1912.5, 1412.5, 375, 75);
    fill(230);
    noStroke();
    textSize(35);
    text("Sell For: $"+(int)((0.8*bpanels[tlistPos].cost)), 2100, 1450);
    
    
  }
}

int cooldown = 0;

boolean onlvl = false;
void draw() {
  background(255);
  sideMenu();
  if (spawnDone && balloons.length == 0) {
    money+= 100+((lvlOn+1)*2);
    lvlOn++;
    playing = false;
    spawnDone = false;
    bOn = 0;
    saveData();
  }
  if (playing) {
    if (pathOn != 2) {
      level(lvlOn);
    }
  }



  paths[2] = new Path(mPath);

  for (Point p : paths[pathOn].points) {
    p.display();
  }
  for (Balloon b : balloons) {
    b.act();
  }
  if (pathOn == 2) {
    if (onlvl) {
      //levelOne();
    }
    if (mousePressed && mouseButton == LEFT && mPath.length == 0) {
      mPath = (Point[])append(mPath, new Point(mouseX, mouseY, new Pair(0, 0), 1, 2));
    }
    if (mousePressed && mouseButton == LEFT && mPath.length > 0 && cooldown == 0) {
      mPath = (Point[])append(mPath, new Point(mouseX, mouseY, new Pair(0, 0), 0, 2));
      mPath[mPath.length-2].dir.x = -1*cos(atan2(mPath[mPath.length-2].y-mouseY, mPath[mPath.length-2].x-mouseX));
      mPath[mPath.length-2].dir.y = -1*sin(atan2(mPath[mPath.length-2].y-mouseY, mPath[mPath.length-2].x-mouseX));
      cooldown = 40;
    }
    if (mousePressed && mouseButton == CENTER) {
      onlvl = false;
      for (int i = 0; i < mPath.length; i++) {

        if (i == 0) {
          mPath = (Point[])subset(mPath, 1);
        } else if (i == mPath.length-1) {
          mPath = (Point[])shorten(mPath);
        } else {
          mPath = (Point[])concat(subset(mPath, 0, i), subset(mPath, i+1));
        }
      }
    }

    if (mousePressed && mouseButton == RIGHT) {
      onlvl = true;
    }
  }
  if (cooldown > 0) {
    cooldown--;
  }
  for (Point p : mPath) {
    p.display();
  }

  for (Projectile p : proj) {
    p.act();
  }
  for (int i = 0; i < proj.size(); i++) {
    if (proj.get(i).dead()) {
      proj.remove(i);
      i--;
    }
  }
  if (balloons.length == 1) {
    // println(balloons[0].recover);
  }
  for (int i = 0; i < balloons.length; i++) {
    if (balloons[i].l < 0) {
      if (i==0) {
        balloons=(Balloon[])subset(balloons, 1);
      } else if (i==balloons.length-1) {
        balloons=(Balloon[])shorten(balloons);
      } else {
        balloons=(Balloon[])concat(subset(balloons, 0, i), subset(balloons, i+1));
      }
    }
  }
  for (Tower t : towers) {
    t.act();
  }
  for (BuyPanel b : bpanels) {
    b.act();
  }

  for (Explosion e : explosions) {
    e.act();
  }

  fill(0, 130, 220);
  if (dist(mouseX, mouseY, 100, 1400) < 65) {
    stroke(0, 200, 245);
    if (released && playing) {
      spedup = !spedup;
    }
    if (released && !playing) {
      playing = true;
    }
  } else {
    stroke(0, 180, 245);
  }
  if (spedup) {
    timescale = 2;
  } else {
    timescale = 1;
  }
  strokeWeight(15);
  ellipse(100, 1400, 100, 100);
  noStroke();


  if (playing) {
    if (!spedup) {
      fill(0, 200, 205);
    } else {
      fill(0, 240, 255);
    }
    triangle(80, 1380, 80, 1420, 105, 1400);
    triangle(105, 1380, 105, 1420, 130, 1400);
  } else {
    fill(0, 200, 205);
    triangle(82.5, 1375, 82.5, 1425, 130, 1400);
  }

  for (int p = 0; p < explosions.size(); p++) {
    if (explosions.get(p).dur == 0) {
      explosions.remove(p);
      p--;
    }
  }
  fill(0);
  textAlign(CORNER, CENTER);
  textSize(30);
  text("Health: " +health, 10, 10);
  text("Money: $"+money, 10, 45);
  released = false;
}





float[][] multiply(float[][] A, float[][] B) {

  int aRows = A.length;
  int aColumns = A[0].length;
  int bRows = B.length;
  int bColumns = B[0].length;



  float[][] C = new float[aRows][bColumns];
  for (int i = 0; i < aRows; i++) {
    for (int j = 0; j < bColumns; j++) {
      C[i][j] = 0.00000;
    }
  }

  for (int i = 0; i < aRows; i++) { // aRow
    for (int j = 0; j < bColumns; j++) { // bColumn
      for (int k = 0; k < aColumns; k++) { // aColumn
        C[i][j] += A[i][k] * B[k][j];
      }
    }
  }

  return C;
}