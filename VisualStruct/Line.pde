class Line extends Shape {

  Line(float a, float b, float c, float d) {
    params = new float[] {a,b,c,d};
    bounds = new Bounds(a,b,c,d);
    maxVertex = countVertex = params.length/2;
  }
}