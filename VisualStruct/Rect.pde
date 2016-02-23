class Rect extends Shape {

  Rect(float a, float b, float c, float d) {
    params = new float[] {a, b, a, b+d, a+c, b+d, a+c, b};
    bounds = new Bounds(a, b, a+c, b+d);
    maxVertex = countVertex = params.length/2;
  }
}