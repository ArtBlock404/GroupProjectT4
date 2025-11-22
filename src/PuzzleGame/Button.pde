//r and i state where the hitbox of the buttons is, h and w state how big the hitbox is

class Button {
  PImage sprite, arrow;        
  int x, y, w, h, r, i, size;
  boolean over;
  String val;
  Button(int x, int y, int w, int h, int r, int i, String val, int size, int spriteIndex) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.i = i;
    this.val = val;
    this.size = size;
    over = false;

    sprite = buttonSprites[spriteIndex];
    
    arrow = loadImage("arrow.png");
  }

  void display() {
    if (sprite != null) {
      if (over) {
      image(sprite, x, y);
      image(arrow, r + w/2 + 10, i - 25);
    } else {
      image(sprite, x, y);
    }
      
    } else {
      fill(255);
      rect(x, y, w, h);
    }
  }
  
  boolean clicked() {
    return (mouseX > r - w/2 && mouseX < r + w/2 && mouseY > i - h/2 && mouseY < i + h/2);
  }
  void hover() {
    if(mouseX > r - w/2 && mouseX < r + w/2 && mouseY > i - h/2 && mouseY < i + h/2) {
      over = true;
    } else {
      over = false;
    }
  }
}
