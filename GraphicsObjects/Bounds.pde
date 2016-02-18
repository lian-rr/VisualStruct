class Bounds {
  float xMin = MAX_FLOAT;
  float yMin = MAX_FLOAT;
  float xMax = MIN_FLOAT;
  float yMax = MIN_FLOAT;
  
  Bounds() {
  }
  
  Bounds(float a, float b, float c, float d) {
    xMin = a; yMin = b; xMax = c; yMax = d;
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
}