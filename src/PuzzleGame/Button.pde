class Button {
  PImage sprite;        
  int x, y, w, h, size;
  boolean over;
  String val;
  Button(int x, int y, int w, int h, String val, int size, int spriteIndex) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.val = val;
    this.size = size;
    over = false;

    sprite = buttonSprites[spriteIndex];
  }

  void display() {
    if (sprite != null) {
      textSize(size);
      text(val, x, y);
      image(sprite, x, y, w, h);
    } else {
      fill(255);
      rect(x, y, w, h);
    }
  }
  
  boolean clicked() {
    return (mouseX > x - w/2 && mouseX < x + w/2 &&
            mouseY > y - h/2 && mouseY < y + h/2);
  }
}
