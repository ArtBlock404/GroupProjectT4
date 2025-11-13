class Button {
  //Member Variables
  PImage p1,p2,p3;
  int x, y, w, h;
  //char image;
  boolean over;
  String val;


  //Constructor
  Button(int x, int y, int w, int h, String val) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.val = val;
    //image = ' ';
    over = false;
    if (val.equals("PLAY")) {
      p1 = loadImage("playbutton.png");
    } else if (val.equals("SETTINGS")) {
      p2 = loadImage("settingsicon.png");
    } else if (val.equals("BACK")) {
      p3 = loadImage("backarrow.png");
    }
  }

  //Member Methods
  void display() {
    if (val.equals("PLAY")) {
      p1.resize(w,h);
      image(p1, 200, 250);
    } else if (val.equals("SETTINGS")) {
      p2.resize(w,h);
      image(p2, 300, 600);
    } else if (val.equals("BACK")) {
      p3.resize(w,h);
      image(p3, x, y);
    }
  }
  void hover(int tempX, int tempY) {
    if (x>tempX-w/2 && x<tempX+w/2 && y>tempY-h/2 && y<tempY+h/2) {
      over = true;
    } else {
      over = false;
    }
  }
}
