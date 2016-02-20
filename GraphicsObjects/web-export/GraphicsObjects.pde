View map;
  
void setup() {
  size(640, 480);
  map = new View(0,0,640,480);
  Layer layer = new Layer();
  map.addItem(layer);
  layer.loadBNA("cantones.bna");
  map.zoomToFullExtent();
}

void draw() {
  background(255); // Processing function
  map.draw();
}

void keyPressed() {
  map.keyPressed();
}

void mouseDragged() {
  map.translateCenter(pmouseX-mouseX,pmouseY-mouseY);
}
class Bounds {
  float xMin = MAX_FLOAT;
  float yMin = MAX_FLOAT;
  float xMax = MIN_FLOAT;
  float yMax = MIN_FLOAT;
  
  Bounds() {
  }
  
  Bounds(float a, float b, float c, float d) {
    xMin = a; yMin = b; xMax = c; yMax = d;
  }

  float width() { return xMax-xMin; }
  
  float height() { return yMax-yMin; }
  
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
abstract class Graphic {
  
  private int mode;
  protected float[] params;
  Transform transform;
  Bounds bounds = new Bounds();
  Graphic parent = null;
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
class Group extends Graphic {

  private ArrayList children;
  Font font;
  
  Group() {
    children = new ArrayList();
  }
  
  void addItem(Graphic g) {
    children.add(g);
    g.parent = this;
  }
  
  void empty() {
    children.clear();
  }
  
  void draw() {
    preDraw();
    if (font!=null)
      font.draw();
    for (int i=0; i<children.size();i++)
      ((Graphic)children.get(i)).draw();
    postDraw();
  }
}
class Info {
}
class Layer extends Group {
  
  void loadBNA(String filename) {
    Shape shape = null;
    String lines[] = loadStrings(filename);
    float x, y;
    int n=0;
    for (int i=0; i<lines.length; i++) {
      String[] list=splitTokens(lines[i], ",");
      if (n > 0) {
        x=float(list[0]);
        y=float(list[1]);
        n--;
        shape.addVertex(x, y);
      } else if (list[0].charAt(0)=='"') {
        int c = parseInt(list[list.length-1]);
        n = abs(c);
        shape = new Shape();
        shape.info = new ShapeInfo(c);
        addItem(shape);
      }
    }
  }
}
class Shape extends Graphic {
 
  int maxVertex = 20;
  int countVertex = 0;
  int mode;
  
  Shape() {
      params = new float[maxVertex*2];
  }
  
  void addVertex(float a, float b) {
    if (countVertex==maxVertex)
      expandParams();
    params[countVertex*2]=a;
    params[countVertex*2+1]=b;
    countVertex++;
    updateBounds(a, b);
  }
  
  void expandParams() {
    maxVertex = int(maxVertex*1.75);
    float[] temp = new float[maxVertex*2];
    for (int i=0; i<countVertex*2; i++)
      temp[i] = params[i];
    params = temp;
  }

  void draw() {
    preDraw();
    beginShape();
    println(countVertex);
    for (int i=0; i<countVertex; i++)
      vertex(params[i*2], height-params[i*2+1]);
    endShape(mode);
    postDraw();
  }
}
class ShapeInfo extends Info {
  int type;
  
  ShapeInfo(int t) {
    type = t;
  }
}
class Style {
  
  int strokeColor;
  int fillColor;
  float strokeWidth;

  Style(int a) {
    strokeColor = a;
  }

  Style(int a, int b) {
    strokeColor = a; fillColor = b;
  }

  Style(int a, int b, int c) {
    strokeColor = a; fillColor = b; strokeWidth = c;
  }

  void draw() {
    if (strokeColor<0)
      noStroke();
    else 
      stroke(strokeColor);
    if (fillColor<0)
      noFill();
    else 
      fill(fillColor); 
    if (strokeWidth>0)
      strokeWeight(strokeWidth);
  }
}
class Text extends Graphic {

  String str;
  Font font;

  Text(String _str, float x, float y) {
    params = new float[] {x, y};
    str = _str;
    bounds = new Bounds(x,y,x+5,y+5);
  }
  
  void draw() {
    preDraw();
    if (font!=null)
      font.draw();
    text(str,params[0],height-params[1]);
    postDraw();
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
    zoomToExtent(extent);
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
    
    transform.reset();
    transform.translation(xCenter,yCenter);
    transform.scalation((float)scale,(float)scale);
    transform.translation(-(extent.xMin+extent.width()/2), 
                              -(extent.yMin+extent.height()/2));
    style.strokeWidth = (1/scale);
  }

  void zoomToScale(float scl) { 
    scale = scl;
  }

  void zoomOut(int offset) {
    extent.xMin -= offset/scale;
    extent.xMax += offset/scale;
    extent.yMin -= offset/scale;
    extent.yMax += offset/scale;
    zoomToExtent(extent);
  }

  void zoomIn(int offset) { 
    extent.xMin += offset/scale;
    extent.xMax -= offset/scale;
    extent.yMin += offset/scale;
    extent.yMax -= offset/scale;
    zoomToExtent(extent);
  }

  void translateCenter(float x, float y) {
    extent.xMin += x/scale; 
    extent.xMax += x/scale;
    extent.yMin -= y/scale; 
    extent.yMax -= y/scale;
    zoomToExtent(extent);
  }

  void keyPressed() {
    if (keyCode == TAB)
      zoomIn(10);
    if (keyCode == BACKSPACE)
      zoomOut(10);
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
