abstract class Graphic {

  protected Transform transform = null;
  protected Graphic parent = null;
  protected Style style = null;
  protected Info info = null;

  boolean isVisible = true;

  Graphic visible(boolean v) {
    isVisible = v;
    return this;
  }
  
  Graphic parent(Graphic g) {
    parent = g;
    return this;
  }

  Graphic info(Info i) {
    info = i;
    return this;
  }

  Graphic fillColor(color f) {
    if (style==null)
      style = new Style();
    style.fillColor(f);
    return this;
  }

  Graphic strokeColor(color s) {
    if (style==null)
      style = new Style();
    style.strokeColor(s);
    return this;
  }

  Graphic strokeWidth(float w) {
    if (style==null)
      style = new Style();
    style.strokeWidth(w);
    return this;
  }

  Graphic translate(float a, float b) {
    if (transform==null)
      transform = new Transform();
    transform.translation(a,b);
    return this;
  }

  Graphic scale(float a, float b) {
    if (transform==null)
      transform = new Transform();
    transform.scalation(a,b);
    return this;
  }

  Graphic rotate(float a) {
    if (transform==null)
      transform = new Transform();
    transform.rotation(a);
    return this;
  }

  Graphic resetTrans() {
    if (transform==null)
      transform = new Transform();
    transform.reset();
    return this;
  }

  void preDraw() {
    if (style!=null) {
      pushStyle();
      if (style.stroke_width>0)
        System.strokeWidth *= style.stroke_width;
      style.draw();
    }
    if (transform!=null) {
      pushMatrix();
      transform.draw();
    }
  }

  abstract void draw();

  void postDraw() {
    if (style!=null) {
      popStyle();
      if (style.stroke_width>0)
      System.strokeWidth /= style.stroke_width;
    }
    if (transform!=null)
      popMatrix();
  }

  void click(float x,float y,Action act) {};
}