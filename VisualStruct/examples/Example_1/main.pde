Group g;

void setup() {
  size(320, 240);
  g = new Group();
  Rect r1 = new Rect(20, 30, 40, 50);
  g.addItem(r1);
  Rect r2 = new Rect(120, 130, 40, 50);
  g.addItem(r2);
  Line l1 = new Line(5, 5, 200, 250);
  g.addItem(l1);
}

void draw() {
  g.draw();
}