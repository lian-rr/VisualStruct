class RoundedRect extends Path {

  RoundedRect(float x, float y, float w, float h, float r) {
    this(x,y,w,h,r,r);
  }
  
  RoundedRect(float x, float y, float w, float h, float r1, float r2) {
     addPart(new Arc(x+w-r1/2, y+h-r2/2, r1, r2, 0, HALF_PI,OPEN));
     addPart(new Line(x+w-r1,y+h,x+r1,y+h));
     addPart(new Arc(x+r1/2, y+h-r2/2, r1, r2, HALF_PI,PI,OPEN));
     addPart(new Line(x,y+h-r2,x,y+r2/2));
     addPart(new Arc(x+r1/2, y+r2/2, r1, r2, PI,PI+HALF_PI,OPEN));
     addPart(new Line(x+r1/2,y,x+w-r1/2,y));
     addPart(new Arc(x+w-r1/2, y+r2/2, r1, r2, PI+HALF_PI, TWO_PI, OPEN));
  }
}