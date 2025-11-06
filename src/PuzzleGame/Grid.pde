class Grid {
  int cols, rows;
  int tileSize;
  int offsetY;
  Tile[][] tiles;

  Grid(int cols, int rows, int tileSize, int offsetY) {
    this.cols = cols;
    this.rows = rows;
    this.tileSize = tileSize;
    this.offsetY = offsetY;
    tiles = new Tile[cols][rows];
    
    // Create all tiles
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        int posX = x * tileSize;
        int posY = y * tileSize + offsetY;  // Shift grid down
        tiles[x][y] = new Tile(x, y, posX, posY, tileSize);
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
}
