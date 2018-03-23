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
      if (!(t == 4 || t == 3)) {
        noStroke();
        if (canPlace()) {
          fill(0, 100);
        } else {
          fill(100, 0, 0, 100);
        }

        ellipse(mouseX, mouseY, tows[t].getRange(), tows[t].getRange());
        image(images[t], mouseX, mouseY, 100, 100);
      } else {
        image(images[t], mouseX, mouseY, 100, 200);
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
    tows[t].setselected();
    if (!playing) {
      saveData();
    }
    money -= cost;
  }

  boolean canPlace() {
    boolean cp = true;
    cp = (!paths[pathOn].pointInPath(new Pair(mouseX, mouseY))) && (mouseX < 1900 && mouseX > 0 && mouseY < 1500 && mouseY > 0);

    return cp;
  }
}