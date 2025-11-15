
// TABLE OF CONTENTS
// 21 - 40: setup
// 44 - 56: draw
// 107 - 127: draw - one
// 59 - 77: keypressed & mousepressed
// 81 - 104: settings screen & start screen
// 130 - 148: load & advance level
// 149 - 200+: setup# levels


import java.util.ArrayList;

Grid grid;
PImage[] tileSprites;
Player player;
Button[] buttons = new Button[3];
char screen = 'M'; // M = main menu, S = settings, C = credits, P = play
PImage[] buttonSprites;

Button btnPlay, btnSettings, btnCredits, btnBack;

int level = 1;
int cols = 10;
int rows = 10;
int tileSize = 800 / cols;
int offsetY = 100;

PFont PixelFont;

void setup() {
  size(800, 900);

PixelFont = createFont("PixelFont.ttf", 32); 
  textFont(PixelFont);

  buttonSprites = new PImage[4];
  buttonSprites[0] = loadImage("play.png");
  buttonSprites[1] = loadImage("settings.png");
  buttonSprites[2] = loadImage("back.png");
  buttonSprites[3] = loadImage("none.png");


  tileSprites = new PImage[2];
  tileSprites[0] = loadImage("Test.png"); // example
  tileSprites[1] = loadImage("Test2.PNG"); // example

  btnPlay = new Button(400, 400, 350, 150, "Play", 150, 3);
  btnSettings = new Button (400, 600, 200, 80,"Settings",50, 3);
  btnBack = new Button(100, 825, 100, 100,"Back",50, 3);


  tileSize = 800 / cols;
  offsetY = 100;

  loadLevel(level);
}

void draw() {
  switch(screen) {
  case 'M':
    startscreen();
    break;
  case 'S':
    settingscreen();
    break;
  case 'P':
    levelDraw();
    break;
  }
}

void keyPressed() {
  //Player movement
  if (key == 'w' || key == 'W' || keyCode == UP) player.move(0, -1);
  if (key == 's' || key == 'S' || keyCode == DOWN) player.move(0, 1);
  if (key == 'a' || key == 'A' || keyCode == LEFT) player.move(-1, 0);
  if (key == 'd' || key == 'D' || keyCode == RIGHT) player.move(1, 0);
}

void mousePressed() {
  switch(screen) {
  case 'M':
    if (btnPlay.clicked()) {
      screen = 'P';
      break;
    } else if (btnSettings.clicked()) {
      screen = 'S';
      break;
    } else if (btnBack.clicked()) {
      screen = 'M';
      break;
    }
  }
  println("screen:" + screen);
}


void settingscreen() {
  //The settings screen
  background(0);
  fill(255);
  btnBack.display();
}

void startscreen() {
  //Main menu
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(70);
  text("DELARIUM", 400, 100);
  btnPlay.display();
  btnSettings.display();
}

void levelDraw() {
  background(0);
  grid.displayLayers(0, 2);


  grid.updatePushables();
  grid.displayPushables();


  player.update();
  player.display();


  grid.displayLayers(3, 4);

  grid.displayDoors();

  grid.checkDoors(player);
}

void loadLevel(int lvl) {
  level = lvl;

  grid = new Grid(cols, rows, tileSize, offsetY, tileSprites);

  if (level ==1) {
    setupOne();
  } else if (level == 2) {
    setupTwo();
  } else {
    setupEmptyLevel();
  }

  println("Loaded level" + level);
}

void advanceToNextLevel() {
  loadLevel(level + 1);
}

// v LEVEL CODE v

void setupOne() { // each level should have a corresponding setup+levelnumber

  grid.setTileSprite(0, 1, 3, 0);
  grid.setTileSprite(0, 2, 3, 0);
  grid.setSolid(0, 1, true);
  grid.setSolid(0, 2, true);
  grid.addPushableTile(4, 4, 2, 0);
  grid.addDoor(2, 2, 1);
  player = new Player(grid, 0, 0, color(255, 200, 0));
}

void setupTwo() {

  grid.setTileSprite(1, 1, 0, 0);
  grid.setSolid(1, 1, true);
  grid.setTileSprite(2, 1, 0, 0);
  grid.setSolid(2, 1, true);
  grid.setTileSprite(3, 1, 0, 0);
  grid.setSolid(3, 1, true);
  grid.addPushableTile(4, 4, 2, 0);

  grid.addDoor(8, 8, 1);

  player = new Player(grid, 5, 5, color(255, 200, 0));
}

void setupThree() {
  grid.setTileSprite(1, 1, 0, 0);
  grid.setSolid(1, 1, true);
  grid.setTileSprite(2, 1, 0, 0);
  grid.setSolid(2, 1, true);
  grid.setTileSprite(3, 1, 0, 0);
  grid.setSolid(3, 1, true);
  grid.setTileSprite(3, 2, 0, 0);
  grid.setSolid(3, 2, true);
  grid.addPushableTile(4, 4, 2, 0);

  grid.addDoor(8, 8, 1);

  player = new Player(grid, 5, 5, color(255, 200, 0));
}

void setupFour() {
  grid.setTileSprite(1, 1, 0, 0);
  grid.setSolid(1, 1, true);
  grid.setTileSprite(2, 1, 0, 0);
  grid.setSolid(2, 1, true);
  grid.setTileSprite(3, 1, 0, 0);
  grid.setSolid(3, 1, true);
  grid.setTileSprite(3, 2, 0, 0);
  grid.setSolid(3, 2, true);
  grid.addPushableTile(4, 4, 2, 0);

  grid.addDoor(8, 8, 1);

  player = new Player(grid, 5, 5, color(255, 200, 0));
}

void setupEmptyLevel() { // just in case there is no next level so the game doesnt crash

  player = new Player(grid, 0, 0, color(255, 200, 0));
}

