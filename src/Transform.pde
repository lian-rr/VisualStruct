class Transform {

  final int TRANSLATE = 0;
  final int SCALE = 1;
  final int ROTATE = 2;
  
  private ArrayList trans;
  
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
  
  Transform translation(float x, float y) {
    trans.add(new Method(TRANSLATE,x,y));
    return this;
  }
  
  Transform scalation(float x, float y) {
    trans.add(new Method(SCALE,x,y));
    return this;
  }
  
  Transform rotation(float x) {
    trans.add(new Method(ROTATE,x,0));
    return this;
  }
  
  Transform reset() {
    trans.clear();
    return this;
  }
  
  void draw() {
    for (int i=0; i<trans.size(); i++) {
      Method m = (Method)trans.get(i);
      switch (m.type) {
        case TRANSLATE:
          translate(m.x,m.y);
          break;
        case SCALE:
          scale(m.x,m.y);
          break;
        case ROTATE:
          rotate(radians(m.x));
          break;
      }
    }
  }
}

Transform newTransform() {
  return new Transform();
}