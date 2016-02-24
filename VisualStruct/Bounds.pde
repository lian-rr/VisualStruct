class Bounds {
  float xMin, yMin, xMax, yMax;
  
  Bounds(float a, float b, float c, float d) {
    xMin = a; yMin = b; xMax = c; yMax = d;
  }
  
  Bounds(Bounds b) {
    xMin = b.xMin; yMin = b.yMin; xMax = b.xMax; yMax = b.yMax;
  }
  
  float width() { return xMax-xMin; }
  
  float height() { return yMax-yMin; }
  
  void include(float x, float y) {
    if (x<xMin) xMin = x;
    if (x>xMax) xMax = x;
    if (y<yMin) yMin = y;
    if (y>yMax) yMax = y;
  }
  
  void union(Bounds b) {
    include(b.xMin,b.yMin);
    include(b.xMax,b.yMax);
  }
  
  boolean contains(float x, float y) {
    return (xMin<x)&&(x<xMax)&&(yMin<y)&&(y<yMax);
  }
}