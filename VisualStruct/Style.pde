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