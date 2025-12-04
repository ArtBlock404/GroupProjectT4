class Grid {
  int cols, rows;
  int tileSize;
  int offsetY;
  int DOOR_LAYER = 2;

  Tile[][] tiles;
  PImage[] sprites;

  ArrayList<PushableTile> pushables = new ArrayList<>();
  ArrayList<ButtonTile> buttons = new ArrayList<>();
  ArrayList<DoorTile> doors = new ArrayList<>();

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
    for (PushableTile p : pushables) {
      if (p.gridX == gx && p.gridY == gy) {
        int nx = gx + dx, ny = gy + dy;
        if (nx < 0 || nx >= cols || ny < 0 || ny >= rows) return false;
        if (isOccupied(nx, ny, p)) return false;
        p.moveTo(nx, ny);
        return true;
      }
    }
    return false;
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


  // --------------------------------------------------------------------
  // BUTTONS
  // --------------------------------------------------------------------
  void addButton(int bx, int by,
    int spriteIndex,
    int targetX, int targetY,
    int newSpriteIndex, boolean newSolid,
    int triggerNum
  ) {

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
    b.newSolid = newSolid;

    b.triggerNum = triggerNum;

    buttons.add(b);
  }

  void displayButtons() {
    for (ButtonTile b : buttons) b.display();
  }


  void checkButtons() {
    for (ButtonTile b : buttons) {

      boolean pressedNow = false;

      // detect new press
      for (PushableTile block : pushables) {
        if (b.isOnButton(block)) {
          pressedNow = true;
          break;
        }
      }

      // BUTTON PRESSED THIS FRAME
      if (pressedNow && !b.isPressed) {
        b.isPressed = true;
        b.triggered++;

        if (b.triggered == b.triggerNum) {
          onButtonTriggered(b);
        }
      }

      // BUTTON RELEASED THIS FRAME
      if (!pressedNow && b.isPressed) {
        b.isPressed = false;
        b.triggered--;
        if (b.triggered < 0) b.triggered = 0;

        if (b.triggered < b.triggerNum) {
          onButtonReleased(b);
        }
      }
    }
  }

  void onButtonTriggered(ButtonTile b) {
    println("ALL BUTTONS ACTIVATED → opening");

    // save old tile state (only first time)
    if (b.oldSpriteIndex == -1) {
      b.oldSolid = isSolid(b.targetX, b.targetY);
      b.oldSpriteIndex = tiles[b.targetX][b.targetY].getSpriteIndex(DOOR_LAYER);
    }

    // apply new
    setTileSprite(b.targetX, b.targetY, DOOR_LAYER, b.newSpriteIndex);
    setSolid(b.targetX, b.targetY, b.newSolid);
  }

  void onButtonReleased(ButtonTile b) {
    println("Buttons below requirement → closing");

    if (b.oldSpriteIndex != -1) {
      setTileSprite(b.targetX, b.targetY, DOOR_LAYER, b.oldSpriteIndex);
      setSolid(b.targetX, b.targetY, b.oldSolid);
    }
  }
}
