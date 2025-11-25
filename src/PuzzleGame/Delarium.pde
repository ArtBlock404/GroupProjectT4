
// TABLE OF CONTENTS
// 21 - 40: setup
// 44 - 56: draw
// 107 - 127: draw - one
// 59 - 77: keypressed & mousepressed
// 81 - 104: settings screen & start screen
// 130 - 148: load & advance level
// 149 - 200+: setup# levels


import java.util.ArrayList;

//Animation animation1;

float xpos;
float ypos;
float drag = 30.0;

Grid grid;
PImage[] tileSprites;
Player player;
Button[] buttons = new Button[4];
char screen = 'M'; // M = main menu, S = settings, C = credits, P = play
PImage[] buttonSprites;
PImage titlesettings, titlecredits, titlelogo, background;

Button btnPlay, btnSettings, btnCredits, btnBack;

int level = 1;
int cols = 10;
int rows = 10;
int tileSize = 800 / cols;
int offsetY = 100;

PFont PixelFont;

void setup() {
  size(800, 900);
  //animation1 = new Animation("PT_Shifty_", 38);
  
  //ypos = height * 0.25;

  PixelFont = createFont("PixelFont.ttf", 32);
  textFont(PixelFont);

  buttonSprites = new PImage[5];
  buttonSprites[0] = loadImage("play.png");
  buttonSprites[1] = loadImage("settings.png");
  buttonSprites[2] = loadImage("back.png");
  buttonSprites[3] = loadImage("credits.png");
  buttonSprites[4] = loadImage("none.png");
  
  // Images for titles/background
  titlesettings = loadImage("titlesettings.png");
  titlecredits = loadImage("titlecredits.png");
  background = loadImage("background.png");

  tileSprites = new PImage[2];
  tileSprites[0] = loadImage("Bush.png"); // example
  tileSprites[1] = loadImage("Rock.png"); // example

  btnPlay = new Button(200, 350, 400, 150, 400, 421, "Play", 150, 0);
  btnSettings = new Button (265, 550, 250, 50, 390, 570, "Settings", 50, 1);
  btnBack = new Button(300, 785, 200, 75, 400, 820, "Back", 50, 2);
  btnCredits = new Button (280, 650, 200, 50, 385, 680, "Credits", 50, 3);


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
  case 'C':
    creditscreen();
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
    } else if (btnCredits.clicked()) {
      screen = 'C';
      break;
    }
   case 'S':
     if(btnBack.clicked()) {
       screen = 'M';
       break;
     }
   case 'C':
     if (btnBack.clicked()) {
       screen = 'M';
       break;
     }
  }
  println("screen:" + screen);
}


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
  //float dx = mouseX - xpos;
  //animation1.display(xpos-animation1.getWidth()/2, ypos);
  //xpos = xpos + dx/drag;
  fill(#080027);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(70);
  text("DELARIUM", 400, 100);
  rect(150,50,500,185);
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
  textAlign(CENTER,CENTER);
  textMode(CENTER);
  textSize(70);
  btnBack.display();
  btnBack.hover();
  image(titlecredits, 200, 50);
}

void levelDraw() {
  background(#010031);
  grid.displayLayers(0, 2);

  grid.displayButtons();
  grid.displayDoors();

  grid.updatePushables();
  grid.displayPushables();
  grid.checkButtons();

  player.update();
  player.display();
  
  grid.displayLayers(3, 4);

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

  grid.setTileSprite(0, 1, 3, 0); // x, y, layer, sprite
  grid.setTileSprite(0, 2, 3, 0);
  grid.setSolid(0, 1, true); // x, y, solid
  grid.setSolid(0, 2, true);
  grid.setSolid(2, 2, true);

  grid.addPushableTile(4, 4, 2, 1);
  grid.addDoor(2, 2, 3);
  //ADDING BUTTONS: (x, y (button location), PImage #,
  // x, y (tile targeted), PImage for targeted sprite, solid true or false)
  // total of 6 ints and 1 boolean
  grid.addButton(7, 4, 2, 2, 2, 1, false);

  player = new Player(grid, 0, 0, color(255, 200, 0));
}

void setupTwo() {

  grid.setTileSprite(1, 1, 3, 0);
  grid.setSolid(1, 1, true);
  grid.setTileSprite(2, 1, 3, 0);
  grid.setSolid(2, 1, true);
  grid.setTileSprite(3, 1, 3, 0);
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
