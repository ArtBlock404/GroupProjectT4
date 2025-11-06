Grid grid;
PImage[] tileSprites;

void setup() {
  size(800, 900);
  background(0);

  // 1. Load tile images
  tileSprites = new PImage[10];
  tileSprites[0] = loadImage("grass.jpg");
  tileSprites[1] = loadImage("dirt.png");
  tileSprites[2] = loadImage("water.png");
  tileSprites[3] = loadImage("stone.png");
  tileSprites[4] = loadImage("sand.png");
  tileSprites[5] = loadImage("snow.png");
  tileSprites[6] = loadImage("lava.png");
  tileSprites[7] = loadImage("wood.png");
  tileSprites[8] = loadImage("brick.png");
  tileSprites[9] = loadImage("void.png");

  // 2. Create grid (10x10)
  int cols = 10;
  int rows = 10;
  int tileSize = 800 / cols;
  int offsetY = 100;
  grid = new Grid(cols, rows, tileSize, offsetY, tileSprites);

  // 3. Assign tiles directly in code
  // Example pattern:
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (y < 3) grid.setTileSprite(x, y, 0);   // top 3 rows = grass
      else if (y < 6) grid.setTileSprite(x, y, 1); // middle rows = dirt
      else grid.setTileSprite(x, y, 2);         // bottom rows = water
    }
  }

  // You can override specific tiles:
  grid.setTileSprite(5, 5, 6); // lava in the center
  grid.setTileSprite(0, 9, 4); // sand bottom left
}

void draw() {
  background(0);
  grid.display();
}
