
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
char screen;
PImage p2;

int level = 1;
int cols = 10;
int rows = 10;
int tileSize = 800 / cols;
int offsetY = 100;

void setup() {
  size(800, 900);
  screen = 'M';
  //Buttons
  buttons[0] = new Button(400, 350, 400, 140, "PLAY");
  buttons[1] = new Button(400, 550, 250, 100, "SETTINGS");
  buttons[2] = new Button(50, 50, 100, 100, "BACK");

  p2 = loadImage("settings.png");

  tileSprites = new PImage[2];
  tileSprites[0] = loadImage("Test.png"); // example
    tileSprites[1] = loadImage("Test2.PNG"); // example


  tileSize = 800 / cols;
  offsetY = 100;

  loadLevel(level);

}

void draw() {
  for (int i = 0; i<buttons.length; i++) {
    buttons[i].display();
    buttons[i].hover(mouseX, mouseY);
  }
  if (screen == 'M') {
    startscreen();
  } else if (screen == 'L') {
    one();
  } else if (screen == 'S') {
    settingscreen();
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
  if (buttons[0].over == true) {
    screen = 'L';
  } else if (buttons[1].over == true) {
    screen = 'S';
  } else if (buttons[2].over == true) {
    screen = 'M';
  }
  println("screen:" + screen);
}


void settingscreen() {
  //The settings screen
  background(0);
  fill(255);
  image(p2, 150, 50);
  p2.resize(500, 150);
  buttons[2].display();
  buttons[2].hover(mouseX, mouseY);
}

void startscreen() {
  //Main menu
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(70);
  text("DELARIUM", 400, 100);
  buttons[0].display();
  buttons[0].hover(mouseX, mouseY);
  buttons[1].display();
  buttons[1].hover(mouseX, mouseY);
}

void one() {
  //where all of the game content will show up
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

  grid.addDoor(8, 8, 1);
 
  player = new Player(grid, 5, 5, color(255, 200, 0));
}

void setupEmptyLevel() { // just in case there is no next level so the game doesnt crash
 
  player = new Player(grid, 0, 0, color(255, 200, 0));
}
