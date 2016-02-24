class Rect extends Shape {
  
  Rect(float x, float y, float a, float b) {
    this(x,y,a,b,CORNER);
  }

  Rect(float x, float y, float a, float b, int m) {
   switch (m) {
    case CORNERS:
      _Rect ((x+a)/2, (y+b)/2, a-x, b-y);
      break;
    case CORNER:
      _Rect (x, y, a, b);
      break;
    case RADIUS:
      _Rect (x, y, a*2, b*2);
      break;
    case CENTER:
      _Rect (x+a/2, y+b/2, a, b);
      break;
    }
  }

  void _Rect(float a, float b, float c, float d) {
    params = new float[] {a, b, a, b+d, a+c, b+d, a+c, b};
    bounds = new Bounds(a, b, a+c, b+d);
    countVertex = params.length/2;
  }
}