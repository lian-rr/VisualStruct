class Polygon extends Shape {

  Polygon(float[] a) {
    params = a;
    maxVertex = countVertex = params.length/2;
    updateBounds();
  }
}