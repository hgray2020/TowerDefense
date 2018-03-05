int[] lvlOne = {0, 0, 200};
int bspawn = 0;
Balloon[] balloons = {};
int pathOn = 0;
int[] lhealth = {1, 3, 6, 10};

Point[] path1 = {new Point(1700, -50, new Pair(0, 1), 1, 0), new Point(1700, 300, new Pair(-1, 0), 0, 0), new Point(1400, 300, new Pair(0, 1), 0, 0), new Point(1400, 900, new Pair(1, 0), 0, 0), new Point(1700, 900, new Pair(0, 1), 0, 0), new Point(1700, 1200, new Pair(-1, 0), 0, 0), new Point(300, 1200, new Pair(0, -1), 0, 0), new Point(300, 900, new Pair(1, 0), 0, 0), new Point(600, 900, new Pair(0, -1), 0, 0), new Point(600, 300, new Pair(-1, 0), 0, 0), new Point(300, 300, new Pair(0, -1), 0, 0), new Point(300, 0, new Pair(0, -1), 2, 0)};
Point[] path2 = {new Point(800, 200, new Pair(1, 0), 1, 1), new Point(1200, 200, new Pair(sin(PI/4), sin(PI/4)), 0, 1), new Point(1400, 400, new Pair(0, 1), 0, 1), new Point(1400, 800, new Pair(-sin(PI/4), sin(PI/4)), 0, 1), new Point(1200, 1000, new Pair(-1, 0), 0, 1), new Point(800, 1000, new Pair(-sin(PI/4), -sin(PI/4)), 0, 1), new Point(600, 800, new Pair(0, -1), 0, 1), new Point(600, 400, new Pair(sin(PI/4), -sin(PI/4)), 0, 1), new Point(800, 200, new Pair(1, 0), 0, 1)};
Path[] paths = {new Path(path1), new Path(path2)};
int health = 50;
ArrayList<Projectile> proj = new ArrayList<Projectile>();

PImage red, blue, green;
PImage pop;


GunMonkey g = new GunMonkey(1000, 750);
ArrayList<Tower> towers = new ArrayList<Tower>();
void spawnBalloon(float ex, float why, int el) {
  balloons = (Balloon[])append(balloons, new Balloon(ex, why, el));
}

void setup() {
  //println(path2.length);
  size(2000, 1500);
  towers.add(g);
  

  red = loadImage("red.png");
  blue = loadImage("blue.png");
  green = loadImage("green.png");
  pop = loadImage("pop.png");
}

void levelOne() {
  if (round(random(0, 5)) == 0 && bspawn < lvlOne[lvlOne.length-1]) {
    

    for (int i = 0; i < lvlOne.length; i++) {
      if (i > 0) {
        if (bspawn < lvlOne[i] && bspawn >= lvlOne[i-1]) {
          spawnBalloon(1700, -50, i);
          bspawn++;
        }
      } else {
        if (bspawn < lvlOne[i]) {
          spawnBalloon(1700, -50, i);
          bspawn++;
        }
      }
    }
  }
}

void levelTwo() {
  if (round(random(0, 5)) == 0 && bspawn < lvlOne[lvlOne.length-1]) {
    println(bspawn);

    for (int i = 0; i < lvlOne.length; i++) {
      if (i > 0) {
        if (bspawn < lvlOne[i] && bspawn >= lvlOne[i-1]) {
          spawnBalloon(800, 200, i);
          bspawn++;
        }
      } else {
        if (bspawn < lvlOne[i]) {
          spawnBalloon(800, 200, i);
          bspawn++;
        }
      }
    }
  }
}

int cooldown = 0;

void draw() {
  background(255);
  levelOne();

  for (Point p : paths[pathOn].points) {
    p.display();
  }
  for (Balloon b : balloons) {
    b.act();
  }
  
  
  for (Projectile p : proj) {
    p.act();
  }
  for(int i = 0; i < proj.size(); i++){
     if(proj.get(i).dead()){
         proj.remove(i);
         i--;
     }
  }
  if(balloons.length == 1){
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
  for(Tower t : towers){
      t.act();
  }
}