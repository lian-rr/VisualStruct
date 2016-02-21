class View extends Group {
  
  Bounds extent;
  Bounds dimensions;
  
  View(float a, float b, float c, float d) {
    dimensions = new Bounds(a,b,a+c,b+d);
    transform = new Transform();
    style = new Style(0,255,1);
  }
  
  float scale;
  float xCenter, yCenter;
  
  View() {
    transform = new Transform();
    style = new Style(0,255,1);
  }

  void draw() {
    System.reset();
    super.draw();
  }
  
  void pan(int direction, int offset) { 
    if (direction==UP) {
      extent.yMin -= offset/scale;
      extent.yMax -= offset/scale;
    } else if (direction==DOWN) {
      extent.yMin += offset/scale;
      extent.yMax += offset/scale;
    } else if (direction==RIGHT) {
      extent.xMin -= offset/scale;
      extent.xMax -= offset/scale;
    } else if (direction==LEFT) {
      extent.xMin += offset/scale; 
      extent.xMax += offset/scale;
    }
    _zoom();
  }

  void zoomToFullExtent() {
    extent = bounds;
    _zoomToExtent();
  }
  
  void zoomToExtent(Bounds extnt) {
    extent = extnt;
    _zoomToExtent();
  }

  void _zoomToExtent() {
    scale = min(dimensions.width()/extent.width(), dimensions.height()/extent.height());
    xCenter=dimensions.width()/2; 
    yCenter=dimensions.height()/2;
    _zoom();
  }
    
  void _zoom() {
    transform.reset();
    transform.translation(xCenter,yCenter);
    transform.scalation((float)scale,(float)scale);
    transform.translation(-(extent.xMin+extent.width()/2), 
                              -(extent.yMin+extent.height()/2));
    style.strokeWidth = (1/scale);
  }

  void zoomToScale(float scl) { 
    scale *= scl;
    _zoom();
  }

  void translateCenter(float x, float y) {
    extent.xMin += x/scale; 
    extent.xMax += x/scale;
    extent.yMin -= y/scale; 
    extent.yMax -= y/scale;
    _zoom();
  }

  void keyPressed() {
    if (keyCode == TAB)
      zoomToScale(0.9);
    if (keyCode == BACKSPACE)
      zoomToScale(1.1);
    if (keyCode == UP)
      pan(UP, 10);
    else if (keyCode == DOWN)
      pan(DOWN, 10);
    else if (keyCode == RIGHT)
      pan(RIGHT, 10);
    else if (keyCode == LEFT)
      pan(LEFT, 10);
  }
}