
// The player Class!
// this is where all of the movment takes place, 
// making sure that the player only moves one tile at a time,
// in a straight line and clicking with the grid.
// also smooths movement so it doesent snap to the grid imediately.

class Player {
  int gridX, gridY;  // Current grid coordinates
  float x, y;        // Actual drawing position for smooth movement
  float targetX, targetY;
  int size;
  color col;
  Grid grid;
  boolean isMoving = false;

  Player(Grid grid, int startGX, int startGY, color col) {
    this.grid = grid;
    this.gridX = startGX;
    this.gridY = startGY;
    this.size = grid.tileSize;
    this.col = col;
    this.x = gridX * size;
    this.y = gridY * size + grid.offsetY;
    this.targetX = x;
    this.targetY = y;
  }

  void update() {
    // Smooth movement toward target tile
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
    fill(col);
    noStroke();
    rect(x, y, size, size);
  }

  void move(int dx, int dy) {
    if (isMoving) return;  // already moving

    int newGX = gridX + dx;
    int newGY = gridY + dy;

    // Stay inside grid bounds
    if (newGX < 0 || newGX >= grid.cols || newGY < 0 || newGY >= grid.rows) return;

    // Check if a pushable tile exists
    boolean pushed = false;
    for (PushableTile pt : grid.pushables) {
      if (pt.gridX == newGX && pt.gridY == newGY) {
        pushed = grid.pushTile(newGX, newGY, dx, dy);
        if (!pushed) return; // Can't move if push blocked
        break;
      }
    }

    // Check static collision (solids or unmovable pushables)
    if (!pushed && grid.isSolid(newGX, newGY)) return;

    // Move player
    gridX = newGX;
    gridY = newGY;
    targetX = gridX * size;
    targetY = gridY * size + grid.offsetY;
    isMoving = true;
  }
}
