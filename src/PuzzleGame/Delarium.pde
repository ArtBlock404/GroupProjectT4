

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
char screen = 'M'; // M = main menu, S = settings, C = credits, P = play, R = pause
PImage[] buttonSprites;
PImage titlesettings, titlecredits, titlelogo, background;

Button btnPlay, btnSettings, btnCredits, btnBack, btnPause, btnMainMenu, btnMenu;

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

  buttonSprites = new PImage[7];
  buttonSprites[0] = loadImage("play.png");
  buttonSprites[1] = loadImage("settings.png");
  buttonSprites[2] = loadImage("back.png");
  buttonSprites[3] = loadImage("credits.png");
  buttonSprites[4] = loadImage("none.png");
  buttonSprites[5] = loadImage("none.png");
  buttonSprites[6] = loadImage("none.png");
  
  // Images for titles/background
  titlesettings = loadImage("titlesettings.png");
  titlecredits = loadImage("titlecredits.png");
  background = loadImage("background.png");

  tileSprites = new PImage[2];
  tileSprites[0] = loadImage("Bush.png"); // example
  tileSprites[1] = loadImage("Rock.png"); // example

  btnPlay = new Button(200, 350, 400, 150, 400, 421, 0);
  btnSettings = new Button (265, 550, 250, 50, 390, 570, 1);
  btnBack = new Button(300, 785, 200, 75, 400, 820, 2);
  btnCredits = new Button (280, 650, 200, 50, 385, 680, 3);
  btnPause = new Button (10,10,80,80,50,50, 4);
  btnMainMenu = new Button (320,400,200,100,400,450, 5);


  tileSize = 800 / cols;
  offsetY = 100;

//Calling level drawer, we need to move this somewhere else
// no, this is the correct placement
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
   case 'R':
     pausescreen();
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
   case 'P':
     if(btnPause.clicked()) {
       screen = 'R';
       break;
     }
   case 'R':
     if(btnMainMenu.clicked()) { //probably need to add an if statement detecting what level it currently is
       screen = 'M';
       break;
     } else if (btnBack.clicked()) {
       screen = 'P';
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

void pausescreen() {
  background(#010031);
  image(background, 0, 0);
  text("PAUSED", 400, 100);
  btnBack.display();
  btnBack.hover();
  btnMainMenu.display();
  btnMainMenu.hover();
}

void levelDraw() {

//Put this into the level methods, doesn't make sense why we do this seperately if we can load it together with the levels
//Seems like this is just calling up all the methods to make the game work
// this is the draw function for the actual game, this is  so the game doesnt run on the main menu
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
  
  btnPause.display();
  btnPause.hover();
  
 
}

//How we're setting the level??? Where in the code are we actually setting the levels? We need to find a way to call up the levels using switch statements probably
// its "void advsnceToNextLevel" that changes the level by 1, you can maualy change the level int to select a level
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

// v LEVEL CODE v

void setup1() { // each level should have a corresponding setup+levelnumber
  println("screen1");
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

void setup2() {

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

  player = new Player(grid, 5, 5, color(255, 200, 0));
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

  player = new Player(grid, 5, 5, color(255, 200, 0));
}

void setupEmptyLevel() { // just in case there is no next level so the game doesnt crash

  player = new Player(grid, 0, 0, color(255, 200, 0));
}
