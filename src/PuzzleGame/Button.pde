// Angie Liu | 6 Nov 2025 | Delarium

Button[] buttons = new Button[2];


void setup() {
  size(800,900);
  buttons[0] = new Button(400,500,400,400, true);
  buttons[1] = new Button(600,650,100,100, false);
  
  
}

void draw() {
  background(0);
  for (int i = 0; i<buttons.length; i++) {
    buttons[i].display();
  }
  textAlign(CENTER,CENTER);
  textMode(CENTER);
  fill(255);
  textSize(70);
  text("DELARIUM", 400,150);
}


class Button {
  //Member Variables
  PImage p1, p2;
  int x, y, w, h;
  color c1;
  String text;
  boolean play;
  
  
  //Constructor
  Button(int x, int y, int w, int h, boolean play) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.play = play;
    p1 = loadImage("https://www.freepnglogos.com/uploads/play-button-png/index-media-cover-art-play-button-overlay-5.png");
    p2 = loadImage("https://img.icons8.com/m_rounded/512/FFFFFF/settings.png");
    
  }
  
  //Member Methods
  void display() {
    imageMode(CENTER);
    p1.resize(h,w);
    p2.resize(h,w);
    if(play == true) {
    image(p1,x,y);
    } else {
      image(p2,x,y);
    }
  }
  
}
