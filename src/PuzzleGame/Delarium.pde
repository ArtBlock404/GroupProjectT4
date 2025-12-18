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
PImage titlesettings, titlecredits, titlelogo, background, title, titlepaused, titledied;

Button btnPlay, btnSettings, btnCredits, btnBack, btnPause, btnMainMenu, btnRestart, btnResume;

int level = 1;
int cols = 10;
int rows = 10;
int tileSize = 800 / cols;
int offsetY = 100;
String levelText = "";

PFont PixelFont;

// | SETS UP TILES/BUTTONS ||

void setup() {
  size(800, 900);

  PixelFont = createFont("PixelFont.ttf", 32);
  textFont(PixelFont);

  buttonSprites = new PImage[9];
  buttonSprites[0] = loadImage("play.png");
  buttonSprites[1] = loadImage("settings.png");
  buttonSprites[2] = loadImage("back.png");
  buttonSprites[3] = loadImage("credits.png");
  buttonSprites[4] = loadImage("cog.png");
  buttonSprites[5] = loadImage("mainmenu.png");
  buttonSprites[6] = loadImage("restart.png");
  buttonSprites[7] = loadImage("none.png");
  buttonSprites[8] = loadImage("resume.png");

  // Images for titles/background
  titlesettings = loadImage("titlesettings.png");
  titlecredits = loadImage("titlecredits.png");
  background = loadImage("background.png");
  title = loadImage("gametitle.png");
  titlepaused = loadImage("titlepaused.png");
  titledied = loadImage("titledied.png");

  tileSprites = new PImage[15];
  tileSprites[0] = loadImage("Bush.png"); // example
  tileSprites[1] = loadImage("Rock.png"); // example
  tileSprites[2] = loadImage("door.png"); // example
  tileSprites[3] = loadImage("doorOpen.png"); // example
  tileSprites[4] = loadImage("fairyringL1.png");
  tileSprites[5] = loadImage("fairyringL2.png");
  tileSprites[6] = loadImage("flower.png");
  tileSprites[7] = loadImage("wall.png");
  tileSprites[8] = loadImage("topWall.png");
  tileSprites[9] = loadImage("grass.png");
  tileSprites[10] = loadImage("Bush.png");
  tileSprites[11] = loadImage("hazard.png");
  tileSprites[12] = loadImage("gate.png");
  tileSprites[13] = loadImage("gateopen.png");
  tileSprites[14] = loadImage("passage.png");



  btnPlay = new Button(200, 350, 400, 150, 400, 421, 0);
  btnSettings = new Button (265, 550, 250, 50, 390, 570, 1);
  btnBack = new Button(300, 785, 200, 75, 400, 820, 2);
  btnCredits = new Button (280, 650, 200, 50, 385, 680, 3);
  btnPause = new Button (10, 10, 80, 80, 50, 50, 4);
  btnMainMenu = new Button (245, 525, 300, 60, 395, 555, 5);
  btnRestart = new Button (280, 625, 230, 60, 395, 655, 6);
  btnResume = new Button (235, 340, 330, 90, 400, 385, 8);


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
  case 'D':
    deathscreen();
  }
}

// | PLAYER MOVEMENT |

void keyPressed() {
  if (key == 'w' || key == 'W' || keyCode == UP) player.move(0, -1);
  if (key == 's' || key == 'S' || keyCode == DOWN) player.move(0, 1);
  if (key == 'a' || key == 'A' || keyCode == LEFT) player.move(-1, 0);
  if (key == 'd' || key == 'D' || keyCode == RIGHT) player.move(1, 0);

  switch(screen) {
      case 'P':
        if (keyCode == 9) {
          screen = 'R';
          break;
        }
    }
}

// | DETECTS MOUSE CLICKS |

void mousePressed() {
  switch(screen) {
  case 'M':
    if (btnPlay.clicked()) {
      screen = 'P';
      loadLevel(8); // change this to load a specific level
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
    if (btnMainMenu.clicked()) {
      screen = 'M';
      break;
    } else if (btnResume.clicked()) {
      screen = 'P';
      break;
    } else if (btnRestart.clicked()) {
      screen = 'P';
      loadLevel(level);
      break;
    }
  case 'D':
    if (btnMainMenu.clicked()) {
      screen = 'M';
      break;
    } else if (btnRestart.clicked()) {
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

void deathscreen() {
  background(#010031);
  image(background, 0, 0);
  fill(#010031);
  btnMainMenu.display();
  btnMainMenu.hover();
  btnRestart.display();
  btnRestart.hover();
  fill(250);
  textSize(100);
  image(titledied, 175, 250);
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
  // Jonah: Lead Programmer, Lead Artist, Debugging/Testing
  // Angie: UI/UX Design, Level Design, Assistant Programmer, Graphics
  // Maizie: Assistant Artist, Storyboard, Game Design
  background (#010031);
  image(background, 0, 0);
  fill(255);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(70);
  btnBack.display();
  btnBack.hover();
  image(titlecredits, 200, 50);
  textSize(60);
  text("Jonah White", 400, 250);
  text("Angie Liu", 400, 425);
  text("Maizie Robson", 400, 600);
  textSize(35);
  text("Lead Programmer,\n Lead Artist, Debugging/Testing", 400, 325);
  text("UI/UX Design,\n Level Design, Assistant Programmer, Graphics", 400, 500);
  text("Assistant Artist,\n Storyboard, Game Design", 400, 675);
}

void pausescreen() {
  //pause screen
  background(#010031);
  image(background, 0, 0);
  image(titlepaused, 200, 50);
  btnResume.display();
  btnResume.hover();
  btnMainMenu.display();
  btnMainMenu.hover();
  btnRestart.display();
  btnRestart.hover();
}

// | DRAW FUNCTION FOR GAME SO IT DOESN't LOAD ON THE MAIN MENU |

void levelDraw() {

  background(#010031);
  grid.displayLayers(0, 1);
  grid.displayHazards();
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
  grid.checkHazards(player);

  btnPause.display();
  btnPause.hover();


  fill(250);
  textSize(50);
  text(levelText, 400, 45);
}

// | STORES AND CALLS THE LEVELS UP |

void loadLevel(int lvl) {
  level = lvl;
  grid = new Grid(cols, rows, tileSize, offsetY, tileSprites);

  if (level ==1) {
    setup1();
  } else if (level == 2) {
    setup2();
  } else if (level == 3) {
    setup3();
  } else if (level == 4) {
    setup4();
  } else if (level == 5) {
    setup5();
  } else if (level == 6) {
    setup6();
  } else if (level == 7) {
    setup7();
  } else if (level == 8) {
    setup8();
  } else if (level == 9) {
    setup9();
  } else if (level == 10) {
    setup10();
  } 

  println("Loaded level" + level);
}

void advanceToNextLevel() {
  loadLevel(level + 1);
}

// | LEVEL CODE |

void setup1() { // each level should have a corresponding setup+levelnumber
  println("screen1");

  grid.setTileSprite(0, 1, 2, 8); // x, y, layer, sprite
  grid.setTileSprite(0, 2, 2, 7);
  grid.setTileSprite(0, 3, 2, 0);
  grid.setTileSprite(0, 4, 2, 10);
  grid.setTileSprite(0, 5, 2, 0);
  grid.setTileSprite(0, 6, 2, 8);
  grid.setTileSprite(0, 7, 2, 8);
  grid.setTileSprite(0, 8, 2, 8);
  grid.setTileSprite(0, 9, 2, 7);
  grid.setTileSprite(1, 7, 2, 7);
  grid.setTileSprite(2, 7, 2, 7);
  grid.setTileSprite(1, 9, 2, 10);
  grid.setTileSprite(2, 9, 2, 0);
  grid.setTileSprite(2, 2, 2, 6);
  grid.setTileSprite(4, 2, 2, 7);
  grid.setTileSprite(5, 2, 2, 7);
  grid.setTileSprite(6, 2, 2, 8);
  grid.setTileSprite(6, 3, 2, 7);
  grid.setTileSprite(6, 2, 2, 8);
  grid.setTileSprite(6, 4, 2, 0);
  grid.setTileSprite(6, 5, 2, 10);
  grid.setTileSprite(6, 6, 2, 0);
  grid.setTileSprite(3, 3, 2, 7);
  grid.setTileSprite(3, 2, 2, 8);
  grid.setTileSprite(3, 4, 2, 0);
  grid.setTileSprite(3, 5, 2, 0);
  grid.setTileSprite(9, 1, 2, 7);
  grid.setTileSprite(9, 2, 2, 10);
  grid.setTileSprite(9, 3, 2, 0);
  grid.setTileSprite(9, 4, 2, 8);
  grid.setTileSprite(9, 5, 2, 8);
  grid.setTileSprite(9, 6, 2, 7);
  grid.setTileSprite(9, 7, 2, 0);
  grid.setTileSprite(9, 8, 2, 0);
  grid.setTileSprite(9, 9, 2, 8);
  grid.setTileSprite(8, 5, 2, 0);
  grid.setTileSprite(7, 9, 2, 8);
  grid.setTileSprite(8, 9, 2, 8);
  grid.setTileSprite(2, 3, 2, 0);
  grid.setTileSprite(5, 3, 3, 5);
  grid.setTileSprite(0, 0, 2, 8);
  grid.setTileSprite(1, 0, 2, 7);
  grid.setTileSprite(9, 0, 2, 8);
  grid.setTileSprite(8, 0, 2, 7);
  grid.setTileSprite(3, 7, 2, 7);
  grid.setTileSprite(3, 8, 2, 6);
  grid.setTileSprite(2, 8, 2, 6);
  grid.setTileSprite(4, 8, 2, 6);
  grid.setTileSprite(4, 3, 2, 6);
  grid.setTileSprite(5, 4, 2, 6);
  grid.setTileSprite(2, 0, 2, 9);
  grid.setTileSprite(7, 0, 2, 9);
  grid.setTileSprite(9, 8, 2, 9);
  grid.setTileSprite(6, 9, 2, 9);
  grid.setTileSprite(1, 6, 2, 9);


  grid.setSolid(0, 1, true); // x, y, solid
  grid.setSolid(1, 0, true);
  grid.setSolid(0, 0, true);
  grid.setSolid(8, 0, true);
  grid.setSolid(9, 0, true);
  grid.setSolid(3, 7, true);

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
  grid.addButton(5, 3, 4, 1, 8, 3, 2, false, 1);

  player = new Player(grid, 4, 0);

  levelText = "Open the Door."; // Add this at the end of each level to add text
}

void setup2() {


  grid.setTileSprite(0, 1, 1, 0);
  grid.setTileSprite(1, 1, 1, 0);
  grid.setTileSprite(2, 1, 1, 0);
  grid.setTileSprite(3, 1, 1, 8);
  grid.setTileSprite(3, 2, 1, 10);
  grid.setTileSprite(3, 3, 1, 0);
  grid.setTileSprite(3, 4, 1, 8);
  grid.setTileSprite(2, 4, 1, 0);
  grid.setTileSprite(1, 4, 1, 0);
  grid.setTileSprite(9, 3, 1, 10);
  grid.setTileSprite(8, 3, 1, 0);
  grid.setTileSprite(7, 3, 1, 0);
  grid.setTileSprite(6, 3, 1, 8);
  grid.setTileSprite(6, 4, 1, 0);
  grid.setTileSprite(6, 5, 1, 8);
  grid.setTileSprite(6, 6, 1, 0);
  grid.setTileSprite(7, 6, 1, 0);
  grid.setTileSprite(5, 7, 1, 0);
  grid.setTileSprite(4, 7, 1, 10);
  grid.setTileSprite(3, 7, 1, 0);
  grid.setTileSprite(9, 8, 1, 0);
  grid.setTileSprite(9, 9, 1, 8);
  grid.setTileSprite(0, 7, 1, 7);
  grid.setTileSprite(0, 8, 1, 7);
  grid.setTileSprite(0, 9, 1, 8);
  grid.setTileSprite(1, 9, 1, 0);
  grid.setTileSprite(2, 9, 1, 10);
  grid.setTileSprite(5, 1, 1, 0);
  grid.setTileSprite(8, 9, 1, 10);
  grid.setTileSprite(6, 1, 1, 0);
  grid.setTileSprite(7, 4, 3, 5);
  grid.setTileSprite(1, 3, 1, 9);
  grid.setTileSprite(0, 9, 1, 8);
  grid.setTileSprite(1, 8, 1, 9);
  grid.setTileSprite(9, 7, 1, 9);
  grid.setTileSprite(9, 6, 1, 9);
  grid.setTileSprite(7, 5, 1, 9);
  grid.setTileSprite(1, 6, 1, 9);
  grid.setTileSprite(9, 0, 1, 6);
  grid.setTileSprite(5, 4, 1, 6);
  grid.setTileSprite(3, 9, 1, 6);
  grid.setTileSprite(4, 9, 1, 6);
  grid.setTileSprite(1, 0, 1, 6);

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

  grid.addButton(7, 4, 4, 2, 3, 3, 2, false, 1);

  player = new Player(grid, 0, 0);
  
  levelText = "Distance.";
}

void setup3() {
  grid.setTileSprite(0, 1, 1, 0);
  grid.setTileSprite(1, 1, 1, 10);
  grid.setTileSprite(2, 1, 1, 10);
  grid.setTileSprite(2, 2, 1, 8);
  grid.setTileSprite(2, 3, 1, 10);
  grid.setTileSprite(6, 2, 1, 7);
  grid.setTileSprite(7, 2, 1, 7);
  grid.setTileSprite(7, 3, 1, 10);
  grid.setTileSprite(7, 4, 1, 0);
  grid.setTileSprite(9, 1, 1, 0);
  grid.setTileSprite(9, 2, 1, 0);
  grid.setTileSprite(2, 5, 1, 0);
  grid.setTileSprite(3, 5, 1, 10);
  grid.setTileSprite(4, 6, 1, 0);
  grid.setTileSprite(5, 6, 1, 0);
  grid.setTileSprite(6, 6, 1, 10);
  grid.setTileSprite(7, 6, 1, 0);
  grid.setTileSprite(7, 7, 1, 0);
  grid.setTileSprite(0, 8, 1, 7);
  grid.setTileSprite(0, 9, 1, 10);
  grid.setTileSprite(2, 8, 1, 7);
  grid.setTileSprite(8, 9, 1, 10);
  grid.setTileSprite(9, 9, 1, 0);
  grid.setTileSprite(1, 9, 3, 5);

  grid.setTileSprite(0, 0, 1, 6);
  grid.setTileSprite(3, 3, 1, 9);
  grid.setTileSprite(6, 3, 1, 6);
  grid.setTileSprite(9, 3, 1, 9);
  grid.setTileSprite(6, 7, 1, 6);
  grid.setTileSprite(0, 7, 1, 9);
  grid.setTileSprite(1, 2, 1, 6);
  grid.setTileSprite(4, 9, 1, 9);
  grid.setTileSprite(7, 9, 1, 6);
  grid.setTileSprite(3, 6, 1, 9);
  grid.setTileSprite(4, 5, 1, 6);

  grid.addHazard(3, 1, 11);
  grid.addHazard(7, 5, 11);
  grid.addHazard(9, 6, 11);
  grid.addHazard(1, 5, 11);
  grid.addHazard(2, 9, 11);
  grid.addHazard(4, 8, 11);
  grid.addHazard(4, 9, 11);
  grid.addHazard(5, 0, 11);
  grid.addHazard(6, 0, 11);

  grid.setSolid(0, 1, true);
  grid.setSolid(1, 1, true);
  grid.setSolid(2, 1, true);
  grid.setSolid(2, 2, true);
  grid.setSolid(2, 3, true);
  grid.setSolid(6, 2, true);
  grid.setSolid(7, 2, true);
  grid.setSolid(7, 3, true);
  grid.setSolid(7, 4, true);
  grid.setSolid(9, 1, true);
  grid.setSolid(9, 2, true);
  grid.setSolid(2, 5, true);
  grid.setSolid(3, 5, true);
  grid.setSolid(4, 6, true);
  grid.setSolid(5, 6, true);
  grid.setSolid(6, 6, true);
  grid.setSolid(7, 6, true);
  grid.setSolid(7, 7, true);
  grid.setSolid(0, 8, true);
  grid.setSolid(0, 9, true);
  grid.setSolid(2, 8, true);
  grid.setSolid(8, 9, true);
  grid.setSolid(9, 9, true);

  grid.addPushableTile(5, 4, 2, 1);
  grid.addDoor(3, 2, 2);

  grid.addButton(1, 9, 4, 3, 2, 3, 2, false, 1);

  player = new Player(grid, 9, 0);

  levelText = "Be Careful Where You Step.";
}

void setup4() {
  grid.setTileSprite(0, 0, 1, 10);
  grid.setTileSprite(1, 0, 1, 0);
  grid.setTileSprite(2, 0, 1, 10);
  grid.setTileSprite(0, 3, 1, 0);
  grid.setTileSprite(1, 3, 1, 0);
  grid.setTileSprite(2, 3, 1, 0);
  grid.setTileSprite(5, 0, 1, 8);
  grid.setTileSprite(5, 2, 1, 0);
  grid.setTileSprite(5, 3, 1, 0);
  grid.setTileSprite(5, 4, 1, 0);
  grid.setTileSprite(6, 6, 1, 10);
  grid.setTileSprite(5, 6, 1, 7);
  grid.setTileSprite(4, 6, 1, 7);
  grid.setTileSprite(4, 7, 1, 10);
  grid.setTileSprite(0, 9, 1, 7);
  grid.setTileSprite(1, 9, 1, 7);
  grid.setTileSprite(9, 6, 1, 10);
  grid.setTileSprite(9, 7, 1, 0);
  grid.setTileSprite(9, 8, 1, 0);
  grid.setTileSprite(9, 9, 1, 10);
  grid.setTileSprite(8, 9, 1, 0);
  grid.setTileSprite(9, 0, 1, 0);
  grid.setTileSprite(9, 1, 1, 10);
  grid.setTileSprite(9, 2, 1, 0);


  grid.setTileSprite(8, 8, 3, 5);
  grid.setTileSprite(4, 0, 1, 9);
  grid.setTileSprite(9, 5, 1, 6);
  grid.setTileSprite(9, 4, 1, 9);
  grid.setTileSprite(6, 3, 1, 6);
  grid.setTileSprite(1, 4, 1, 9);
  grid.setTileSprite(3, 7, 1, 6);
  grid.setTileSprite(6, 9, 1, 9);
  grid.setTileSprite(0, 1, 1, 6);
  grid.setTileSprite(0, 8, 1, 9);


  grid.addHazard(3, 3, 11);
  grid.addHazard(7, 0, 11);
  grid.addHazard(8, 0, 11);
  grid.addHazard(6, 2, 11);
  grid.addHazard(7, 2, 11);
  grid.addHazard(7, 5, 11);
  grid.addHazard(3, 6, 11);
  grid.addHazard(2, 6, 11);
  grid.addHazard(7, 9, 11);
  grid.addHazard(7, 8, 11);


  grid.setSolid(0, 0, true);
  grid.setSolid(1, 0, true);
  grid.setSolid(2, 0, true);
  grid.setSolid(0, 3, true);
  grid.setSolid(1, 3, true);
  grid.setSolid(2, 3, true);
  grid.setSolid(5, 0, true);
  grid.setSolid(5, 2, true);
  grid.setSolid(5, 3, true);
  grid.setSolid(5, 4, true);
  grid.setSolid(6, 6, true);
  grid.setSolid(5, 6, true);
  grid.setSolid(4, 6, true);
  grid.setSolid(4, 7, true);
  grid.setSolid(0, 9, true);
  grid.setSolid(1, 9, true);
  grid.setSolid(9, 6, true);
  grid.setSolid(9, 7, true);
  grid.setSolid(9, 8, true);
  grid.setSolid(9, 9, true);
  grid.setSolid(8, 9, true);
  grid.setSolid(9, 0, true);
  grid.setSolid(9, 1, true);
  grid.setSolid(9, 2, true);
  grid.setSolid(2, 2, true);


  grid.addPushableTile(7, 1, 2, 1);
  grid.addDoor(2, 2, 2);

  grid.addButton(8, 8, 4, 2, 2, 3, 2, false, 1);

  player = new Player(grid, 0, 2);
  
  levelText = "Ferris Wheel.";
}

void setup5() {

  grid.setTileSprite(0, 0, 1, 10);
  grid.setTileSprite(1, 0, 1, 10);
  grid.setTileSprite(2, 0, 1, 10);
  grid.setTileSprite(3, 0, 1, 10);
  grid.setTileSprite(4, 0, 1, 10);
  grid.setTileSprite(5, 0, 1, 10);
  grid.setTileSprite(6, 0, 1, 10);
  grid.setTileSprite(7, 0, 1, 10);
  grid.setTileSprite(8, 0, 1, 10);
  grid.setTileSprite(9, 0, 1, 10);
  grid.setTileSprite(0, 1, 1, 10);
  grid.setTileSprite(0, 2, 1, 10);
  grid.setTileSprite(9, 1, 1, 10);
  grid.setTileSprite(9, 2, 1, 10);
  grid.setTileSprite(2, 4, 1, 10);
  grid.setTileSprite(7, 4, 1, 10);
  grid.setTileSprite(2, 6, 1, 8);
  grid.setTileSprite(2, 7, 1, 8);
  grid.setTileSprite(2, 8, 1, 7);
  grid.setTileSprite(3, 6, 1, 8);
  grid.setTileSprite(4, 6, 1, 8);
  grid.setTileSprite(5, 6, 1, 8);
  grid.setTileSprite(6, 6, 1, 8);
  grid.setTileSprite(7, 6, 1, 8);
  grid.setTileSprite(7, 7, 1, 8);
  grid.setTileSprite(6, 7, 1, 7);
  grid.setTileSprite(7, 8, 1, 7);
  grid.setTileSprite(5, 7, 1, 7);
  grid.setTileSprite(4, 7, 1, 7);
  grid.setTileSprite(3, 7, 1, 7);
  grid.setTileSprite(5, 1, 3, 5);


  grid.setSolid(0, 0, true);
  grid.setSolid(0, 1, true);
  grid.setSolid(0, 2, true);
  grid.setSolid(0, 3, true);
  grid.setSolid(0, 4, true);
  grid.setSolid(0, 5, true);
  grid.setSolid(0, 6, true);
  grid.setSolid(0, 7, true);
  grid.setSolid(0, 8, true);
  grid.setSolid(0, 9, true);
  grid.setSolid(1, 0, true);
  grid.setSolid(2, 0, true);
  grid.setSolid(1, 9, true);
  grid.setSolid(2, 9, true);
  grid.setSolid(2, 4, true);
  grid.setSolid(7, 4, true);
  grid.setSolid(2, 6, true);
  grid.setSolid(3, 6, true);
  grid.setSolid(4, 6, true);
  grid.setSolid(5, 6, true);
  grid.setSolid(6, 6, true);
  grid.setSolid(7, 6, true);
  grid.setSolid(2, 7, true);
  grid.setSolid(3, 7, true);
  grid.setSolid(4, 7, true);
  grid.setSolid(5, 7, true);
  grid.setSolid(6, 7, true);
  grid.setSolid(7, 7, true);
  grid.setSolid(2, 8, true);
  grid.setSolid(7, 7, true);
  grid.setSolid(3, 8, true);

  grid.addHazard(1, 2, 11);
  grid.addHazard(2, 2, 11);
  grid.addHazard(3, 2, 11);
  grid.addHazard(4, 2, 11);
  grid.addHazard(5, 2, 11);
  grid.addHazard(6, 2, 11);
  grid.addHazard(7, 2, 11);
  grid.addHazard(8, 2, 11);



  grid.addPushableTile(8, 7, 2, 1);
  grid.addPushableTile(5, 4, 2, 1);

  grid.addDoor(3, 8, 2);

  grid.addButton(5, 1, 4, 3, 8, 3, 2, false, 1);

  player = new Player(grid, 9, 4);


  levelText = "A Difficult Obstacle.";
}

void setup6() {
  grid.setTileSprite(0, 0, 1, 10);
  grid.setTileSprite(1, 0, 1, 0);
  grid.setTileSprite(0, 1, 1, 0);
  grid.setTileSprite(2, 3, 1, 10);
  grid.setTileSprite(3, 3, 1, 0);
  grid.setTileSprite(4, 3, 1, 7);
  grid.setTileSprite(3, 5, 1, 0);
  grid.setTileSprite(3, 6, 1, 7);
  grid.setTileSprite(4, 6, 1, 7);
  grid.setTileSprite(0, 9, 1, 0);
  grid.setTileSprite(1, 9, 1, 10);
  grid.setTileSprite(2, 9, 1, 0);
  grid.setTileSprite(3, 9, 1, 0); 
  grid.setTileSprite(6, 2, 1, 10);
  grid.setTileSprite(6, 3, 1, 10);
  grid.setTileSprite(6, 4, 1, 0);
  grid.setTileSprite(6, 5, 1, 0);
  grid.setTileSprite(6, 6, 1, 0);
  grid.setTileSprite(7, 3, 1, 10);
  grid.setTileSprite(9, 6, 1, 0);
  grid.setTileSprite(9, 9, 1, 10);
  grid.setTileSprite(8, 9, 1, 8);
  grid.setTileSprite(7, 9, 1, 8);
  grid.setTileSprite(5, 3, 1, 7);
  grid.setTileSprite(9, 8, 1, 7);
  grid.setTileSprite(7, 6, 1, 12);
  


  grid.setTileSprite(1, 1, 3, 5);
  grid.setTileSprite(9, 7, 3, 5);
  grid.setTileSprite(0, 8, 1, 9);
  grid.setTileSprite(3, 7, 1, 6);
  grid.setTileSprite(6, 9, 1, 6);
  grid.setTileSprite(7, 4, 1, 9);
  grid.setTileSprite(9, 0, 1, 6);
  grid.setTileSprite(5, 2, 1, 9);
  grid.setTileSprite(3, 0, 1, 9);
  grid.setTileSprite(6, 1, 1, 6);
  grid.setTileSprite(4, 4, 1, 6);
  
  

  grid.addHazard(0, 3, 11);
  grid.addHazard(3, 2, 11);
  grid.addHazard(0, 6, 11);
  grid.addHazard(1, 6, 11);
  grid.addHazard(2, 6, 11);
  grid.addHazard(8, 3, 11);
  grid.addHazard(7, 8, 11);
  grid.addHazard(8, 6, 11);
  grid.addHazard(1, 3, 11);
 


  grid.setSolid(0, 0, true);
  grid.setSolid(1, 0, true);
  grid.setSolid(0, 1, true);
  grid.setSolid(2, 3, true);
  grid.setSolid(3, 3, true);
  grid.setSolid(4, 3, true);
  grid.setSolid(3, 5, true);
  grid.setSolid(3, 6, true);
  grid.setSolid(4, 6, true);
  grid.setSolid(0, 9, true);
  grid.setSolid(1, 9, true);
  grid.setSolid(2, 9, true);
  grid.setSolid(3, 9, true);
  grid.setSolid(6, 2, true);
  grid.setSolid(6, 3, true);
  grid.setSolid(6, 4, true);
  grid.setSolid(6, 5, true);
  grid.setSolid(6, 6, true);
  grid.setSolid(7, 3, true);
  grid.setSolid(9, 6, true);
  grid.setSolid(9, 9, true);
  grid.setSolid(8, 9, true);
  grid.setSolid(7, 9, true);
  grid.setSolid(5, 3, true);
  grid.setSolid(9, 8, true);
  grid.setSolid(7, 6, true);
  grid.setSolid(4, 5, true);
  
  
 


  grid.addPushableTile(8, 1, 2, 1);
  grid.addPushableTile(1, 8, 2, 1);
  grid.addDoor(4, 5, 2);

  grid.addButton(9, 7, 4, 7, 6, 13, 12, false, 1);
  grid.addButton(1, 1, 4, 4, 5, 3, 2, false, 1);

  player = new Player(grid, 4, 4);
  
  levelText = "Two Rocks!?";
}

void setup7() {
  grid.setTileSprite(0, 0, 1, 10);
  grid.setTileSprite(1, 0, 1, 0);
  grid.setTileSprite(8, 0, 1, 0);
  grid.setTileSprite(9, 0, 1, 10);
  grid.setTileSprite(4, 2, 1, 0);
  grid.setTileSprite(5, 2, 1, 0);
  grid.setTileSprite(5, 3, 1, 0);
  grid.setTileSprite(2, 5, 1, 7);
  grid.setTileSprite(3, 5, 1, 7);
  grid.setTileSprite(3, 6, 1, 10);
  grid.setTileSprite(3, 7, 1, 10);
  grid.setTileSprite(4, 6, 1, 0);
  grid.setTileSprite(8, 4, 1, 7);
  grid.setTileSprite(7, 4, 1, 7);
  grid.setTileSprite(7, 5, 1, 10);
  grid.setTileSprite(7, 6, 1, 0);
  grid.setTileSprite(9, 9, 1, 10);
  grid.setTileSprite(8, 9, 1, 0);
  grid.setTileSprite(7, 9, 1, 0);
  grid.setTileSprite(0, 8, 1, 10);
  grid.setTileSprite(0, 9, 1, 0);
  grid.setTileSprite(1, 9, 1, 0);
  grid.setTileSprite(9, 4, 1, 12);


  grid.setTileSprite(1, 2, 3, 5);
  grid.setTileSprite(9, 6, 3, 5);
  grid.setTileSprite(4, 0, 1, 6);
  grid.setTileSprite(6, 0, 1, 9);
  grid.setTileSprite(0, 3, 1, 9);
  grid.setTileSprite(4, 4, 1, 9);
  grid.setTileSprite(3, 9, 1, 9);
  grid.setTileSprite(4, 9, 1, 6);
  grid.setTileSprite(6, 4, 1, 9);
  grid.setTileSprite(9, 1, 1, 6);
  grid.setTileSprite(9, 7, 1, 9);
  

  grid.addHazard(2, 1, 11);
  grid.addHazard(3, 2, 11);
  grid.addHazard(6, 3, 11);
  grid.addHazard(0, 5, 11);
  grid.addHazard(6, 8, 11);
 


  grid.setSolid(0, 0, true);
  grid.setSolid(1, 0, true);
  grid.setSolid(8, 0, true);
  grid.setSolid(9, 0, true);
  grid.setSolid(4, 2, true);
  grid.setSolid(5, 2, true);
  grid.setSolid(5, 3, true);
  grid.setSolid(2, 5, true);
  grid.setSolid(3, 5, true);
  grid.setSolid(3, 6, true);
  grid.setSolid(3, 7, true);
  grid.setSolid(4, 6, true);
  grid.setSolid(8, 4, true);
  grid.setSolid(7, 4, true);
  grid.setSolid(7, 5, true);
  grid.setSolid(7, 6, true);
  grid.setSolid(9, 9, true);
  grid.setSolid(8, 9, true);
  grid.setSolid(7, 9, true);
  grid.setSolid(0, 8, true);
  grid.setSolid(0, 9, true);
  grid.setSolid(1, 9, true);
  grid.setSolid(9, 4, true);
  grid.setSolid(7, 3, true);
  


  grid.addPushableTile(5, 1, 2, 1);
  grid.addPushableTile(2, 7, 2, 1);
  grid.addDoor(7, 3, 2);

  grid.addButton(1, 2, 4, 9, 4, 13, 12, false, 1);
  grid.addButton(9, 6, 4, 7, 3, 3, 2, false, 1);

  player = new Player(grid, 8, 8);
  
  levelText = "Roundabout.";
}

void setup8() {
  grid.setTileSprite(1, 2, 1, 10);
  grid.setTileSprite(1, 3, 1, 0);
  grid.setTileSprite(3, 1, 1, 8);
  grid.setTileSprite(0, 5, 1, 10);
  grid.setTileSprite(1, 5, 1, 0);
  grid.setTileSprite(2, 5, 1, 0); 
  grid.setTileSprite(2, 7, 1, 10);
  grid.setTileSprite(1, 7, 1, 0);
  grid.setTileSprite(0, 7, 1, 10);
  grid.setTileSprite(0, 8, 1, 0);
  grid.setTileSprite(0, 9, 1, 0);
  grid.setTileSprite(6, 2, 1, 7);
  grid.setTileSprite(7, 2, 1, 7);
  grid.setTileSprite(5, 4, 1, 0);
  grid.setTileSprite(6, 4, 1, 10);
  grid.setTileSprite(5, 5, 1, 0);
  grid.setTileSprite(8, 7, 1, 7);
  grid.setTileSprite(9, 7, 1, 7);
  grid.setTileSprite(9, 8, 1, 0);
  grid.setTileSprite(9, 9, 1, 10);
  


  grid.setTileSprite(7, 1, 3, 5);
  grid.setTileSprite(8, 2, 3, 0);
  grid.setTileSprite(9, 2, 3, 0);
  grid.setTileSprite(2, 6, 3, 0);
  grid.setTileSprite(8, 2, 1, 14);
  grid.setTileSprite(9, 2, 1, 14);
  grid.setTileSprite(2, 6, 1, 14);
  grid.setTileSprite(0, 1, 1, 6);
  grid.setTileSprite(1, 1, 1, 6);
  grid.setTileSprite(9, 0, 1, 9);
  grid.setTileSprite(3, 4, 1, 6);
  grid.setTileSprite(5, 6, 1, 9);
  grid.setTileSprite(2, 9, 1, 9);
  grid.setTileSprite(3, 9, 1, 6);
  grid.setTileSprite(8, 9, 1, 9);
  grid.setTileSprite(9, 3, 1, 6);
  grid.setTileSprite(9, 4, 1, 9);
    
  

  grid.addHazard(5, 0, 11);
  grid.addHazard(6, 1, 11);
  grid.addHazard(4, 4, 11);
  grid.addHazard(7, 5, 11);
  grid.addHazard(8, 5, 11);
  grid.addHazard(3, 8, 11);
  grid.addHazard(6, 8, 11);
  
 


  grid.setSolid(1, 2, true);
  grid.setSolid(1, 3, true);
  grid.setSolid(3, 1, true);
  grid.setSolid(0, 5, true);
  grid.setSolid(1, 5, true);
  grid.setSolid(2, 5, true);
  grid.setSolid(2, 7, true);
  grid.setSolid(1, 7, true);
  grid.setSolid(0, 7, true);
  grid.setSolid(0, 8, true);
  grid.setSolid(0, 9, true);
  grid.setSolid(6, 2, true);
  grid.setSolid(7, 2, true);
  grid.setSolid(5, 4, true);
  grid.setSolid(6, 4, true);
  grid.setSolid(5, 5, true);
  grid.setSolid(8, 7, true);
  grid.setSolid(9, 7, true);
  grid.setSolid(9, 8, true);
  grid.setSolid(9, 9, true);
  grid.setSolid(0, 6, true);
  
 


  grid.addPushableTile(7, 8, 2, 1);
 
  grid.addDoor(0, 6, 2);

  grid.addButton(7, 1, 4, 0, 6, 3, 2, false, 1);
  

  player = new Player(grid, 8, 8);
  
  levelText = "Secret Passages.";
}

void setup9() {
  grid.setTileSprite(0, 0, 1, 0);
  grid.setTileSprite(1, 0, 1, 0);
  grid.setTileSprite(2, 0, 1, 0);
  grid.setTileSprite(0, 1, 1, 0);
  grid.setTileSprite(0, 5, 1, 0);
  grid.setTileSprite(0, 7, 1, 0);
  grid.setTileSprite(0, 8, 1, 0);
  grid.setTileSprite(0, 9, 1, 0);
  grid.setTileSprite(1, 9, 1, 0);
  grid.setTileSprite(2, 9, 1, 0);
  grid.setTileSprite(5, 0, 1, 0);
  grid.setTileSprite(6, 1, 1, 0);
  grid.setTileSprite(5, 3, 1, 0);
  grid.setTileSprite(4, 3, 1, 0);
  grid.setTileSprite(3, 5, 1, 0);
  grid.setTileSprite(3, 6, 1, 0);
  grid.setTileSprite(5, 6, 1, 0);
  grid.setTileSprite(6, 0, 1, 0);
  grid.setTileSprite(8, 5, 1, 0);
  grid.setTileSprite(9, 5, 1, 0);
  grid.setTileSprite(9, 6, 1, 0);
  grid.setTileSprite(9, 7, 1, 0);



  grid.setTileSprite(1, 2, 3, 5);
  
  

  grid.addHazard(2, 1, 11);
  
 


  grid.setSolid(0, 0, true);
  
 


  grid.addPushableTile(5, 1, 2, 1);
 
  grid.addDoor(7, 3, 2);

  grid.addButton(1, 2, 4, 9, 4, 13, 12, false, 1);
  

  player = new Player(grid, 8, 8);
  
  levelText = "Smoke and Mirrors.";
}

void setup10() {
grid.setTileSprite(0, 0, 1, 10);
  


  grid.setTileSprite(1, 2, 3, 5);
  
  

  grid.addHazard(2, 1, 11);
  
 


  grid.setSolid(0, 0, true);
  
 


  grid.addPushableTile(5, 1, 2, 1);
 
  grid.addDoor(7, 3, 2);

  grid.addButton(1, 2, 4, 9, 4, 13, 12, false, 1);
  

  player = new Player(grid, 8, 8);
  
  levelText = "Roundabout.";
}

void setupEmptyLevel() { // just in case there is no next level so the game doesnt crash

  player = new Player(grid, 1, 2);
}


