class Button {
  //Member Variables
  PImage p1;
  int x, y, w, h;
  color c1;
  String text;
  char image;
  boolean over;


  //Constructor
  Button(int x, int y, int w, int h, char image) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    image = ' ';
    over = false;
    if (image == 'P') {
      p1 = loadImage("https://www.freepnglogos.com/uploads/play-button-png/index-media-cover-art-play-button-overlay-5.png");
    } else if (image == 'S') {
      p1 = loadImage("https://img.icons8.com/m_rounded/512/FFFFFF/settings.png");
    } else if (image == 'B') {
      p1 = loadImage("");
    }
  }

  //Member Methods
  void display() {
    imageMode(CENTER);
    
    if (image == 'P') {
      p1.resize(h, w);
      image(p1, x, y);
    } else if (image == 'S') {
      p1.resize(h, w);
      image(p1, x, y);
    } else if (image == 'B') {
      p1.resize(h, w);
      image(p1, x, y);
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
