Grid grid;
PImage[] tileSprites;

void setup() {
  size(800, 900);
  background(0);

  
  tileSprites = new PImage[10];
  tileSprites[0] = loadImage("_");
  tileSprites[1] = loadImage("_");
  tileSprites[2] = loadImage("_");
  tileSprites[3] = loadImage("_");
  tileSprites[4] = loadImage("_");
  tileSprites[5] = loadImage("_");
  tileSprites[6] = loadImage("_");
  tileSprites[7] = loadImage("_");
  tileSprites[8] = loadImage("_");
  tileSprites[9] = loadImage("_");

  
  int cols = 10;
  int rows = 10;
  int tileSize = 800 / cols;
  int offsetY = 100;
  grid = new Grid(cols, rows, tileSize, offsetY, tileSprites);

  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (y < 3) grid.setTileSprite(x, y, 0);   // top 3 rows = grass
      else if (y < 6) grid.setTileSprite(x, y, 1); // middle rows = dirt
      else grid.setTileSprite(x, y, 2);         // bottom rows = water
    }
  }

  
  grid.setTileSprite(5, 5, 6); // lava in the center
  grid.setTileSprite(0, 9, 4); // sand bottom left
}

void draw() {
  background(0);
  grid.display();
}
