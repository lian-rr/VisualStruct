class Arc extends Graphic {
  float x1,x2,x3,y1,y2,y3;

  Arc(float a, float b, float c, float d, float e, float f) {
    x1=a;y1=b;x2=c;y2=d;x3=e;y3=f;
  }
  
  void draw() {
    if (!isVisible) return;
    preDraw();
    arc(x1,y1,x2,y2,x3,y3);
    postDraw();
  }
}

Arc newArc(float a, float b, float c, float d, float e, float f) {
  return new Arc(a,b,c,d,e,f);
}