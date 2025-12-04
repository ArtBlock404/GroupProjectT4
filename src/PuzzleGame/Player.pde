class Player {
  int gridX, gridY;
  float x, y;
  float targetX, targetY;
  int size;
  Grid grid;
  boolean isMoving = false;

  PImage[] walkUp, walkDown, walkLeft, walkRight;
  PImage[] idleUp, idleDown, idleLeft, idleRight;
  PImage[] currentAnim;

  int frame = 0;
  int timer = 0;
  int speed = 8;
  String dir = "down";

  Player(Grid grid, int gx, int gy) {
    this.grid = grid;
    this.gridX = gx;
    this.gridY = gy;
    this.size = grid.tileSize;
    this.x = gx * size;
    this.y = gy * size + grid.offsetY;
    this.targetX = x;
    this.targetY = y;
    loadAnimations();
    currentAnim = idleDown;
  }

  void loadAnimations() {
    walkUp = new PImage[]{ loadImage("Player.png"), loadImage("Player.png"), loadImage("Player.png") };
    walkDown = new PImage[]{ loadImage("Player.png"), loadImage("Player.png"), loadImage("Player.png") };
    walkLeft = new PImage[]{ loadImage("Player.png"), loadImage("Player.png"), loadImage("Player.png") };
    walkRight = new PImage[]{ loadImage("Player.png"), loadImage("Player.png"), loadImage("Player.png") };
    idleUp = new PImage[]{ loadImage("Player.png")};
    idleDown = new PImage[]{ loadImage("Player.png") };
    idleLeft = new PImage[]{ loadImage("Player.png") };
    idleRight = new PImage[]{ loadImage("Player.png") };
  }

  void update() {
    if (isMoving) {
      x = lerp(x, targetX, 0.3);
      y = lerp(y, targetY, 0.3);
      timer++;
      if (timer >= speed) {
        timer = 0;
        frame = (frame + 1) % currentAnim.length;
      }
      if (dist(x, y, targetX, targetY) < 1) {
        x = targetX;
        y = targetY;
        isMoving = false;
        frame = 0;
        setIdleAnim();
      }
    }
  }

  void display() {
    image(currentAnim[frame], x, y, size, size);
  }

  void setIdleAnim() {
    if (dir == "up") currentAnim = idleUp;
    if (dir == "down") currentAnim = idleDown;
    if (dir == "left") currentAnim = idleLeft;
    if (dir == "right") currentAnim = idleRight;
  }

  void move(int dx, int dy) {
    if (isMoving) return;

    if (dx == 1) { dir = "right"; currentAnim = walkRight; }
    if (dx == -1) { dir = "left"; currentAnim = walkLeft; }
    if (dy == 1) { dir = "down"; currentAnim = walkDown; }
    if (dy == -1) { dir = "up"; currentAnim = walkUp; }

    int newGX = gridX + dx;
    int newGY = gridY + dy;

    if (newGX < 0 || newGX >= grid.cols || newGY < 0 || newGY >= grid.rows) return;

    boolean pushed = false;
    for (PushableTile pt : grid.pushables) {
      if (pt.gridX == newGX && pt.gridY == newGY) {
        pushed = grid.pushTile(newGX, newGY, dx, dy);
        if (!pushed) return;
        break;
      }
    }

    if (!pushed && grid.isSolid(newGX, newGY)) return;
    if (!pushed && grid.isOccupied(newGX, newGY, null)) return;

    gridX = newGX;
    gridY = newGY;
    targetX = gridX * size;
    targetY = gridY * size + grid.offsetY;
    frame = 0;
    timer = 0;
    isMoving = true;
  }
}
