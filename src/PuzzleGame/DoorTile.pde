class DoorTile {
  int gridX, gridY;
  int tileSize;
  int offsetY;
  PImage sprite;
  boolean triggered = false;

  DoorTile(int gx, int gy, int tileSize, int offsetY, PImage sprite) {
    this.gridX = gx;
    this.gridY = gy;
    this.tileSize = tileSize;
    this.offsetY = offsetY;
    this.sprite = sprite;
  }

  void display() {
    int px = gridX * tileSize;
    int py = gridY * tileSize + offsetY;
    if (sprite != null) {
      image(sprite, px, py, tileSize, tileSize);
    } else {
      // fallback visual so you can see the door if no sprite assigned
      noStroke();
      fill(0, 0, 255);
      rect(px, py, tileSize, tileSize);
    }
  }

  // returns true if the door triggered now
  boolean checkPlayer(Player p) {
    // trigger only once per door (you can reset triggered if you want repeatable doors)
    if (triggered) return false;
    // require player grid coords match AND player is at rest (fully finished moving)
    if (p.gridX == gridX && p.gridY == gridY && !p.isMoving) {
      triggered = true;
      return true;
    }
    return false;
  }
}

