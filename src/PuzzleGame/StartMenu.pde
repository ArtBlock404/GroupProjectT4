// Angie Liu | 6 Nov 2025 | Delarium

Button[] buttons = new Button[2];
boolean level, settings;
char screen;

void setup() {
  size(800, 900);
  level = false;
  settings = false;
  screen = ' ';

  if (level == false) {
    buttons[0] = new Button(400, 500, 400, 400, true);
    buttons[1] = new Button(725, 825, 100, 100, false);
  }
}

void draw() {
  background(0);
  if (screen == ' ') {
    buttons[0].display();
    buttons[0].hover(mouseX, mouseY);
    buttons[1].display();
    buttons[1].hover(mouseX, mouseY);
  } else if(screen == 'L') {
    levelselect();
  } else if(screen == 'S') {
    settingscreen();
  }
}

void mousePressed() {
  if (buttons[0].over == true) {
    screen = 'L';
  } else if (buttons[1].over == true) {
    screen = 'S';
  }
}

void levelselect() {
  background(0);
  fill(255);
  textAlign(CENTER,CENTER);
  textMode(CENTER);
  textSize(70);
  text("LEVEL SELECT", 400, 100);
}

void settingscreen() {
  background(0);
  fill(255);
  textAlign(CENTER,CENTER);
  textMode(CENTER);
  textSize(70);
  text("SETTINGS", 400, 100);
}
