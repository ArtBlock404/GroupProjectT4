
// The grd that stores all the tiles and funtions!
//this calls all of the tiles to the screen so we dont have to add all that code in the main tab.
//  funtions like this; "if (gx >= 0 && gx < cols && gy >= 0 && gy < rows)" make sure that no tiles are out of bounds, as them being so would crash the game.
// nested loops like this:
//for (int x = 0; x < cols; x++) {
     // for (int y = 0; y < rows; y++) {
// , check all tiles in a row and collumn so we dont need 50 more lines of code.

class Grid {
  int cols, rows;
  int tileSize;
  int offsetY;
  Tile[][] tiles;
  PImage[] sprites;
  ArrayList<PushableTile> pushables;
  ArrayList<DoorTile> doors;

  Grid(int cols, int rows, int tileSize, int offsetY, PImage[] sprites) {
    this.cols = cols;
    this.rows = rows;
    this.tileSize = tileSize;
    this.offsetY = offsetY;
    this.sprites = sprites;
    this.pushables = new ArrayList<PushableTile>();
    this.doors = new ArrayList<DoorTile>();


    tiles = new Tile[cols][rows];
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        tiles[x][y] = new Tile(x, y, tileSize, sprites, offsetY);
      }
    }
  }

  void setTileSprite(int gx, int gy, int layer, int spriteIndex) {
    if (gx >= 0 && gx < cols && gy >= 0 && gy < rows) {
      tiles[gx][gy].setSprite(layer, spriteIndex);
    }
  }

  void displayLayers(int startLayer, int endLayer) {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        tiles[x][y].displayRange(startLayer, endLayer);
      }
    }
  }

  void setSolid(int gx, int gy, boolean value) {
    if (gx >= 0 && gx < cols && gy >= 0 && gy < rows) {
      tiles[gx][gy].solid = value;
    }
  }

  boolean isSolid(int gx, int gy) {
    if (gx >= 0 && gx < cols && gy >= 0 && gy < rows) {
      return tiles[gx][gy].solid;
    }
    return true;
  }

  boolean isOccupied(int gx, int gy, PushableTile ignore) {
    for (PushableTile pt : pushables) {
      if (pt != ignore && pt.gridX == gx && pt.gridY == gy) return true;
    }
    return isSolid(gx, gy);
  }

  void addPushableTile(int gx, int gy, int layer, int spriteIndex) {
    PushableTile pt = new PushableTile(gx, gy, tileSize, offsetY, sprites[spriteIndex], layer);
    pushables.add(pt);
  }

  boolean pushTile(int gx, int gy, int dx, int dy) {
    for (PushableTile pt : pushables) {
      if (pt.gridX == gx && pt.gridY == gy) {
        int nx = gx + dx;
        int ny = gy + dy;
        if (nx < 0 || nx >= cols || ny < 0 || ny >= rows) return false;
        if (isOccupied(nx, ny, pt)) return false;
        pt.moveTo(nx, ny);
        return true;
      }
    }
    return false;
  }

  void updatePushables() {
    for (PushableTile pt : pushables) {
      pt.update();
    }
  }

  void displayPushables() {
    for (PushableTile pt : pushables) {
      pt.display();
    }
  }

  void addDoor(int gx, int gy, int spriteIndex) {

    PImage sprite = null;
    if (spriteIndex >= 0 && spriteIndex < sprites.length) sprite = sprites[spriteIndex];
    DoorTile d = new DoorTile(gx, gy, tileSize, offsetY, sprite);
    doors.add(d);
  }
  
  void displayDoors() {
    for (DoorTile d : doors) {
      d.display();
    }
  }
  
  void checkDoors(Player p) {
    for (DoorTile d : doors) {
      if (d.checkPlayer(p)) {
        println("Door triggered at " + d.gridX + "," + d.gridY + " -> advancing level");
        advanceToNextLevel();
        return; 
      }
    }
  }


 void addButton(int gx, int gy, int spriteIndex) {
    PImage sprite = null;
    if (spriteIndex >= 0 && spriteIndex < sprites.length) sprite = sprites[spriteIndex];

    ButtonTile b = new ButtonTile();
    b.gridX = gx;
    b.gridY = gy;
    b.tileSize = tileSize;
    b.offsetY = offsetY;
    b.sprite = sprite;

    buttons.add(b);
  }
  void displayButtons() {
    for (ButtonTile b : buttons) {
      b.display();
    }
  }

  void checkButtons() {
    for (ButtonTile b : buttons) {
      for (PushableTile pt : pushables) {
        if (b.checkPushableTile(pt)) {
          println("BUTTON triggered at " + b.gridX + "," + b.gridY);
          onButtonTriggered(b);
          return;
        }
      }
    }
  }
  void onButtonTriggered(ButtonTile b) {
  // You can replace this with whatever you want the button to do
  println("Button triggered!");
}
}

}
