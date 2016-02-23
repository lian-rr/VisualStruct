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