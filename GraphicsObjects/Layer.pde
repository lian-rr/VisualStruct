class Layer extends Group {
  
  Layer() {
    style = new Style(0,255,1);
  }
  
  void loadBNA(String filename) {
    Shape shape = null;
    String lines[] = loadStrings(filename);
    float x, y;
    int n=0;
    for (int i=0; i<lines.length; i++) {
      String[] list=splitTokens(lines[i], ",");
      if (n > 0) {
        x=float(list[0]);
        y=float(list[1]);
        n--;
        shape.addVertex(x, y);
      } else if (list[0].charAt(0)=='"') {
        int c = parseInt(list[list.length-1]);
        n = abs(c);
        shape = new Shape();
        shape.info = new ShapeInfo(c);
        add(shape);
      }
    }
  }
}