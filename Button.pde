class Button {
  int x, y, widthB, heightB;
  color c, highlight;
  boolean hover;
  String text;

  Button(int init_X, int init_Y, int init_W, int init_H, color init_C, color init_HC, String init_T) {
    x = init_X;
    y = init_Y;
    widthB = init_W;
    heightB = init_H;
    c = init_C;
    highlight = init_HC;
    text = init_T;
    hover = false;
  }

  void update() {
    if (widthB/2 > abs(mouseX - x) && heightB/2 > abs(mouseY - y)) {
      hover = true;
    } else {
      hover = false;
    }
    fill(c);
    if (hover) {
      fill(highlight);
    }
    rectMode(CENTER);
    textAlign(CENTER);
    rect(x, y, widthB, heightB);
    fill(0);
    text(text, x, y);
  }

  boolean hovering() {
    if (hover) {
      return true;
    }
    return false;
  }
}