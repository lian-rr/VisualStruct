class Line extends Graphic {
  float x1,x2,y1,y2;

  Line(float a, float b, float c, float d) {
    x1=a;y1=b;x2=c;y2=d;
  }
  
  void draw() {
    if (!isVisible) return;
    preDraw();
    line(x1,y1,x2,y2);
    postDraw();
  }
}

Line newLine(float a, float b, float c, float d) {
  return new Line(a,b,c,d);
}