class Group extends Graphic {

  private ArrayList children;
  private Font font;
  private Symbol _symbol;
  
  Group() {
    children = new ArrayList();
  }
  
  Group fillColor(color f) {
    super.fillColor(f);
    return this;
  }
  
  Group strokeColor(color s) {
    super.strokeColor(s);
    return this;
  }
  
  Group strokeWidth(float w) {
    super.strokeWidth(w);
    return this;
  }
  
  Group translate(float a, float b) {
    super.translate(a,b);
    return this;
  }
  
  Group scale(float a, float b) {
    super.scale(a,b);
    return this;
  }
  
  Group rotate(float a) {
    super.rotate(a);
    return this;
  }
  
  Group fontSize(int s) {
    if (font==null)
      font = newFont();
    font.size(s);
    return this;
  }
  
  Group fontFamily(String f) {
    if (font==null)
      font = newFont();
    font.family(f);
    return this;
  }
  
  Group fontAnchor(int a) {
    if (font==null)
      font = newFont();
    font.anchor(a);
    return this;
  }
  
  Group fontRotation(int a) {
    if (font==null)
      font = newFont();
    font.rotation(a);
    return this;
  }
  
  Group symbol(float[] v) {
    if (_symbol==null)
      _symbol = newSymbol();
    _symbol.vertices = v;
    return this;
  }
  
  Group symbolMode(int m) {
    if (_symbol==null)
      _symbol = newSymbol();
    _symbol.mode = m;
    return this;
  }
  
  Group add(Graphic g) {
    children.add(g);
    g.parent(this);
    return this;
  }
  
  int len() {
    return children.size();
  }
  
  Graphic get(int i) {
    return (Graphic)children.get(i);
  }
  
  Group empty() {
    children.clear();
    return this;
  }
  
  void click(float x, float y, Action act) {
    for (int i=0; i<len();i++)
      ((Graphic)get(i)).click(x,y,act);
  }
  
  void draw() {
    if (!isVisible) return;
    if (System.symbol==null)
      System.symbol = newSymbol();
    Symbol temp=null;
    if (_symbol!=null) {
      temp = System.symbol;
      System.symbol=_symbol;
    }
    preDraw();
    if (font!=null)
      font.draw();
    for (int i=0; i<children.size();i++)
      ((Graphic)children.get(i)).draw();
    if (_symbol!=null)
       System.symbol = temp;
    postDraw();
  }
}

Group newGroup() {
  return new Group();
}