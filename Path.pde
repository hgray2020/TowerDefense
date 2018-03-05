class Path {

  Point[] points;

  Path(Point[] p) {
    points = p;
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

  void display() {
    arr = paths[ps].points;
    getP();
    strokeWeight(20);
    stroke(0);
    point(x, y);
    
    strokeWeight(10);
    if (be < 2 && p+1 < arr.length) {
      
      line(x, y, arr[p+1].x, arr[p+1].y);
    }
    if(be == 3){
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
  
  Pair(float ex, float why){
    x = ex;
    y = why;
  }
  
}