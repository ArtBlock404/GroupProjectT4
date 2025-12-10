
// This is the button tile class, it activates when it detects a pushable object on top of it triggering another block to not be solid.
// This will only happen when the set umber of buttons are triggered

class ButtonTile {
  int gridX, gridY;
  int tileSize, offsetY;

  PImage sprite;

  int targetX, targetY;        // tile the button affects
  int newSpriteIndex;          // sprite to show when pressed
  int revertSpriteIndex = -1;  // sprite to show when released
  boolean newSolid;

  int triggerNum = 1;
  int triggered = 0;
  boolean isPressed = false;

  // old state (optional, can be used for solid)
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
