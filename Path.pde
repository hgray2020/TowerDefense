class Path {

  Point[] points;

  Path(Point[] p) {
    points = p;
  }

  boolean pointInPath(Pair point, int radius) {
    boolean inpath = false;
    for (int p = 0; p < points.length-1; p++) {
      float m = 0;
      float yint = 0;
      if (p < points.length-1) {
        if (points[p].x != points[p+1].x) {
          m = (points[p].y-points[p+1].y)/(points[p].x-points[p+1].x);
        } else {
          if (points[p].y > points[p+1].y) {
            if (point.x > points[p].x-(radius/2) && point.x < points[p].x+(radius/2) && point.y > points[p+1].y && point.y < points[p].y) {
              return true;
            }
          } else {
            if (point.x > points[p].x-(radius/2) && point.x < points[p].x+(radius/2) && point.y > points[p].y && point.y < points[p+1].y) {
              return true;
            }
          }
        }
        if (points[p].y == points[p+1].y) {
          if (points[p].x > points[p+1].x) {
            if (point.x > points[p+1].x && point.x < points[p].x && point.y > points[p+1].y-(radius/2) && point.y < points[p].y+(radius/2)) {
              return true;
            }
          } else {
            if (point.x > points[p].x && point.x < points[p+1].x && point.y > points[p+1].y-(radius/2) && point.y < points[p].y+(radius/2)) {
              return true;
            }
          }
        }
        if (dist(point.x, point.y, points[p].x, points[p].y) < (radius/2)) {
          return true;
        }
        m = points[p].dir.y/points[p].dir.x;

        yint = points[p].y-(m*points[p].x);
        if (points[p].x < points[p+1].x) {
          for (float x = points[p].x; x < points[p+1].x; x++) {
            float y = (m*x) + yint;
            if (dist(x, y, point.x, point.y) < (radius/2)) {
              return true;
            }
          }
        } else {
          for (float x = points[p].x; x > points[p+1].x; x--) {
            float y = (m*x) + yint;
            if (dist(x, y, point.x, point.y) < (radius/2)) {
              return true;
            }
          }
        }
      }
    }
    return inpath;
  }

  Point nearestPoint(Pair point) {
    boolean inpath = false;
    for (int p = 0; p < points.length-1; p++) {
      float m = 0;
      float yint = 0;
      if (p < points.length-1) {
        if (points[p].x != points[p+1].x) {
          m = (points[p].y-points[p+1].y)/(points[p].x-points[p+1].x);
        } else {
          if (points[p].y > points[p+1].y) {
            if (point.x > points[p].x-15 && point.x < points[p].x+15 && point.y > points[p+1].y && point.y < points[p].y) {
              return points[p];
            }
          } else {
            if (point.x > points[p].x-15 && point.x < points[p].x+15 && point.y > points[p].y && point.y < points[p+1].y) {
              return points[p];
            }
          }
        }
        if (points[p].y == points[p+1].y) {
          if (points[p].x > points[p+1].x) {
            if (point.x > points[p+1].x && point.x < points[p].x && point.y > points[p+1].y-15 && point.y < points[p].y+15) {
              return points[p];
            }
          } else {
            if (point.x > points[p].x && point.x < points[p+1].x && point.y > points[p+1].y-15 && point.y < points[p].y+15) {
              return points[p];
            }
          }
        }
        if (dist(point.x, point.y, points[p].x, points[p].y) < 35) {
          return points[p];
        }
        m = points[p].dir.y/points[p].dir.x;

        yint = points[p].y-(m*points[p].x);
        if (points[p].x < points[p+1].x) {
          for (float x = points[p].x; x < points[p+1].x; x++) {
            float y = (m*x) + yint;
            fill(150);
              
            if (dist(x, y, point.x, point.y) < 15) {
              
              return points[p];
            }
          }
        } else {
          for (float x = points[p].x; x > points[p+1].x; x--) {
            float y = (m*x) + yint;
            fill(150);
              
            if (dist(x, y, point.x, point.y) < 15) {
              
              return points[p];
            }
          }
        }
      }
    }
    return points[0];
  }
  Pair randomPoint(Pair loc, float radius) {
    Pair point = new Pair(random(loc.x-radius, loc.x+radius), random(loc.y-radius, loc.y+radius));
    while(!pointInPath(point, 40)){
      point = new Pair(random(loc.x-radius, loc.x+radius), random(loc.y-radius, loc.y+radius));
    }
   return point;
  }
}

class Point {
  int be; //is it beginning or end 0 is neither, 1 is beginning, 2 is end
  float x, y;
  Pair dir;
  int p; //position in Point array
  Point[] arr;
  int ps; //position of Path in paths array


  Point(float ex, float why, Pair d, int b, int _ps) {
    be = b;
    x = ex;
    y = why;
    dir = d;
    ps = _ps;
  }

  String prin() {
    return (x+", "+y+", "+dir.x+", "+dir.y);
  }

  void display() {
    arr = paths[ps].points;
    getP();
    strokeWeight(20);
    stroke(0);
    point(x, y);

    strokeWeight(10);
    if (be <= 2 && p > 0) {

      line(x, y, arr[p-1].x, arr[p-1].y);
      fill(0, 100);
      noStroke();
    }
    if (be == 3) {

      line(x, y, arr[0].x, arr[0].y);
    }
  }

  void getP() {
    for (int i = 0; i < arr.length; i++) {

      if (arr[i].x == this.x && arr[i].y == this.y && this.be == arr[i].be) {
        p = i;
      }
    }
  }
}

class Pair {
  float x, y;

  Pair(float ex, float why) {
    x = ex;
    y = why;
  }
}