class ButtonTile {
  int gridX, gridY;
  int tileSize;
  int offsetY;
  PImage sprite;

  boolean triggered = false;

  // NEW REQUIRED FIELDS
  int targetX, targetY;
  int newSpriteIndex;
  boolean newSolid;

  int oldSpriteIndex = -1;
  boolean oldSolid;

  void display() {
    int px = gridX * tileSize;
    int py = gridY * tileSize + offsetY;

    if (sprite != null) {
      image(sprite, px, py, tileSize, tileSize);
    } else {
      noStroke();
      fill(0, 0, 255);
      rect(px, py, tileSize, tileSize);
    }
  }

  boolean isOnButton(PushableTile p) {
    return (p.gridX == gridX && p.gridY == gridY);
  }
}
