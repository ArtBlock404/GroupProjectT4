class Button {
  //Member Variables
  PImage p1;
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
    //if (image == 'P') {
    //  p1 = loadImage("https://github.com/ArtBlock404/GroupProjectT4/blob/main/images/playbutton.png?raw=true");
    //} else if (image == 'S') {
    //  p1 = loadImage("https://github.com/ArtBlock404/GroupProjectT4/blob/main/images/settingsicon.png?raw=true");
    //} else if (image == 'B') {
    //  p1 = loadImage("https://github.com/ArtBlock404/GroupProjectT4/blob/main/images/backarrow.png?raw=true");
    //}
  }

  //Member Methods
  void display() {
    imageMode(CENTER);
    textAlign(CENTER,CENTER);
    textMode(CENTER);
    textSize(50);
    fill(255);
    rectMode(CENTER);
    rect(x,y,w,h);
    fill(0);
    text(val,x,y);
    //if (image == 'P') {
    //  p1.resize(h, w);
    //  image(p1, x, y);
    //} else if (image == 'S') {
    //  p1.resize(h, w);
    //  image(p1, x, y);
    //} else if (image == 'B') {
    //  p1.resize(h, w);
    //  image(p1, x, y);
    //}
  }
  void hover(int tempX, int tempY) {
    if (x>tempX-w/2 && x<tempX+w/2 && y>tempY-h/2 && y<tempY+h/2) {
      over = true;
    } else {
      over = false;
    }
  }
}
