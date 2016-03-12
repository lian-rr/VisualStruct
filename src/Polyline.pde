class Polyline extends Shape {
  Polyline(float[] a) {super(a,false);}
}

Polyline newPolyline(float[] a) {
  return new Polyline(a);
}