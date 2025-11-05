class Arrow {
  int x, y;
  boolean hit;
  float speed;

  void setup() {
    size(400, 400);
  }

  //Constructor
  Arrow(int x, int y) {
    this.x = x;
    this.y = y;
    speed = random(1,10);
  }

  // Member Methods
  void display () {
    rectMode(CENTER);
    fill(122, 80, 6);
    rect(x, y, 50, 7);
    fill(255);
    triangle(x-35, y, x-25, y+10, x-25, y-10);
    fill(255, 0, 0);
    quad(x+25, y-3, x+35, y-11, x+35, y+11, x+25, y+3);
  }

  void move() {
    x-=speed;
    if (x<0) {
      x=width;
    }
  }

  void damage() {
  }
}
