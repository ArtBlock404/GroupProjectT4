
class ButtonTile {
  int gridX, gridY;
  int tileSize;
  int offsetY;
  PImage sprite;
  boolean triggered = false;

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


boolean checkPushableTile (PushableTile p) {
    if (triggered) return false;
    
    if (p.gridX == gridX && p.gridY == gridY && !p.isMoving) {
      triggered = true;
      return true;
    }
    return false;
  }
}
