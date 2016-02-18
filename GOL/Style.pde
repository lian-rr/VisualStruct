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