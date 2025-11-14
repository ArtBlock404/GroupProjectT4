
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
    over = false;
    
  }

  //Member Methods
  void display() {
    fill(255);
    rectMode(CENTER);
    rect(x,y,w,h);
    textAlign(CENTER, CENTER);
    textMode(CENTER);
    textSize(50);
    text(val,x,y);
  }
  
  boolean clicked() {
    return (mouseX > x -w/2 && mouseX < x+w/2 && mouseY > y - h/2 && mouseY < y+h/2);
  }
}
