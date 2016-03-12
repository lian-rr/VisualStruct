class Circle extends Graphic {
  float x,y,r;
  
  Circle(float a, float b, float c) {
    x=a;y=b;r=c;
  }
  
  void draw() {
    if (!isVisible) return;
    preDraw();
    ellipse(x,y,r,r);
    postDraw();
  }
}

Circle newCircle(float a, float b, float c) {
  return new Circle(a,b,c);
}