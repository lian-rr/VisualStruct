class Rect extends Graphic {
  float x,y,w,h,r;
  boolean rounded;
  
  Rect(float a, float b, float c, float d) {
    x=a;y=b;w=c;h=d;rounded=false;
  }
  
  Rect(float a, float b, float c, float d, float e) {
    x=a;y=b;w=c;h=d;r=e;rounded=true;
  }

  void draw() {
    if (!isVisible) return;
    preDraw();
    if (rounded)
      rect(x,y,w,h,r);
    else
      rect(x,y,w,h);
    postDraw();
  }
}

Rect newRect(float a, float b, float c, float d) {
  return new Rect(a,b,c,d);
}

Rect newRect(float a, float b, float c, float d, float e) {
  return new Rect(a,b,c,d,e);
}