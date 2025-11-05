// Angie Liu | 4 Nov 2025 | Arrow Class

Arrow[] arrows = new Arrow[3];

void setup() {
  size(400,400);
  
  arrows[0] = new Arrow(width,200);
  arrows[1] = new Arrow(width,300);
  arrows[2] = new Arrow(width,100);
}

void draw() {
  background(255);
  for (int i = 0; i<arrows.length; i = i + 1) {
    arrows[i].display();
    arrows[i].move();
  }
}
