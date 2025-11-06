class Grid {
  int cols, rows;
  int tileSize;
  int offsetY;
  Tile[][] tiles;
  PImage[] sprites;

  Grid(int cols, int rows, int tileSize, int offsetY, PImage[] sprites) {
    this.cols = cols;
    this.rows = rows;
    this.tileSize = tileSize;
    this.offsetY = offsetY;
    this.sprites = sprites;

    tiles = new Tile[cols][rows];

    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        int posX = x * tileSize;
        int posY = y * tileSize + offsetY;
        tiles[x][y] = new Tile(x, y, posX, posY, tileSize, sprites);
      }
    }
  }

  void display() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        tiles[x][y].display();
      }
    }
  }

  // Set tile sprite by grid coordinates
  void setTileSprite(int gx, int gy, int spriteIndex) {
    if (gx >= 0 && gx < cols && gy >= 0 && gy < rows) {
      tiles[gx][gy].setSprite(spriteIndex);
    }
  }
}
