Grid grid;

void setup() {
  size(800, 900);
  background(0);
  
  int cols = 10;
  int rows = 10;
  int tileSize = 800 / cols; // 80px per tile
  int offsetY = 100;         // start grid at y = 100

  grid = new Grid(cols, rows, tileSize, offsetY);
}

void draw() {
  background(0);
  grid.display();
}

// Optional: test interaction with mouse
void mousePressed() {
  grid.handleClick(mouseX, mouseY);
}
