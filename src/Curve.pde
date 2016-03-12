class Curve extends Graphic {
  float x1,x2,x3,x4,y1,y2,y3,y4;
  
  Curve(float a, float b, float c, float d, float e, float f, float g, float h) {
    x1=a;y1=b;x2=c;y2=d;x3=e;y3=f;x4=g;y4=h;
  }
  
  void draw() {
    if (!isVisible) return;
    preDraw();
    curve(x1,y1,x2,y2,x3,y3,x4,y4);
    postDraw();
  }
}

Curve newCurve(float a, float b, float c, float d, float e, float f, float g, float h) {
  return new Curve(a,b,c,d,e,f,g,h);
}