class Ellipse extends Graphic {
  float x,y,rx,ry;

  Ellipse(float a, float b, float c, float d) {
    x=a;y=b;rx=c;ry=d;
  }
  
  void draw() {
    if (!isVisible) return;
    preDraw();
    ellipse(x,y,rx,ry);
    postDraw();
  }
}

Ellipse newEllipse(float x, float y, float a, float b) {
  return new Ellipse(x,y,a,b);
}