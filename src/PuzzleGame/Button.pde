// Angie Liu | 6 Nov 2025 | Delarium

Button[] buttons = new Button[1];

void setup() {
  size(800,900);
  buttons[0] = new Button(400,600,350,350,"play",255);
  
}

void draw() {
  background(0);
  for (int i = 0; i<buttons.length; i++) {
    buttons[i].display();
  }
}


class Button {
  //Member Variables
  int x, y, w, h;
  color c1;
  String val;
  
  
  //Constructor
  Button(int x, int y, int w, int h, String val, color c1) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.val = val;
    this.c1 = c1;
  }
  
  //Member Methods
  void display() {
    rectMode(CENTER);
    fill(255);
    rect(x, y, w, h);
  }
  
}
