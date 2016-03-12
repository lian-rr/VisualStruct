class Font {
  
  private PFont font; 
  private String fontFamily;
  private int fontAnchor;
  private int fontSize;
  private int fontRotation;
  
  Font() {}
  
  Font size(int s) {
    fontSize = s;
    return this;
  }
  
  Font family(String f) {
    fontFamily = f;
    return this;
  }
  
  Font anchor(int a) {
    fontAnchor = a;
    return this;
  }
  
  Font rotation(int a) {
    fontRotation = a;
    return this;
  }
  
  void draw() {
    if (fontSize!=0)
      textSize(fontSize);
    if ((font==null)&&(fontFamily!=null))
      font = loadFont(fontFamily);
    if (fontFamily!=null)
      textFont(font);
    if (fontAnchor!=-1)
       textAlign(fontAnchor);       
  }
}

Font newFont() {
  return new Font();
}