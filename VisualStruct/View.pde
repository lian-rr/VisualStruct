class View extends Group {

  Bounds extent;
  Bounds dimensions;
  float scale = 1;
  float xCenter=0 , yCenter=0;

  View(float a, float b, float c, float d) {
    dimensions = new Bounds(a, b, a+c, b+d);
    transform = new Transform();
    style = new Style(0, 255, 1);
  }

  View() {
    transform = new Transform();
    style = new Style(0, 255, 1);
  }

  void draw() {
    System.reset();
    rect(dimensions.xMin-1, dimensions.yMin-1, dimensions.w()+1, dimensions.h()+1);
    //Processing.instances[0].externals.context.clip();
    clip(dimensions.xMin, dimensions.yMin, dimensions.w(), dimensions.h());
    super.draw();
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
    scale = min(dimensions.w()/extent.w(),dimensions.h()/extent.h());
    xCenter=dimensions.w()/2+dimensions.xMin; 
    yCenter=dimensions.h()/2+dimensions.yMin;
    _zoom();
  }

  void _zoom() {
    transform.reset();
    transform.translation(xCenter, yCenter);
    transform.scalation((float)scale, (float)scale);
    transform.translation(-(extent.xMin+extent.w()/2), 
      -(extent.yMin+extent.h()/2));
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

  void pick(float x, float y, Callback call) {
    System.xCoord = (x-xCenter)/scale+extent.xMin+extent.w()/2;
    System.yCoord = (y-yCenter)/scale+extent.yMin+extent.h()/2;
    execute(call);
  }
}