/* Visual Structure Library */
/* Copyright (c) 2016 Armando Arce, GPL3 */

abstract class Graphic {

  Transform transform = null;
  Bounds bounds = null;
  Graphic parent = null;
  Style style = null;
  Info info = null;

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
    return (bounds.contains(x, y));
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

class Transform {

  final int TRANSLATE = 0;
  final int SCALE = 1;
  final int ROTATE = 2;
  
  ArrayList trans;
  
  class Method {
    int type;
    float x,y;
    Method(int t, float a, float b) {
      type = t; x = a; y = b;
    }
  }
  
  Transform() {
    trans = new ArrayList();
  }
  
  void translation(float x, float y) {
    trans.add(new Method(TRANSLATE,x,y));
  }
  
  void scalation(float x, float y) {
    trans.add(new Method(SCALE,x,y));
  }
  
  void rotation(float x) {
    trans.add(new Method(ROTATE,x,0));
  }
  
  void reset() {
    trans.clear();
  }
  
  void draw() {
    for (int i=0; i<trans.size(); i++) {
      Method m = (Method)trans.get(i);
      switch (m.type) {
        case TRANSLATE:
          translate(m.x,-m.y);
          break;
        case SCALE:
          translate(0,height);
          scale(m.x,m.y);
          translate(0,-height);
          break;
        case ROTATE:
          translate(0,height);
          rotate(radians(m.x));
          translate(0,-height);
          break;
      }
    }
  }
}

class Bounds {
  float xMin, yMin, xMax, yMax;
  
  Bounds(float a, float b, float c, float d) {
    xMin = a; yMin = b; xMax = c; yMax = d;
  }
  
  Bounds(Bounds b) {
    xMin = b.xMin; yMin = b.yMin; xMax = b.xMax; yMax = b.yMax;
  }
  
  float w() { return xMax-xMin; }
  
  float h() { return yMax-yMin; }
  
  void include(float x, float y) {
    if (x<xMin) xMin = x;
    if (x>xMax) xMax = x;
    if (y<yMin) yMin = y;
    if (y>yMax) yMax = y;
  }
  
  void union(Bounds b) {
    include(b.xMin,b.yMin);
    include(b.xMax,b.yMax);
  }
  
  boolean contains(float x, float y) {
    return (xMin<x)&&(x<xMax)&&(yMin<y)&&(y<yMax);
  }
}

class Style {
  
  static final int NONE = -1;
  
  color strokeColor;
  color fillColor;
  float strokeWidth;

  Style(color a) {
    strokeColor = a;
  }

  Style(color a, color b) {
    strokeColor = a; fillColor = b;
  }

  Style(color a, color b, int c) {
    strokeColor = a; fillColor = b; strokeWidth = c;
  }

  void draw() {
    if (strokeColor==NONE)
      noStroke();
    else 
      stroke(strokeColor);
    if (fillColor==NONE)
      noFill();
    else 
      fill(fillColor); 
    if (strokeWidth>0) {
      System.strokeWidth *= strokeWidth;
      strokeWeight(System.strokeWidth);
    }
  }
}

static class System {

  static float strokeWidth = 1;
  static float xCoord;
  static float yCoord;
  
  static void reset() {
    strokeWidth = 1;
  }
}

abstract class Info {
}

class Group extends Graphic {

  private ArrayList children;
  Font font;
  
  Group() {
    children = new ArrayList();
  }
  
  void addItem(Graphic g) {
    children.add(g);
    g.parent = this;
    if (g.bounds!=null) {
      if (bounds==null)
        bounds = new Bounds(g.bounds);
      else
        updateBounds(g.bounds);
    }
  }
  
  void empty() {
    children.clear();
  }
  
  void draw() {
    if (!visible) return;
    preDraw();
    if (font!=null)
      font.draw();
    for (int i=0; i<children.size();i++)
      ((Graphic)children.get(i)).draw();
    postDraw();
  }
  
  void execute(Callback call) {
    super.execute(call);
    for (int i=0; i<children.size();i++)
      ((Graphic)children.get(i)).execute(call);
  }
}

class Font {
  
  private PFont font; 
  private String fontFamily;
  int fontSize;
  
  Font(int a) {
    fontSize = a;
  }
  
  Font(int a, String b) {
    fontSize = a;
    fontFamily = b;
  }
  
  void draw() {
    textSize(fontSize);
    if ((font==null)&&(fontFamily!=null))
      font = loadFont(fontFamily);
    if (fontFamily!=null)
      textFont(font);
  }
}

abstract class Shape extends Graphic {

  protected float[] params;
  protected int maxVertex = 20;
  protected int countVertex = 0;
  protected int modeShape = CLOSE;

  void draw() {
    if (!visible) return;
    preDraw();
    beginShape();
    for (int i=0; i<countVertex; i++)
      vertex(params[i*2], height-params[i*2+1]);
    endShape(modeShape);
    postDraw();
  }

  void createBounds() {
    for (int i=0; i<countVertex; i++) {
      if (bounds==null)
        bounds = new Bounds(params[i*2], params[i*2+1], params[i*2], params[i*2+1]);
      else
        bounds.include(params[i*2], params[i*2+1]);
    }
  }
  
  void expand(int n) {
    maxVertex = n;
    float[] temp = new float[maxVertex*2];
    for (int i=0; i<countVertex*2; i++)
      temp[i] = params[i];
    // free(params);
    params = temp;
  }

  boolean contains(float x, float y) {
    return (bounds.contains(x, y)&&pointInPolygon(x, y));
  }

  boolean pointInPolygon(float x, float y) {
    int i, j, n = countVertex;
    boolean c = false;

    for (i = 0, j = n - 1; i < n; j = i++) {
      if ( ( (params[i*2+1] > y ) != (params[j*2+1] > y) ) &&
        (x < (params[j*2] - params[i*2]) * (y - params[i*2+1]) / 
        (params[j*2+1] - params[i*2+1]) + params[i*2])
        )
        c = !c;
    }
    return c;
  }

  double distancePointLine(float x, float y, float x1, float y1, float x2, float y2) {
    float A = x - x1; float B = y - y1;
    float C = x2 - x1; float D = y2 - y1;

    float dot = A * C + B * D;
    float len_sq = C * C + D * D;
    float param = -1;
    if (len_sq != 0)
      param = dot / len_sq;

    float xx, yy;

    if (param < 0) {
      xx = x1; yy = y1;
    } else if (param > 1) {
      xx = x2; yy = y2;
    } else {
      xx = x1 + param * C;
      yy = y1 + param * D;
    }

    float dx = x - xx;
    float dy = y - yy;
    return Math.sqrt(dx * dx + dy * dy);
  }
  
  double distancePointPath(float x,  float y) {
    int n = countVertex;

    float distance=MAX_FLOAT;
    float temp;

    for (int i=0; i<n-1; i++) {
      temp = (float)distancePointLine(x, y, 
        params[i*2], params[i*2+1], 
        params[i*2+2], params[i*2+3]);
      if (distance > temp)
        distance = temp;
    }
    return distance;
  }
}

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
    //Processing.instances[0].externals.context.clip(); // Processingjs
    clip(dimensions.xMin, dimensions.yMin, dimensions.w(), dimensions.h()); // Processing
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
    float oldScale = scale;
    scale = min(dimensions.w()/extent.w(),dimensions.h()/extent.h());
    if (scale==MIN_FLOAT)
      scale = oldScale;
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

class Callback {

  void run(Graphic g) {
    println("picked: "+g.bounds.xMin+","+g.bounds.yMin);
  }
}

class Arc extends Shape {
  
  //static final int PIE;
  //static final int CHORD;

  Arc(float x, float y, float w, float h, float s, float e) {
    this(x, y, w, h, s, e, PIE);
  }

  Arc(float cx, float cy, float w, float h, float s, float e, int m) {
    this(cx, cy, w, h, s, e, m, 90);
  }
    
  Arc(float cx, float cy, float w, float h, float start, float end, int mode, int n) {
    params = new float[n*2];
    int parts = n;
    float part = 2.0f * 3.1415926f / parts;
    int t=0;

    if (mode==PIE) {
      params[t*2] = cx;
      params[t*2+1] = cy;
      t++;
    }

    for (float theta = start; theta < end; theta+=part, t++) {
      double x = w / 2 * Math.cos(theta);
      double y = h / 2 * Math.sin(theta);
      params[t*2] = (float)(x + cx);
      params[t*2+1] = (float)(y + cy);
    }
    countVertex = t;
    if (mode==CHORD||mode==PIE)
      modeShape = CLOSE;
    else
      modeShape = OPEN;
    createBounds();
  }
}

class Bezier extends Shape {

  Bezier(float x1, float y1, float x2, float y2, 
    float x3, float y3, float x4, float y4) {
      this(x1,y1,x2,y2,x3,y3,x4,y4,10);
  }
  
  Bezier(float x1, float y1, float x2, float y2, 
    float x3, float y3, float x4, float y4, int n) {
    modeShape = OPEN;
    params = new float[(n+1)*2];

    for (int i=0; i <= n; ++i) {
      double t = (double)i / (double)n;
      double a = Math.pow((1.0 - t), 3.0);
      double b = 3.0 * t * Math.pow((1.0 - t), 2.0);
      double c = 3.0 * Math.pow(t, 2.0) * (1.0-t);
      double d = Math.pow(t, 3.0);
      double x = a * x1 + b * x2 + c * x3 + d * x4;
      double y = a * y1 + b * y2 + c * y3 + d * y4;
      params[i*2] = (float)x;
      params[i*2+1] = (float)y;
    }

    countVertex = params.length/2;
    createBounds();
  }
}

class Curve extends Shape {
  
  Curve(float x0, float y0, float x1, float y1, 
    float x2, float y2, float x3, float y3) {
      this(x0,y0,x1,y1,x2,y2,x3,y3,10);
  }
  
  Curve(float x0, float y0, float x1, float y1, 
    float x2, float y2, float x3, float y3, int n) {
    modeShape = OPEN;
    params = new float [(n+1)*2];

    double aX = (2.0f * x1);
    double aY = (2.0f * y1);
    double bX = (-x0 + x2);
    double bY = (-y0 + y2);
    double cX = (2.0f * x0 - 5.0f * x1 + 4 * x2 - x3);
    double cY = (2.0f * y0 - 5.0f * y1 + 4 * y2 - y3);
    double dX = (-x0 + 3.0f * x1 - 3.0f * x2 + x3);
    double dY = (-y0 + 3.0f * y1 - 3.0f * y2 + y3);

    for (int i=0; i <= n; ++i) {
      double t = (double)i / (double)n;
      double t2 = t * t;
      double t3 = t2 * t;
      double x = 0.5f * (aX + bX * t + cX * t2 + dX * t3);
      double y = 0.5f * (aY + bY * t + cY * t2 + dY * t3);
      params[i*2] = (float)x;
      params[i*2+1] = (float)y;
    }
    
    countVertex = params.length/2;
    createBounds();
  }
}

class Ellipse extends Shape {

  Ellipse(float x, float y, float a, float b) {
    this(x, y, a, b, CENTER);
  }

  Ellipse(float x, float y, float a, float b, int m) {
    this(x, y, a, b, m, 90);
  }

  Ellipse(float x, float y, float a, float b, int m, int n) {
    switch (m) {
    case CORNERS:
      _Ellipse ((x+a)/2, (y+b)/2, a-x, b-y, n);
      break;
    case CENTER:
      _Ellipse (x, y, a, b, n);
      break;
    case RADIUS:
      _Ellipse (x, y, a*2, b*2, n);
      break;
    case CORNER:
      _Ellipse (x+a/2, y+b/2, a, b, n);
      break;
    }
  }

  void _Ellipse(float cx, float cy, float w, float h, int n) {
    params = new float[n*2];
    int parts = n;
    int t;
    for (t = 0; t < parts; t++) {
      float theta = 2.0f * 3.1415926f * t / parts;
      double x = cx + w / 2 * Math.cos(theta);
      double y = cy + h / 2 * Math.sin(theta);
      params[t*2] = (float)(x);
      params[t*2+1] = (float)(y);
    }
    countVertex = params.length/2;
    createBounds();
  }
}

class Line extends Shape {

  Line(float a, float b, float c, float d) {
    params = new float[] {a,b,c,d};
    bounds = new Bounds(a,b,c,d);
    maxVertex = countVertex = params.length/2;
  }
}

class Path extends Shape {
  
  Path() {
    params = new float[maxVertex*2];
  }
  
  void addPart(Shape seg) {
    if (countVertex+seg.countVertex>maxVertex)
      expand(countVertex+seg.countVertex);
    for (int i=0; i<seg.countVertex*2;i++)
      params[(countVertex*2)+i] = seg.params[i];
      
    countVertex += seg.countVertex;
    createBounds();
  }
}

class Polygon extends Shape {

  Polygon() {
    params = new float[maxVertex*2];
  }
  
  Polygon(float[] a) {
    params = a;
    maxVertex = countVertex = params.length/2;
    createBounds();
  }
}

class Rect extends Shape {
  
  Rect(float x, float y, float a, float b) {
    this(x,y,a,b,CORNER);
  }

  Rect(float x, float y, float a, float b, int m) {
   switch (m) {
    case CORNERS:
      _Rect ((x+a)/2, (y+b)/2, a-x, b-y);
      break;
    case CORNER:
      _Rect (x, y, a, b);
      break;
    case RADIUS:
      _Rect (x, y, a*2, b*2);
      break;
    case CENTER:
      _Rect (x+a/2, y+b/2, a, b);
      break;
    }
  }

  void _Rect(float a, float b, float c, float d) {
    params = new float[] {a, b, a, b+d, a+c, b+d, a+c, b};
    bounds = new Bounds(a, b, a+c, b+d);
    countVertex = params.length/2;
  }
}

class Text extends Shape {

  String str;
  Font font;

  Text(String _str, float a, float b) {
    params = new float[] {a,b};
    bounds = new Bounds(a,b-20,a+20,b+20);
    maxVertex = countVertex = params.length/2;
    str = _str;
  }
  
  void draw() {
    preDraw();
    if (font!=null)
      font.draw();
    text(str,params[0],height-params[1]);
    postDraw();
  }
}

class RoundedRect extends Path {

  RoundedRect(float x, float y, float w, float h, float r) {
    this(x,y,w,h,r,r);
  }
  
  RoundedRect(float x, float y, float w, float h, float r1, float r2) {
     addPart(new Arc(x+w-r1/2, y+h-r2/2, r1, r2, 0, HALF_PI,OPEN));
     addPart(new Line(x+w-r1,y+h,x+r1,y+h));
     addPart(new Arc(x+r1/2, y+h-r2/2, r1, r2, HALF_PI,PI,OPEN));
     addPart(new Line(x,y+h-r2,x,y+r2/2));
     addPart(new Arc(x+r1/2, y+r2/2, r1, r2, PI,PI+HALF_PI,OPEN));
     addPart(new Line(x+r1/2,y,x+w-r1/2,y));
     addPart(new Arc(x+w-r1/2, y+r2/2, r1, r2, PI+HALF_PI, TWO_PI, OPEN));
  }
}