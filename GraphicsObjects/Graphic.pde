abstract class Graphic {
  private int mode;
  protected float[] params;
  Transform transform;
  Bounds bounds = new Bounds();
  Graphic parent=null;
  Style style;
  Info info;

  void preDraw() {
    if (style!=null) {
      pushStyle();
      style.draw();
    }
    if (transform!=null) {
      pushMatrix();
      transform.draw();
    }
  }
  
  abstract void draw();
  
  void postDraw() {
    if (style!=null)
      popStyle();
    if (transform!=null)
      popMatrix();
  }
  
  void updateBounds(float x, float y) {
    bounds.include(x, y);
    if (parent!=null)
      parent.updateBounds(x,y);
  }
}