import java.util.ArrayList;

Grid grid;
PImage[] tileSprites;
Player player;
Button[] buttons = new Button[5];
char screen;

void setup() {
  size(800, 900);
  screen = ' ';
  buttons[0] = new Button(400, 400, 400, 100, "PLAY");
  buttons[1] = new Button(400, 550, 400, 100, "SETTINGS");
  buttons[2] = new Button(100, 825, 150, 100, "BACK");
  buttons[3] = new Button(100, 825, 150, 100, "BACK");
  buttons[4] = new Button(400, 400, 400, 100, "LEVEL ONE");
  
  tileSprites = new PImage[10];
  tileSprites[0] = loadImage("Test.png"); // example

  int cols = 10;
  int rows = 10;
  int tileSize = 800 / cols;
  int offsetY = 100;

  grid = new Grid(cols, rows, tileSize, offsetY, tileSprites);


  grid.setTileSprite(0, 1, 3, 0);
  grid.setTileSprite(0, 2, 3, 0);


  grid.setSolid(0, 1, true);
  grid.setSolid(0, 2, true);


  grid.addPushableTile(4, 4, 2, 0); // x, y, layer, spriteIndex


  player = new Player(grid, 0, 0, color(255, 200, 0));
}

void draw() {
  if (screen == ' ') {
    startscreen();
  } else if (screen == 'L') {
    levelselect();
  } else if (screen == 'S') {
    settingscreen();
  } else if (screen == '1') {
    lvlone();
  }
}

void keyPressed() {
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
    screen = ' ';
  } else if (buttons[3].over == true) {
    screen = ' ';
  } else if (buttons[4].over == true) {
    screen = '1';
  }
}
void levelselect() {
//takes you to the level select screen
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(70);
  text("LEVEL SELECT", 400, 100);
  buttons[3].display();
  buttons[3].hover(mouseX, mouseY);
  buttons[4].display();
  buttons[4].hover(mouseX, mouseY);
}

void settingscreen() {
//takes you to the settings
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

void lvlone() {
//where all of the grids and tiles and stuff are gonna show up
  background(0);
  grid.displayLayers(0, 2);


  grid.updatePushables();
  grid.displayPushables();


  player.update();
  player.display();


  grid.displayLayers(3, 3);
}

