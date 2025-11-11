import java.util.ArrayList;

Grid grid;
PImage[] tileSprites;
Player player;

void setup() {
  size(800, 900);


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
  background(0);

  
  grid.displayLayers(0, 2);  

  
  grid.updatePushables();
  grid.displayPushables();    

  
  player.update();
  player.display();

  
  grid.displayLayers(3, 3);  
}

void keyPressed() {
  if (key == 'w' || key == 'W' || keyCode == UP) player.move(0, -1);
  if (key == 's' || key == 'S' || keyCode == DOWN) player.move(0, 1);
  if (key == 'a' || key == 'A' || keyCode == LEFT) player.move(-1, 0);
  if (key == 'd' || key == 'D' || keyCode == RIGHT) player.move(1, 0);
}
