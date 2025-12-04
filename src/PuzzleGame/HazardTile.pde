class HazardTile {
  int gridX, gridY;
  int tileSize;
  int offsetY;
  PImage sprite;

  HazardTile(int gx, int gy, int tileSize, int offsetY, PImage sprite) {
    this.gridX = gx;
    this.gridY = gy;
    this.tileSize = tileSize;
    this.offsetY = offsetY;
    this.sprite = sprite;
  }

  void display() {
    int px = gridX * tileSize;
    int py = gridY * tileSize + offsetY;
    image(sprite, px, py, tileSize, tileSize);
  }

  boolean isOnHazard(Player p) {
    return p.gridX == gridX && p.gridY == gridY && !p.isMoving;
  }
}
