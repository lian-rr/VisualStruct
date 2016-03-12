class Polygon extends Shape {
  Polygon(float[] a) {super(a,true);}
}

Polygon newPolygon(float[] a) {
  return new Polygon(a);
}