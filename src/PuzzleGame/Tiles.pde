class Tile {
  int gridX, gridY;
  int x, y;
  int size;
  int spriteIndex = -1;
  PImage[] sprites;

  Tile(int gridX, int gridY, int x, int y, int size, PImage[] sprites) {
    this.gridX = gridX;
    this.gridY = gridY;
    this.x = x;
    this.y = y;
    this.size = size;
    this.sprites = sprites;
  }

  void display() {
    noStroke();

    if (spriteIndex >= 0 && spriteIndex < sprites.length && sprites[spriteIndex] != null) {
      image(sprites[spriteIndex], x, y, size, size);
    } else {
      fill(40);
      rect(x, y, size, size);
    }
  }

  void setSprite(int index) {
    if (index >= 0 && index < sprites.length) {
      spriteIndex = index;
    }
  }
}
