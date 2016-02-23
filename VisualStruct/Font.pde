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