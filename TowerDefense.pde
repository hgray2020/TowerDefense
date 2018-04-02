int leadL = 7;
int leadH = 7;
String[] lvl1 = {"020-00-25"};
String[] lvl2 = {"030-00-25"};
String[] lvl3 = {"020-00-25", "005-01-30"};
String[] lvl4 = {"030-00-25", "015-01-25"};
String[] lvl5 = {"005-00-25", "025-01-15"};
String[] lvl6 = {"015-00-25", "015-01-25", "004-02-25"};
String[] lvl7 = {"020-00-25", "025-01-30", "005-02-25"};
String[] lvl8 = {"010-00-15", "020-01-15", "014-02-15"};
String[] lvl9 = {"030-02-10"};
String[] lvl10 = {"102-01-05"};
String[] lvl11 = {"010-00-15", "010-01-15", "010-02-15", "002-03-25"};
String[] lvl12 = {"015-01-15", "023-02-10", "004-03-15"};
String[] lvl13 = {"050-00-10", "015-01-10", "010-02-15", "009-03-15"};
String[] lvl14 = {"030-00-25", "015-01-25"};
String[] lvl15 = {"020-00-25", "005-01-30"};
String[] lvl16 = {"030-00-25", "015-01-25"};
String[] lvl17 = {"020-00-25", "005-01-30"};
String[] lvl18 = {"030-00-25", "015-01-25"};
String[] lvl19 = {"020-00-25", "005-01-30"};
String[] lvl20 = {"030-00-25", "015-01-25"};
int lvlOn = 3;
String[][] lvls = {lvl1, lvl2, lvl3, lvl4, lvl5, lvl6, lvl7, lvl8, lvl9, lvl10, lvl11, lvl12, lvl13};

PrintWriter output;
PrintWriter output2;

boolean playing;
boolean spawnDone = false;

int sidescreen = 0;




BuyPanel[] bpanels = {new BuyPanel(1937.5, 0, 0, 300), new BuyPanel(2112.5, 0, 1, 350), new BuyPanel(1937.5, 175, 2, 450), new BuyPanel(2112.5, 175, 3, 800), new BuyPanel(1937.5, 350, 4, 1100), new BuyPanel(2112.5, 350, 5, 3000), new BuyPanel(1937.5, 525, 6, 450), new BuyPanel(2112.5, 525, 7, 500), new BuyPanel(1937.5, 700, 8, 900)};
boolean placing = false;


int bspawn = 0;
Balloon[] balloons = {};
int pathOn = 0;
int[] lhealth = {1, 2, 3, 4, 5, 6, 6, 7, 8, 9, 40};



Point[] mPath = {};
int makingPath = 4;

Point[] path1 = {new Point(1700, -50, new Pair(0, 1), 1, 0), new Point(1700, 300, new Pair(-1, 0), 0, 0), new Point(1400, 300, new Pair(0, 1), 0, 0), new Point(1400, 900, new Pair(1, 0), 0, 0), new Point(1700, 900, new Pair(0, 1), 0, 0), new Point(1700, 1200, new Pair(-1, 0), 0, 0), new Point(300, 1200, new Pair(0, -1), 0, 0), new Point(300, 900, new Pair(1, 0), 0, 0), new Point(600, 900, new Pair(0, -1), 0, 0), new Point(600, 300, new Pair(-1, 0), 0, 0), new Point(300, 300, new Pair(0, -1), 0, 0), new Point(300, 0, new Pair(0, -1), 2, 0)};
Point[] path2 = {new Point(1200, -50, new Pair(0, 1), 1, 1), new Point(1200, 200, new Pair(sin(PI/4), sin(PI/4)), 0, 1), new Point(1400, 400, new Pair(0, 1), 0, 1), new Point(1400, 800, new Pair(-sin(PI/4), sin(PI/4)), 0, 1), new Point(1200, 1000, new Pair(-1, 0), 0, 1), new Point(800, 1000, new Pair(-sin(PI/4), -sin(PI/4)), 0, 1), new Point(600, 800, new Pair(0, -1), 0, 1), new Point(600, 400, new Pair(sin(PI/4), -sin(PI/4)), 0, 1), new Point(800, 200, new Pair(0, -1), 0, 1), new Point(800, -50, new Pair(0, 0), 2, 1)};
Point[] path3 = {new Point(1693.0, 5.0, new Pair(-1.0, -0.0), 1, 3), new Point(1693.0, 5.0, new Pair(-0.19429314, 0.9809435), 0, 3), new Point(1529.0, 833.0, new Pair(0.30113143, 0.95358264), 0, 3), new Point(1643.0, 1194.0, new Pair(-0.8657348, 0.50050294), 0, 3), new Point(1323.0, 1379.0, new Pair(-0.97043556, -0.24136046), 0, 3), new Point(740.0, 1234.0, new Pair(0.8156658, -0.57852346), 0, 3), new Point(1053.0, 1012.0, new Pair(-0.97798437, -0.20867819), 0, 3), new Point(425.0, 878.0, new Pair(-0.20846456, -0.9780299), 0, 3), new Point(318.0, 376.0, new Pair(-0.98491, -0.17306726), 0, 3), new Point(5.0, 321.0, new Pair(0.0, 0.0), 2, 3)};
Point[] path4 = {new Point(107.0, 518.0, new Pair(-1.0, -0.0), 1, 4), new Point(107.0, 518.0, new Pair(0.7641835, -0.6449989), 0, 4), new Point(216.0, 426.0, new Pair(0.9576738, -0.28785577), 0, 4), new Point(389.0, 374.0, new Pair(0.98485327, -0.17338978), 0, 4), new Point(531.0, 349.0, new Pair(0.9915345, -0.12984386), 0, 4), new Point(699.0, 327.0, new Pair(0.99237734, 0.12323648), 0, 4), new Point(852.0, 346.0, new Pair(0.9763244, 0.21631147), 0, 4), new Point(1019.0, 383.0, new Pair(0.6962579, 0.71779174), 0, 4), new Point(1116.0, 483.0, new Pair(0.4941168, 0.8693955), 0, 4), new Point(1195.0, 622.0, new Pair(4.371139E-8, 1.0), 0, 4), new Point(1195.0, 782.0, new Pair(-0.2272296, 0.9738412), 0, 4), new Point(1153.0, 962.0, new Pair(-0.7522365, 0.6588932), 0, 4), new Point(1016.0, 1082.0, new Pair(-0.91875184, 0.3948355), 0, 4), new Point(895.0, 1134.0, new Pair(-0.95126426, 0.30837688), 0, 4), new Point(713.0, 1193.0, new Pair(-1.0, -0.0), 0, 4), new Point(509.0, 1193.0, new Pair(-0.89200336, -0.45202875), 0, 4), new Point(361.0, 1118.0, new Pair(-0.74056035, -0.67198986), 0, 4), new Point(253.0, 1020.0, new Pair(-0.50620055, -0.8624158), 0, 4), new Point(172.0, 882.0, new Pair(0.18540785, -0.98266166), 0, 4), new Point(202.0, 723.0, new Pair(0.54588056, -0.837863), 0, 4), new Point(288.0, 591.0, new Pair(0.9054589, -0.42443386), 0, 4), new Point(416.0, 531.0, new Pair(0.9904674, -0.13774723), 0, 4), new Point(567.0, 510.0, new Pair(0.9999008, -0.014083071), 0, 4), new Point(709.0, 508.0, new Pair(1.0, 8.742278E-8), 0, 4), new Point(832.0, 508.0, new Pair(0.91250926, 0.40905598), 0, 4), new Point(948.0, 560.0, new Pair(0.28734782, 0.9578263), 0, 4), new Point(975.0, 650.0, new Pair(-0.036560923, 0.9993314), 0, 4), new Point(969.0, 814.0, new Pair(-0.47751334, 0.8786245), 0, 4), new Point(894.0, 952.0, new Pair(-0.8397643, 0.5429511), 0, 4), new Point(778.0, 1027.0, new Pair(-0.999872, 0.015997954), 0, 4), new Point(653.0, 1029.0, new Pair(-0.9872747, -0.1590241), 0, 4), new Point(504.0, 1005.0, new Pair(-0.7703943, -0.6375677), 0, 4), new Point(388.0, 909.0, new Pair(-0.33682126, -0.9415686), 0, 4), new Point(344.0, 786.0, new Pair(0.63549894, -0.7721017), 0, 4), new Point(451.0, 656.0, new Pair(0.99886817, -0.04756506), 0, 4), new Point(619.0, 648.0, new Pair(0.9721743, 0.23425879), 0, 4), new Point(785.0, 688.0, new Pair(0.879292, 0.47628307), 0, 4), new Point(905.0, 753.0, new Pair(0.96949834, -0.24509797), 0, 4), new Point(1083.0, 708.0, new Pair(0.99963, -0.027200833), 0, 4), new Point(1377.0, 700.0, new Pair(-0.25857344, -0.9659916), 0, 4), new Point(1271.0, 304.0, new Pair(-0.9086499, -0.4175588), 0, 4), new Point(925.0, 145.0, new Pair(-0.99993515, -0.011388783), 0, 4), new Point(486.0, 140.0, new Pair(-0.97654754, 0.21530181), 0, 4), new Point(105.0, 224.0, new Pair(0.014216584, 0.9998989), 0, 4), new Point(111.0, 646.0, new Pair(0.0, 0.0), 2, 4)};

//{new Point(2.0, 661.0, new Pair(-1.0, -0.0), 1, 3), new Point(2.0, 661.0, new Pair(0.60470915, -0.7964464), 0, 3), new Point(43.0, 607.0, new Pair(0.6375678, -0.77039427), 0, 3), new Point(91.0, 549.0, new Pair(0.6301689, -0.7764581), 0, 3), new Point(147.0, 480.0, new Pair(0.7610564, -0.6486857), 0, 3), new Point(296.0, 353.0, new Pair(0.81109035, -0.5849209), 0, 3), new Point(400.0, 278.0, new Pair(0.8915789, -0.4528654), 0, 3), new Point(526.0, 214.0, new Pair(0.9735281, -0.22856751), 0, 3), new Point(641.0, 187.0, new Pair(0.9718501, -0.23560013), 0, 3), new Point(773.0, 155.0, new Pair(0.9935658, -0.11325626), 0, 3), new Point(966.0, 133.0, new Pair(0.992679, 0.120782316), 0, 3), new Point(1229.0, 165.0, new Pair(0.89186454, 0.45230263), 0, 3), new Point(1369.0, 236.0, new Pair(0.5993149, 0.8005133), 0, 3), new Point(1509.0, 423.0, new Pair(0.048722565, 0.9988124), 0, 3), new Point(1519.0, 628.0, new Pair(-0.15454528, 0.98798573), 0, 3), new Point(1491.0, 807.0, new Pair(-0.41380292, 0.9103665), 0, 3), new Point(1476.0, 840.0, new Pair(-0.66896474, 0.7432941), 0, 3), new Point(1422.0, 900.0, new Pair(-0.84521276, 0.53443), 0, 3), new Point(1131.0, 1084.0, new Pair(-0.9619051, 0.27338356), 0, 3), new Point(1036.0, 1111.0, new Pair(-0.99994344, 0.010637696), 0, 3), new Point(754.0, 1114.0, new Pair(-0.9971488, 0.07545991), 0, 3), new Point(569.0, 1128.0, new Pair(-0.9841833, 0.177153), 0, 3), new Point(419.0, 1155.0, new Pair(-0.6444319, -0.7646617), 0, 3), new Point(285.0, 996.0, new Pair(-0.08362216, -0.9964975), 0, 3), new Point(273.0, 853.0, new Pair(0.29300198, -0.95611185), 0, 3), new Point(292.0, 791.0, new Pair(0.6492241, -0.76059717), 0, 3), new Point(531.0, 511.0, new Pair(0.9012154, -0.43337142), 0, 3), new Point(714.0, 423.0, new Pair(0.9930971, -0.11729491), 0, 3), new Point(841.0, 408.0, new Pair(0.9438583, 0.33035046), 0, 3), new Point(1101.0, 499.0, new Pair(0.1733359, 0.98486274), 0, 3), new Point(1123.0, 624.0, new Pair(-0.104322724, 0.9945435), 0, 3), new Point(1108.0, 767.0, new Pair(-0.5263547, 0.85026515), 0, 3), new Point(1056.0, 851.0, new Pair(-0.77254087, 0.63496506), 0, 3), new Point(910.0, 971.0, new Pair(-0.9931506, 0.11684125), 0, 3), new Point(672.0, 999.0, new Pair(-0.48457393, -0.8747503), 0, 3), new Point(595.0, 860.0, new Pair(0.49311367, -0.8699649), 0, 3), new Point(718.0, 643.0, new Pair(1.0, 8.742278E-8), 2, 3)};


Path[] paths = {new Path(path1), new Path(path2), new Path(mPath), new Path(path3), new Path(path4)};

Tower[] tows = {new GunMonkey(0, 0), new SprayTower(0, 0), new Cannon(0, 0), new SniperMonkey(0, 0), new GatMonkey(0, 0), new GodMonkey(0, 0), new BoomerangMonkey(0, 0), new WizardMonkey(0, 0), new PlaneMonkey(0, 0)};
int towerTypes = tows.length;

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
ArrayList<Lightning> bolts = new ArrayList<Lightning>();

PImage red, blue, green, yellow, pink, lead, black, white, zebra, rainbow, ceramic1, ceramic2, ceramic3, ceramic4;
PImage pop, explosion;
PImage gunmonkey, godmonkey, cannon, gatmonkey, gatmonkey2, snipermonkey, spraytower, spraytower2, boomerangmonkey, wizardmonkey, planemonkey, planemonkey2;
PImage bullet, boomerang;
PImage camo;

PImage[] images = {gunmonkey, spraytower, cannon, snipermonkey, gatmonkey, godmonkey, boomerangmonkey, wizardmonkey, planemonkey};


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
  output.close();
  output = createWriter("towerDat.txt");
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
  loadTowers();
  loadStats();
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
  lead = loadImage("lead.png");
  black = loadImage("black.png");
  white = loadImage("white.png");
  zebra = loadImage("zebra.png");
  rainbow = loadImage("rainbow.png");
  ceramic1 = loadImage("ceramic1.png");
  ceramic2 = loadImage("ceramic2.png");
  ceramic3 = loadImage("ceramic3.png");
  ceramic4 = loadImage("ceramic4.png");

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
  boomerangmonkey = loadImage("boomerangmonkey.png");
  wizardmonkey = loadImage("wizardmonkey.png");
  planemonkey = loadImage("planemonkey.png");
  planemonkey2 = loadImage("planemonkey2.png");
  images[0] = gunmonkey;
  images[1] = spraytower;
  images[2] = cannon;
  images[3] = snipermonkey;
  images[4] = gatmonkey;
  images[5] = godmonkey;
  images[6] = boomerangmonkey;
  images[7] = wizardmonkey;
  images[8] = planemonkey;




  bullet = loadImage("bullet.png");
  boomerang = loadImage("boomerange.png");

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
        float why = Integer.parseInt(data[1]);//return (int)x+"-"+(int)y+"-01-"+range+"-"+s+"-"+attack+"-"+reload;
        Tower t = new Tower(0, 0);
        if (temp == 0) {
          t = new GunMonkey(ex, why);
        }
        if (temp == 1) {
          t = new SprayTower(ex, why);
          if (Integer.parseInt(data[data.length-1]) == 1) {
            t.setSpray();
          }
        }
        if (temp == 2) {
          t = new Cannon(ex, why);
        }
        if (temp == 3) {
          t = new SniperMonkey(ex, why);
        }
        if (temp == 4) {
          t = new GatMonkey(ex, why);
        }
        if (temp == 5) {
          t = new GodMonkey(ex, why);
        }
        if (temp == 6) {
          t = new BoomerangMonkey(ex, why);
        }
        if (temp == 7) {
          t = new WizardMonkey(ex, why);
        }
        if (temp == 8) {
          t = new PlaneMonkey(ex, why); 
          if (Integer.parseInt(data[data.length-1]) == 1) {
            t.setSpray();
          }
        }
        t.setRange(Float.parseFloat(data[3]));
        boolean b = Integer.parseInt(data[4]) == 1;
        t.setCamo(b);
        t.setAttack(Integer.parseInt(data[5]));
        t.setReload((int)Float.parseFloat(data[6]));
        t.setUpOn(Integer.parseInt(data[7])+1);
        towers.add(t);
      }
    }
    reader.close();
    println(towers.size());
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
  if (l < lvls.length) {
    if (bOn < lvls[l].length) {
      int n = Integer.parseInt(lvls[l][bOn].substring(0, 3)); //get number to spawn
      int layer = Integer.parseInt(lvls[l][bOn].substring(4, 6)); //get balloon layer
      int spawnspeed = Integer.parseInt(lvls[l][bOn].substring(7, 9)); //get speed to spawn at
      if (j < n) { //while number spawned is less than number needed to spawn, spawn balloons at random intervals
        if (frameCount%(spawnspeed/timescale) == 0) {
          if(lvls[l][bOn].length() > 9){
            println("YE");
            balloons = (Balloon[])append(balloons, new Balloon(paths[pathOn].points[0].x, paths[pathOn].points[0].y, layer, true));  
          }
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
    image(boomerangmonkey, 1937.5, 525, 150, 150);
    image(wizardmonkey, 2112.5, 525, 150, 150);
    image(planemonkey, 1937.5, 700, 150, 150);

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
    for (BuyPanel b : bpanels) {
      b.act();
    }
  }
  boolean b = true;
  for (Tower t : towers) {
    if (t.getSelected()) {
      b = false;
      break;
    }
  }

  if (b) {
    sidescreen = 0;
  }
  if (sidescreen == 1) {
    Tower sTower = new Tower(0, 0);
    int tlistPos = 0; 
    int towerListPos = 0;
    for (int p = 0; p < towers.size(); p++) {
      if (towers.get(p).getSelected()) {
        towerListPos = p;
        break;
      }
    }

    for (Tower t : towers) {
      if (t.getSelected()) {
        sTower = t;
      }
    }
    for (int p = 0; p < tows.length; p++) {
      if (tows[p].getName() == sTower.getName()) {
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
    if (mouseX > 1912.5 && mouseX < 2287.5 && mouseY > 1412.5 && mouseY < 1487.5) {
      fill(89, 63, 44);
      if (released) {
        towers.remove(towerListPos);
        money += (int)((0.8*bpanels[tlistPos].cost));
        saveData();
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
      cooldown = 25;
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
    print("{");
    for (Point p : mPath) {
      print("new Point("+p.x+", "+p.y+", new Pair("+p.dir.x+", "+p.dir.y+"), 0, "+makingPath+"), ");
    }
    println("};");
    println();
    println();
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
  for (Lightning l : bolts) {
    l.act();
  }


  for (int i = 0; i < bolts.size(); i++) {
    println(bolts.get(0).points.length);
    if (bolts.get(i).dead()) {
      bolts.remove(i);
      i--;
    }
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
    if (balloons[i].l < 0 && balloons[i].l != leadL) {
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
    if (explosions.get(p).dur <= 0) {
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