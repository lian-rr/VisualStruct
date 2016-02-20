class Style {
  
  color strokeColor;
  color fillColor;
  float strokeWidth;

  Style(color a) {
    strokeColor = a;
  }

  Style(color a, color b) {
    strokeColor = a; fillColor = b;
  }

  Style(color a, color b, color c) {
    strokeColor = a; fillColor = b; strokeWidth = c;
  }

  void draw() {
    if (strokeColor==-1)
      noStroke();
    else 
      stroke(strokeColor);
    if (fillColor==-1)
      noFill();
    else 
      fill(fillColor); 
    if (strokeWidth>0) {
      System.strokeWidth *= strokeWidth;
      strokeWeight(System.strokeWidth);
    }
  }
}