//guys, press play to be able to see the grid, enemies, play, etc.

import java.util.ArrayList;

Grid grid;
PImage[] tileSprites;
Player player;
Button[] buttons = new Button[3];
char screen;

void setup() {
  size(800, 900);
  screen = 'M';
//Buttons
  buttons[0] = new Button(400, 400, 400, 100, "PLAY");
  buttons[1] = new Button(400, 550, 400, 100, "SETTINGS");
  buttons[2] = new Button(100, 825, 150, 100, "BACK");
  
  tileSprites = new PImage[10];
  tileSprites[0] = loadImage("Test.png"); // example

  int cols = 10;
  int rows = 10;
  int tileSize = 800 / cols;
  int offsetY = 100;

//Grid
  grid = new Grid(cols, rows, tileSize, offsetY, tileSprites);


  grid.setTileSprite(0, 1, 3, 0);
  grid.setTileSprite(0, 2, 3, 0);


  grid.setSolid(0, 1, true);
  grid.setSolid(0, 2, true);


  grid.addPushableTile(4, 4, 2, 0); // x, y, layer, spriteIndex


  player = new Player(grid, 0, 0, color(255, 200, 0));
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
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(70);
  text("SETTINGS", 400, 100);
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


  grid.displayLayers(3, 3);
}


