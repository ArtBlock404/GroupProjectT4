//ANGIE LIU -- UI, SCREEN MANAGER, LEVEL DESIGN, LEVEL SETUP
//JONAH WHITE -- MAIN PROGRAMMING
//MAIZE ROBSON -- GRAPHICS, ART

// TABLE OF CONTENTS
// 21 - 40: setup
// 44 - 56: draw
// 107 - 127: draw - one
// 59 - 77: keypressed & mousepressed
// 81 - 104: settings screen & start screen
// 130 - 148: load & advance level
// 149 - 200+: setup# levels


import java.util.ArrayList;

float xpos;
float ypos;
float drag = 30.0;

Grid grid;
PImage[] tileSprites;
Player player;
Button[] buttons = new Button[4];
char screen = 'M'; // M = main menu, S = settings, C = credits, P = play, R = pause
PImage[] buttonSprites;
PImage titlesettings, titlecredits, titlelogo, background, title;

Button btnPlay, btnSettings, btnCredits, btnBack, btnPause, btnMainMenu, btnMenu, btnReset;

int level = 1;
int cols = 10;
int rows = 10;
int tileSize = 800 / cols;
int offsetY = 100;

PFont PixelFont;

// | SETS UP TILES/BUTTONS ||

void setup() {
  size(800, 900);

  PixelFont = createFont("PixelFont.ttf", 32);
  textFont(PixelFont);

  buttonSprites = new PImage[8];
  buttonSprites[0] = loadImage("play.png");
  buttonSprites[1] = loadImage("settings.png");
  buttonSprites[2] = loadImage("back.png");
  buttonSprites[3] = loadImage("credits.png");
  buttonSprites[4] = loadImage("none.png");
  buttonSprites[5] = loadImage("none.png");
  buttonSprites[6] = loadImage("none.png");
  buttonSprites[7] = loadImage("none.png");

  // Images for titles/background
  titlesettings = loadImage("titlesettings.png");
  titlecredits = loadImage("titlecredits.png");
  background = loadImage("background.png");
  title = loadImage("test1titleflowers.png");

  tileSprites = new PImage[9];
  tileSprites[0] = loadImage("Bush.png"); // example
  tileSprites[1] = loadImage("Rock.png"); // example
  tileSprites[2] = loadImage("door.png"); // example
  tileSprites[3] = loadImage("doorOpen.png"); // example
  tileSprites[4] = loadImage("fairyringL1.png");
  tileSprites[5] = loadImage("fairyringL2.png");
  tileSprites[6] = loadImage("wall.png");
  tileSprites[7] = loadImage("topWall.png");
  tileSprites[8] = loadImage("bush2.png");


  btnPlay = new Button(200, 350, 400, 150, 400, 421, 0);
  btnSettings = new Button (265, 550, 250, 50, 390, 570, 1);
  btnBack = new Button(300, 785, 200, 75, 400, 820, 2);
  btnCredits = new Button (280, 650, 200, 50, 385, 680, 3);
  btnPause = new Button (10, 10, 80, 80, 50, 50, 4);
  btnMainMenu = new Button (320, 400, 200, 100, 400, 450, 5);
  btnReset = new Button (320, 600, 200, 100, 400, 600, 5);


  tileSize = 800 / cols;
  offsetY = 100;

  loadLevel(level);
}

// | SCREEN MANAGER |

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
  case 'C':
    creditscreen();
    break;
  case 'R':
    pausescreen();
    break;
  }
}

// | PLAYER MOVEMENT |

void keyPressed() {
  if (key == 'w' || key == 'W' || keyCode == UP) player.move(0, -1);
  if (key == 's' || key == 'S' || keyCode == DOWN) player.move(0, 1);
  if (key == 'a' || key == 'A' || keyCode == LEFT) player.move(-1, 0);
  if (key == 'd' || key == 'D' || keyCode == RIGHT) player.move(1, 0);
}

// | DETECTS MOUSE CLICKS |

void mousePressed() {
  switch(screen) {
  case 'M':
    if (btnPlay.clicked()) {
      screen = 'P';
      break;
    } else if (btnSettings.clicked()) {
      screen = 'S';
      break;
    } else if (btnCredits.clicked()) {
      screen = 'C';
      break;
    }
  case 'S':
    if (btnBack.clicked()) {
      screen = 'M';
      break;
    }
  case 'C':
    if (btnBack.clicked()) {
      screen = 'M';
      break;
    }
  case 'P':
    if (btnPause.clicked()) {
      screen = 'R';
      break;
    }
  case 'R':
    if (btnMainMenu.clicked()) { //probably need to add an if statement detecting what level it currently is
      screen = 'M';
      break;
    } else if (btnBack.clicked()) {
      screen = 'P';
      break;
    } else if (btnReset.clicked()) {
      screen = 'P';
      loadLevel(level);
      break;
    }
  }
  println("screen:" + screen);
}

// | SCREENS CODE |

void settingscreen() {
  //The settings screen
  background(#010031);
  image(background, 0, 0);
  fill(#010031);
  btnBack.display();
  btnBack.hover();
  image(titlesettings, 175, 50);
}

void startscreen() {
  //Main menu
  background(#010031);
  image(background, 0, 0);
  image(title, 150, 70);
  fill(#080027);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(70);
  btnPlay.display();
  btnSettings.display();
  btnCredits.display();
  btnSettings.hover();
  btnCredits.hover();
  btnPlay.hover();
}

void creditscreen() {
  //Credits
  background (#010031);
  image(background, 0, 0);
  fill(255);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(70);
  btnBack.display();
  btnBack.hover();
  image(titlecredits, 200, 50);
}

void pausescreen() {
  //pause screen
  background(#010031);
  image(background, 0, 0);
  text("PAUSED", 400, 100);
  btnBack.display();
  btnBack.hover();
  btnMainMenu.display();
  btnMainMenu.hover();
  btnReset.display();
  btnReset.hover();
}

// | DRAW FUNCTION FOR GAME SO IT DOESN't LOAD ON THE MAIN MENU |

void levelDraw() {

  background(#010031);
  grid.displayLayers(0, 1);
  grid.displayDoors();
  grid.displayLayers(2, 2);

  grid.displayButtons();

  grid.updatePushables();
  grid.displayPushables();
  grid.checkButtons();

  player.update();
  player.display();

  grid.displayLayers(3, 4);

  grid.checkDoors(player);

  btnPause.display();
  btnPause.hover();
  
  text("OPEN THE DOOR", 400, 45);
}

// | STORES AND CALLS THE LEVELS UP |

void loadLevel(int lvl) {
  level = lvl;

  grid = new Grid(cols, rows, tileSize, offsetY, tileSprites);

  if (level ==1) {
    setup1();
  } else if (level == 2) {
    setup2();
  } else {
    setupEmptyLevel();
  }

  println("Loaded level" + level);
}

void advanceToNextLevel() {
  loadLevel(level + 1);
}

// | LEVEL CODE |

void setup1() { // each level should have a corresponding setup+levelnumber
  println("screen1");
  grid.setTileSprite(0, 1, 3, 8); // x, y, layer, sprite
  grid.setTileSprite(0, 2, 3, 0);
  grid.setTileSprite(0, 3, 3, 0);
  grid.setTileSprite(0, 4, 3, 0);
  grid.setTileSprite(0, 5, 3, 0);
  grid.setTileSprite(0, 6, 3, 8);
  grid.setTileSprite(0, 7, 3, 7);
  grid.setTileSprite(0, 8, 3, 7);
  grid.setTileSprite(0, 9, 3, 7);
  grid.setTileSprite(1, 7, 3, 6);
  grid.setTileSprite(2, 7, 3, 6);
  grid.setTileSprite(1, 9, 3, 6);
  grid.setTileSprite(2, 9, 3, 6);
  grid.setTileSprite(3, 2, 3, 0);
  grid.setTileSprite(4, 2, 3, 8);
  grid.setTileSprite(5, 2, 3, 6);
  grid.setTileSprite(6, 2, 3, 6);
  grid.setTileSprite(6, 3, 3, 0);
  grid.setTileSprite(6, 4, 3, 8);
  grid.setTileSprite(6, 5, 3, 0);
  grid.setTileSprite(6, 6, 3, 8);
  grid.setTileSprite(3, 3, 3, 0);
  grid.setTileSprite(3, 4, 3, 0);
  grid.setTileSprite(3, 5, 3, 0);
  grid.setTileSprite(9, 1, 3, 0);
  grid.setTileSprite(9, 2, 3, 0);
  grid.setTileSprite(9, 3, 3, 0);
  grid.setTileSprite(9, 4, 3, 8);
  grid.setTileSprite(9, 5, 3, 8);
  grid.setTileSprite(9, 6, 3, 0);
  grid.setTileSprite(9, 7, 3, 0);
  grid.setTileSprite(9, 8, 3, 0);
  grid.setTileSprite(9, 9, 3, 8);
  grid.setTileSprite(8, 5, 3, 0);
  grid.setTileSprite(7, 9, 3, 0);
  grid.setTileSprite(8, 9, 3, 0);
  grid.setTileSprite(2, 3, 3, 0);
  grid.setTileSprite(5, 3, 3, 5);
  grid.setTileSprite(0, 0, 3, 6);
  grid.setTileSprite(1, 0, 3, 6);
  grid.setTileSprite(9, 0, 3, 6);
  grid.setTileSprite(8, 0, 3, 6);
  grid.setTileSprite(3, 7, 3, 8);
  
  grid.setSolid(0, 1, true); // x, y, solid
  grid.setSolid(0, 2, true);
  grid.setSolid(0, 3, true);
  grid.setSolid(0, 4, true);
  grid.setSolid(0, 5, true);
  grid.setSolid(0, 6, true);
  grid.setSolid(0, 7, true);
  grid.setSolid(0, 8, true);
  grid.setSolid(0, 9, true);
  grid.setSolid(1, 7, true);
  grid.setSolid(2, 7, true);
  grid.setSolid(1, 8, true);
  grid.setSolid(1, 9, true);
  grid.setSolid(2, 9, true);
  grid.setSolid(3, 2, true);
  grid.setSolid(4, 2, true);
  grid.setSolid(5, 2, true);
  grid.setSolid(6, 2, true);
  grid.setSolid(6, 3, true);
  grid.setSolid(6, 4, true);
  grid.setSolid(6, 5, true);
  grid.setSolid(6, 6, true);
  grid.setSolid(3, 3, true);
  grid.setSolid(3, 4, true);
  grid.setSolid(3, 5, true);
  grid.setSolid(9, 1, true);
  grid.setSolid(9, 2, true);
  grid.setSolid(9, 3, true);
  grid.setSolid(9, 4, true);
  grid.setSolid(9, 5, true);
  grid.setSolid(9, 6, true);
  grid.setSolid(9, 7, true);
  grid.setSolid(9, 8, true);
  grid.setSolid(9, 9, true);
  grid.setSolid(8, 5, true);
  grid.setSolid(8, 9, true);
  grid.setSolid(7, 9, true);
  grid.setSolid(2, 3, true);
  

  grid.addPushableTile(6, 1, 2, 1);
  grid.addDoor(1, 8, 2);
  //ADDING BUTTONS: (x, y (button location), PImage #,
  // x, y (tile targeted), PImage for targeted sprite, solid true or false)
  // total of 6 ints and 1 boolean
  grid.addButton(5, 3, 4, 1, 8, 3, 3, false, 1);
  

  player = new Player(grid, 4, 0);
}

void setup2() {
  
  grid.setTileSprite(0, 0, 1, 3);
  grid.setTileSprite(0, 1, 3, 0);
  grid.setTileSprite(1, 1, 3, 0);
  grid.setTileSprite(2, 1, 3, 0);
  grid.setTileSprite(3, 1, 3, 8);
  grid.setTileSprite(3, 2, 3, 0);
  grid.setTileSprite(3, 3, 3, 0);
  grid.setTileSprite(3, 4, 3, 8);
  grid.setTileSprite(2, 4, 3, 0);
  grid.setTileSprite(1, 4, 3, 0);
  grid.setTileSprite(9, 3, 3, 6);
  grid.setTileSprite(8, 3, 3, 6);
  grid.setTileSprite(7, 3, 3, 6);
  grid.setTileSprite(6, 3, 3, 8);
  grid.setTileSprite(6, 4, 3, 0);
  grid.setTileSprite(6, 5, 3, 8);
  grid.setTileSprite(6, 6, 3, 0);
  grid.setTileSprite(7, 6, 3, 0);
  grid.setTileSprite(5, 7, 3, 6);
  grid.setTileSprite(4, 7, 3, 6);
  grid.setTileSprite(3, 7, 3, 6);
  grid.setTileSprite(9, 8, 3, 0);
  grid.setTileSprite(9, 9, 3, 8);
  grid.setTileSprite(0, 7, 3, 7);
  grid.setTileSprite(0, 8, 3, 7);
  grid.setTileSprite(0, 9, 3, 8);
  grid.setTileSprite(1, 9, 3, 0);
  grid.setTileSprite(2, 9, 3, 0);
  grid.setTileSprite(5, 1, 3, 0);
  grid.setTileSprite(8, 9, 3, 0);
  grid.setTileSprite(6, 1, 3, 6);
  grid.setTileSprite(7, 4, 3, 5);
    
  grid.setSolid(0, 0, true);
  grid.setSolid(0, 1, true);
  grid.setSolid(1, 1, true);
  grid.setSolid(2, 1, true);
  grid.setSolid(3, 1, true);
  grid.setSolid(3, 2, true);
  grid.setSolid(3, 3, true);
  grid.setSolid(3, 4, true);
  grid.setSolid(2, 3, true);
  grid.setSolid(9, 3, true);
  grid.setSolid(8, 3, true);
  grid.setSolid(7, 3, true);
  grid.setSolid(6, 3, true);
  grid.setSolid(6, 4, true);
  grid.setSolid(6, 5, true);
  grid.setSolid(6, 6, true);
  grid.setSolid(7, 6, true);
  grid.setSolid(5, 7, true);
  grid.setSolid(4, 7, true);
  grid.setSolid(3, 7, true);
  grid.setSolid(9, 8, true);
  grid.setSolid(9, 9, true);
  grid.setSolid(0, 7, true);
  grid.setSolid(0, 8, true);
  grid.setSolid(0, 9, true);
  grid.setSolid(1, 9, true);
  grid.setSolid(2, 4, true);
  grid.setSolid(1, 4, true);
  grid.setSolid(5, 1, true);
  grid.setSolid(8, 9, true);
  grid.setSolid(6, 1, true);
  
  grid.addPushableTile(8, 1, 2, 1);
  grid.addDoor(2, 3, 2);
  
  grid.addButton(7, 4, 4, 2, 3, 3, 3, false, 1);

  player = new Player(grid,0,0);
}

void setup3() {
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

  player = new Player(grid,1,2);
}

void setup4() {
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

  player = new Player(grid,1,2);
}

void setupEmptyLevel() { // just in case there is no next level so the game doesnt crash

  player = new Player(grid,1,2);
}
