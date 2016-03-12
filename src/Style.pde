class Style {
  
  static final int NONE = -1;
  
  private color stroke_color;
  private color fill_color;
  private float stroke_width;
  
  Style() {
    stroke_color = MAX_INT;
    fill_color = MAX_INT;
    stroke_width = 1;
  }
  
  Style strokeColor(color a) {
    stroke_color = a;
    return this;
  }
  
  Style fillColor(color a) {
    fill_color = a;
    return this;
  }
  
  Style strokeWidth(float a) {
    stroke_width = a;
    return this;
  }

  void draw() {
    if (stroke_color==NONE)
      noStroke();
    else if (stroke_color != MAX_INT)
      stroke(stroke_color);
    if (fill_color==NONE)
      noFill();
    else if (fill_color != MAX_INT)
      fill(fill_color); 
    if (stroke_width>0) {
      strokeWeight(System.strokeWidth);
    }
  }
}

Style newStyle() {
  return new Style();
}