class Grid {
  int cols, rows;
  int tileSize;
  int offsetY;
  int DOOR_LAYER = 1;

  Tile[][] tiles;
  PImage[] sprites;

  ArrayList<PushableTile> pushables = new ArrayList<>();
  ArrayList<ButtonTile> buttons = new ArrayList<>();
  ArrayList<DoorTile> doors = new ArrayList<>();
  ArrayList<HazardTile> hazards = new ArrayList<>();


  Grid(int cols, int rows, int tileSize, int offsetY, PImage[] sprites) {
    this.cols = cols;
    this.rows = rows;
    this.tileSize = tileSize;
    this.offsetY = offsetY;
    this.sprites = sprites;

    tiles = new Tile[cols][rows];
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        tiles[x][y] = new Tile(x, y, tileSize, sprites, offsetY);
      }
    }
  }


  // --------------------------------------------------------------------
  // TILE CONTROL
  // --------------------------------------------------------------------
  void setTileSprite(int gx, int gy, int layer, int spriteIndex) {
    if (gx >= 0 && gx < cols && gy >= 0 && gy < rows) {
      tiles[gx][gy].setSprite(layer, spriteIndex);
    }
  }

  void displayLayers(int a, int b) {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        tiles[x][y].displayRange(a, b);
      }
    }
  }

  void setSolid(int gx, int gy, boolean s) {
    if (gx >= 0 && gx < cols && gy >= 0 && gy < rows) {
      tiles[gx][gy].solid = s;
    }
  }

  boolean isSolid(int gx, int gy) {
    if (gx >= 0 && gx < cols && gy >= 0 && gy < rows)
      return tiles[gx][gy].solid;
    return true;
  }


  // --------------------------------------------------------------------
  // PUSHABLE BLOCKS
  // --------------------------------------------------------------------
  void addPushableTile(int gx, int gy, int layer, int spriteIndex) {
    pushables.add(new PushableTile(
      gx, gy, tileSize, offsetY, sprites[spriteIndex], layer
      ));
  }

  boolean isOccupied(int gx, int gy, PushableTile ignore) {
    for (PushableTile p : pushables)
      if (p != ignore && p.gridX == gx && p.gridY == gy)
        return true;
    return isSolid(gx, gy);
  }

  boolean pushTile(int gx, int gy, int dx, int dy) {
  PushableTile current = null;

  // Find the pushable at this position
  for (PushableTile p : pushables) {
    if (p.gridX == gx && p.gridY == gy) {
      current = p;
      break;
    }
  }

  if (current == null) return false;

  int nx = gx + dx;
  int ny = gy + dy;

  // Bounds check
  if (nx < 0 || nx >= cols || ny < 0 || ny >= rows) return false;

  // If another pushable is in front, try to push it FIRST
  for (PushableTile p : pushables) {
    if (p != current && p.gridX == nx && p.gridY == ny) {
      if (!pushTile(nx, ny, dx, dy)) return false;
      break;
    }
  }

  // If the tile is solid after chain pushing → fail
  if (isSolid(nx, ny)) return false;

  // Move this pushable
  current.moveTo(nx, ny);
  return true;
}


  void updatePushables() {
    for (PushableTile p : pushables) p.update();
  }

  void displayPushables() {
    for (PushableTile p : pushables) p.display();
  }


  // --------------------------------------------------------------------
  // DOORS
  // --------------------------------------------------------------------
  void addDoor(int gx, int gy, int spriteIndex) {
    doors.add(new DoorTile(
      gx, gy, tileSize, offsetY, sprites[spriteIndex]
      ));
  }

  void displayDoors() {
    for (DoorTile d : doors) d.display();
  }

  void checkDoors(Player p) {
    for (DoorTile d : doors) {
      if (d.checkPlayer(p)) {
        advanceToNextLevel();
        return;
      }
    }
  }


  
  void addButton(int bx, int by,
    int spriteIndex,
    int targetX, int targetY,
    int newSpriteIndex, int revertSpriteIndex, boolean newSolid,
    int triggerNum) {

    PImage spr = sprites[spriteIndex];

    ButtonTile b = new ButtonTile();
    b.gridX = bx;
    b.gridY = by;
    b.tileSize = tileSize;
    b.offsetY = offsetY;

    b.sprite = spr;

    b.targetX = targetX;
    b.targetY = targetY;
    b.newSpriteIndex = newSpriteIndex;
    b.revertSpriteIndex = revertSpriteIndex; // <- new field
    b.newSolid = newSolid;
    b.triggerNum = triggerNum;

    buttons.add(b);
  }


  void displayButtons() {
    for (ButtonTile b : buttons) b.display();
  }


  void checkButtons() {
    for (ButtonTile b : buttons) {

      // Count how many pushables are on this button
      int numOnButton = 0;
      for (PushableTile block : pushables) {
        if (b.isOnButton(block)) numOnButton++;
      }

      boolean fullyPressed = (numOnButton >= b.triggerNum);

      // BUTTON PRESSED THIS FRAME
      if (fullyPressed && !b.isPressed) {
        b.isPressed = true;
        onButtonTriggered(b);
      }

      // BUTTON RELEASED THIS FRAME
      if (!fullyPressed && b.isPressed) {
        b.isPressed = false;
        onButtonReleased(b);
      }
    }
  }


  void onButtonTriggered(ButtonTile b) {
    println("ALL BUTTONS ACTIVATED → opening");

    // Overlay the new sprite above the door
    setTileSprite(b.targetX, b.targetY, DOOR_LAYER + 1, b.newSpriteIndex);
    setSolid(b.targetX, b.targetY, b.newSolid);
  }

 void onButtonReleased(ButtonTile b) {
  println("Buttons below requirement → closing");
  setTileSprite(b.targetX, b.targetY, DOOR_LAYER + 1, b.revertSpriteIndex);
  setSolid(b.targetX, b.targetY, !b.newSolid); // revert solidity
}




  void addHazard(int gx, int gy, int spriteIndex) {
    hazards.add(new HazardTile(
      gx, gy, tileSize, offsetY, sprites[spriteIndex]
      ));
  }

  void displayHazards() {
    for (HazardTile h : hazards) h.display();
  }

  void checkHazards(Player p) {
    for (HazardTile t : hazards) {
      if (t.isOnHazard(p)) {
        onHazardTriggered();
        return;
      }
    }
  }

  void onHazardTriggered() {
    screen = 'D';
    
    println("you have died");
  }
}
