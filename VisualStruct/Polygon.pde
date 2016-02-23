class Polygon extends Shape {

  Polygon(float[] a) {
    params = a;
    maxVertex = countVertex = params.length/2;
    for (int i=0; i<countVertex; i++) {
      if (bounds==null)
        bounds = new Bounds(params[i],params[i*2],params[i],params[i*2]);
      else
        bounds.include(params[i],params[i*2]);
    }
  }
}