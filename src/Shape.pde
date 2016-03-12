class Shape extends Graphic {
  protected float[] coords;
  private Bounds bnds;
  boolean closed;
  
  Shape(float[] a, boolean m) {
    coords=a; closed=m;
    createBounds();
  }
  
  float[] vertices() {
    return coords;
  }
  
  Bounds bounds() {
    return bnds;
  }

  void draw() {
    if (!isVisible) return;
    preDraw();
    beginShape();
    for (int i=0;i<coords.length/2;i++)
      vertex(coords[i*2],coords[i*2+1]);
    if (closed)
      endShape(CLOSE);
    else
      endShape();
    postDraw();
  }

  void createBounds() {
    for (int i=0;i<coords.length/2;i++) {
      if (bnds==null)
        bnds = new Bounds(coords[i*2],coords[i*2+1],coords[i*2],coords[i*2+1]);
      else
        bnds.include(coords[i*2],coords[i*2+1]);
    }
  }
}