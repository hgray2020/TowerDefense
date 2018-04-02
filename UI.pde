class BuyPanel {

  float x, y;
  int t;
  int cost;
  boolean drag = false;

  BuyPanel(float ex, float why, int type, int c) {
    x = ex;
    y = why;
    t = type;
    cost = c;
  }

  void act() {
    if (mouseX >= x && mouseX <= x+150 && mouseY >= y+((-scrollY)+600) && mouseY <= y+((-scrollY)+600)+150) {
      if (mousePressed && !placing && money >= cost) {
        drag = true;
        placing = true;
        displayText = tows[t].getName();
        displayCost = cost;
      }
    }
    if (mousePressed && drag) {
      imageMode(CENTER);
      if (!(t == 4 || t == 3 || t == 8)) {
        noStroke();
        if (canPlace()) {
          fill(0, 100);
        } else {
          fill(100, 0, 0, 100);
        }

        ellipse(mouseX, mouseY, tows[t].getRange(), tows[t].getRange());
        image(images[t], mouseX, mouseY, 100, 100);
      } else {
        if (t == 8) {
          image(images[t], mouseX, mouseY, 300, 300);
        } else {
          image(images[t], mouseX, mouseY, 100, 200);
        }
      }
    }
    if (released && drag) {
      if (canPlace()) {
        placeTower();
        drag = false;
        placing = false;
      } else {
        drag = false;
        placing = false;
      }
    }
  }

  void placeTower() {
    if (t == 0) {
      towers.add(new GunMonkey(mouseX, mouseY));
    }
    if (t == 1) {
      towers.add(new SprayTower(mouseX, mouseY));
    }
    if (t == 2) {
      towers.add(new Cannon(mouseX, mouseY));
    }
    if (t == 3) {
      towers.add(new SniperMonkey(mouseX, mouseY));
    }
    if (t == 4) {
      towers.add(new GatMonkey(mouseX, mouseY));
    }
    if (t == 5) {
      towers.add(new GodMonkey(mouseX, mouseY));
    }
    if (t == 6) {
      towers.add(new BoomerangMonkey(mouseX, mouseY));
    }
    if (t == 7) {
      towers.add(new WizardMonkey(mouseX, mouseY));
    }
    if (t == 8) {
      towers.add(new PlaneMonkey(mouseX, mouseY));
    }
    tows[t].setselected();
    if (!playing) {
      saveData();
    }
    money -= cost;
  }

  boolean canPlace() {
    boolean cp = true;
    cp = (!paths[pathOn].pointInPath(new Pair(mouseX, mouseY), 100)) && (mouseX < 1900 && mouseX > 0 && mouseY < 1500 && mouseY > 0);

    return cp;
  }
}

class UpPath {

  UpPair[] up;

  UpPath(UpPair[] u) {
    up = u;
  }
}

class UpPair {
  String desc;
  int cost;
  String id; //0 is range, 1 is camo, 2 is reload, 3 is attack power, 4 is spray tower, plane big spray
  //ex: "00-1.2" is a 120 percent increase in range, "01-01" is camo to true

  UpPair(String d, int c, String i) {
    desc = d;
    cost = c;
    id = i;
  }
}

class UpPanel {
  UpPath path;
  int upOn = 0;
  Tower parent;
  float y;

  UpPanel(UpPath pat, Tower p, float why) {
    path = pat;
    parent = p;
    y = why;
  }

  void display() {
    if (upOn < 0) {
      upOn = 0;
    }
    fill(94, 66, 47);
    stroke(73, 52, 36);
    strokeWeight(4);
    rect(1925, 325+y, 350, 350);
    if (mouseX > 1937.5 && mouseX < 2262.5 && mouseY > 337.5+y && mouseY < 662.5+y) {
      if (upOn < path.up.length) {
        fill(73, 52, 36);
      } else {
        fill(89, 63, 44);
      }
      if (released && upOn < path.up.length) {
        UpPair temp = path.up[upOn];
        String type = temp.id.substring(0, 2);
        println(type);
        money -= temp.cost;

        if (type.equals("00")) {

          parent.setRange(parent.getRange()*(Float.parseFloat(temp.id.substring(3))));
        }
        if (type.equals("01")) {
          parent.setCamo(true);
        }
        if (type.equals("02")) {
          parent.setReload((int)(parent.getReload()/(Float.parseFloat(temp.id.substring(3)))));
        }
        if (type.equals("03")) {
          parent.setAttack(parent.getAttack()+Integer.parseInt(temp.id.substring(3)));
        }
        if (type.equals("04")) {
          parent.setSpray();
        }
        saveData();



        upOn++;
      }
    } else {
      fill(89, 63, 44);
    }
    rect(1937.5, 337.5+y, 325, 325);
    fill(230);
    textSize(25);
    textAlign(CENTER, CENTER);
    if (upOn < path.up.length) {
      text(path.up[upOn].desc, 2100, 375+y);
      text("$"+path.up[upOn].cost, 2100, 425+y);
    } else {
      text("No more Upgrades", 2100, 375+y);
    }
  }
}