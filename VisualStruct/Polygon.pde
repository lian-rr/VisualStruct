class Polygon extends Shape {

  Polygon() {
    params = new float[maxVertex*2];
  }
  
  Polygon(float[] a) {
    params = a;
    maxVertex = countVertex = params.length/2;
    createBounds();
  }

  void addVertex(float x, float y) {
    if (maxVertex==countVertex)
      expand(int(maxVertex*1.75));
    params[countVertex*2] = x;
    params[countVertex*2+1] = y;
    countVertex++;
    if (bounds==null)
      bounds = new Bounds(x,y,x,y);
    else
      bounds.include(x,y);
    updateBounds(bounds);
  }
}