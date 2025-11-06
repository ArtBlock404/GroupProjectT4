// Angie Liu | 6 Nov 2025 | Delarium

Button[] buttons = new Button[2];

void setup() {
  size(800,900);
  buttons[0] = new Button(400,400,300,100,255, "Play");
  buttons[1] = new Button(400,550,300,100,255, "Settings");
  
}

void draw() {
  background(0);
  for (int i = 0; i<buttons.length; i++) {
    buttons[i].display();
  }
  fill(255);
  textSize(70);
  text("DELARIUM", 400,150);
}


class Button {
  //Member Variables
  int x, y, w, h;
  color c1;
  String text;
  
  
  //Constructor
  Button(int x, int y, int w, int h, color c1, String text) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c1 = c1;
    this.text = text;
  }
  
  //Member Methods
  void display() {
    rectMode(CENTER);
    fill(255);
    rect(x, y, w, h);
    fill(0,0,40);
    textAlign(CENTER,CENTER);
    textMode(CENTER);
    textSize(40);
    text(text, x, y);
  }
  
}
