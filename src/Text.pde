class Text extends Graphic {
  float x,y;
  String str;
  Font font;
  
  Text(String s, float a, float b) {
    str=s;x=a;y=b;
  }
  
  Text fontSize(int s) {
    if (font==null)
      font = newFont();
    font.size(s);
    return this;
  }
  
  Text fontFamily(String f) {
    if (font==null)
      font = newFont();
    font.family(f);
    return this;
  }
  
  Text fontAnchor(int a) {
    if (font==null)
      font = newFont();
    font.anchor(a);
    return this;
  }
  
  Text fontRotation(int a) {
    if (font==null)
      font = newFont();
    font.rotation(a);
    return this;
  }
  
  void draw() {
    if (!isVisible) return;
    preDraw();
    if (font!=null)
      font.draw();
    if (System.fontRotation!=0)
      rotate(System.fontRotation);
    text(str,x,y);
    postDraw();
  }
}

Text newText(String s, float a, float b) {
  return new Text(s,a,b);
}