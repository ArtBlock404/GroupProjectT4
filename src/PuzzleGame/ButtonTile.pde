
class ButtonTile {
  int gridX, gridY;
  int tileSize, offsetY;

  PImage sprite;

  int targetX, targetY;
  int newSpriteIndex;
  boolean newSolid;

  int triggerNum = 1;
  int triggered = 0;
  boolean isPressed = false;

  int oldSpriteIndex = -1;
  boolean oldSolid;

  void display() {
    int px = gridX * tileSize;
    int py = gridY * tileSize + offsetY;

    if (sprite != null)
      image(sprite, px, py, tileSize, tileSize);
    else {
      fill(0, 0, 255);
      rect(px, py, tileSize, tileSize);
    }
  }

  boolean isOnButton(PushableTile p) {
    return (p.gridX == gridX && p.gridY == gridY);
  }
}
