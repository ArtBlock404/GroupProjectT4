
// the button class, mainly for the title and settings screen
// makes pushable buttons in the main tab

class Button {
  //Member Variables
  PImage p1,p2,p3;
  int x, y, w, h;
  //char image;
  boolean over;
  String val;


  //Constructor
  Button(int x, int y,int w, int h, String val) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.val = val;
    //image = ' ';
    over = false;
    if (val.equals("PLAY")) {
      p1 = loadImage("play.png");
    } else if (val.equals("SETTINGS")) {
      p2 = loadImage("settings.png");
    } else if (val.equals("BACK")) {
      p3 = loadImage("back.png");
    }
  }

  //Member Methods
  void display() {
    if (val.equals("PLAY")) {
      image(p1, 200, 300);
    } else if (val.equals("SETTINGS")) {
      image(p2, 225, 525);
    } else if (val.equals("BACK")) {
      image(p3, 25, 25);
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
