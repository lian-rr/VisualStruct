abstract class Graphic {
  
  Transform transform;
  Bounds bounds;
  Graphic parent;
  Style style;
  Info info;
  
  boolean visible = true;

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
  
  boolean contains(float x, float y) {
    return (bounds.contains(x,y));
  }
  
  void execute(Callback call) {
    call.run(this);
  }
  
  void updateBounds(Bounds b) {
   if (bounds==null)
      bounds = new Bounds(b);
   else
      bounds.union(b);
   if (parent!=null)
      parent.updateBounds(b);
  }
}