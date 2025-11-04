// Angie Liu | 4 Nov 2025 | Arrow Class

//Member Variables
int x, y, h, w, spd;
boolean hit;

void setup() {
  size(400,400);
}

void draw() {
  background (255,255,220);
  rectMode(CENTER);
  
  //Constructor
  fill(122, 80, 6);
  rect(200,200, 50, 7);
  fill(255);
  triangle(165,200,175,210,175,190);
  fill(255,0,0);
  quad(225,197,235,189,235,211,225,203);
}

void move() {}

void damage() {}
