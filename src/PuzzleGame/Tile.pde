class Tile {
  int gridX, gridY;
  int size;
  int[] spriteIndices;
  PImage[] sprites;
  boolean solid = false;
  int numLayers = 4;
  int offsetY;

  Tile(int gridX, int gridY, int size, PImage[] sprites, int offsetY) {
    this.gridX = gridX;
    this.gridY = gridY;
    this.size = size;
    this.sprites = sprites;
    this.offsetY = offsetY;
    spriteIndices = new int[numLayers];
    for (int i = 0; i < numLayers; i++) spriteIndices[i] = -1;
  }

  void display() {
    displayRange(0, numLayers-1);
  }

  void displayRange(int startLayer, int endLayer) {
    noStroke();
    for (int i = startLayer; i <= endLayer && i < spriteIndices.length; i++) {
      int idx = spriteIndices[i];
      int px = gridX * size;
      int py = gridY * size + offsetY;

      if (idx >= 0 && idx < sprites.length && sprites[idx] != null) {
        image(sprites[idx], px, py, size, size);
      } else if (i == 0 && startLayer == 0) {
        fill(40);
        rect(px, py, size, size);
      }
    }
  }

  void setSprite(int layer, int index) {
    if (layer >= 0 && layer < numLayers && index >= 0 && index < sprites.length) {
      spriteIndices[layer] = index;
    }
  }
}
