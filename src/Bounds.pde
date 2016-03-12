class Bounds {
  float xMin, yMin, xMax, yMax;
  
  Bounds(float a, float b, float c, float d) {
    xMin = a; yMin = b; xMax = c; yMax = d;
  }
  
  Bounds(Bounds b) {
    xMin=b.xMin;yMin=b.yMin;xMax=b.xMax;yMax=b.yMax;
  }

  float w() { return xMax-xMin; }
  
  float h() { return yMax-yMin; }
  
  Bounds include(float x, float y) {
    if (x<xMin) xMin = x;
    if (x>xMax) xMax = x;
    if (y<yMin) yMin = y;
    if (y>yMax) yMax = y;
    return this;
  }
  
  Bounds union(Bounds b) {
    include(b.xMin,b.yMin);
    include(b.xMax,b.yMax);
    return this;
  }
  
  Bounds translate(float x, float y) {
    xMin += x; xMax += x;
    yMin += y; yMax += y;
    return this;
  }
}