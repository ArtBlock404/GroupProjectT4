
// this class records all of the tiles that the player can push.
// it mainly goes into the grid class to be displayed, but this lets it move and snap like a player
// while the player is pushing it.

class PushableTile {
  int gridX, gridY;
  float x, y;
  float targetX, targetY;
  int size;
  PImage sprite;
  int layer;
  boolean isMoving = false;
  float speed = 5;
  int offsetY;

  PushableTile(int gx, int gy, int size, int offsetY, PImage sprite, int layer) {
    this.gridX = gx;
    this.gridY = gy;
    this.size = size;
    this.offsetY = offsetY;
    this.sprite = sprite;
    this.layer = layer;
    this.x = gx * size;
    this.y = gy * size + offsetY;
    this.targetX = x;
    this.targetY = y;
  }

  void moveTo(int newGX, int newGY) {
    gridX = newGX;
    gridY = newGY;
    targetX = newGX * size;
    targetY = newGY * size + offsetY;
    isMoving = true;
  }

  void update() {
    if (isMoving) {
      x = lerp(x, targetX, 0.3);
      y = lerp(y, targetY, 0.3);
      if (dist(x, y, targetX, targetY) < 1) {
        x = targetX;
        y = targetY;
        isMoving = false;
      }
    }
  }

  void display() {
    image(sprite, x, y, size, size);
  }
}
