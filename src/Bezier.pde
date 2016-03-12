class Bezier extends Graphic {
  float x1,x2,x3,x4,y1,y2,y3,y4;

  Bezier(float a, float b, float c, float d, float e, float f, float g, float h) {
    x1=a;y1=b;x2=c;y2=d;x3=e;y3=f;x4=g;y4=h;
  }
  
  void draw() {
    if (!isVisible) return;
    preDraw();
    bezier(x1,y1,x2,y2,x3,y3,x4,y4);
    postDraw();
  }
}

Bezier newBezier(float a, float b, float c, float d, float e, float f, float g, float h) {
  return new Bezier(a,b,c,d,e,f,g,h);
}