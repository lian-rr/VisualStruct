class Mark extends Graphic {
  float x,y,w,h;
  Symbol _symbol;
  
  Mark(float a, float b, float c, float d) {
    x=a; y=b; w=c; h=d;
  }
  
  Mark symbol(float[] v) {
    if (_symbol==null)
      _symbol = newSymbol();
    _symbol.vertices = v;
    return this;
  }
  
  Mark symbolMode(int m) {
    if (_symbol==null)
      _symbol = newSymbol();
    _symbol.mode = m;
    return this;
  }
  
  void draw() {
    if (!isVisible) return;
    if (System.symbol==null)
      System.symbol = newSymbol();
    Symbol temp=null;
    preDraw();
    if (_symbol!=null) {
      temp = System.symbol;
      System.symbol = _symbol;
    }
    float[] coords = System.symbol.vertices;
    beginShape();
    for (int i=0;i<coords.length/2;i++)
      vertex(x+coords[i*2]*System.strokeWidth*w,y+coords[i*2+1]*System.strokeWidth*h);
    endShape(CLOSE);
    if (_symbol!=null)
       System.symbol = temp;
    postDraw();
  }
}

Mark newMark(float a,float b,float c,float d) {
  return new Mark(a,b,c,d);
}