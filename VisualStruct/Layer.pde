class Layer extends Group {
  
  void loadBNA(String filename) {
    Polygon polygon = null;
    String lines[] = loadStrings(filename);
    float x, y;
    int n=0;
    for (int i=0; i<lines.length; i++) {
      String[] list=splitTokens(lines[i], ",");
      if (n > 0) {
        x=float(list[0]);
        y=float(list[1]);
        n--;
        polygon.addVertex(x, y);
      } else if (list[0].charAt(0)=='"') {
        int c = parseInt(list[list.length-1]);
        n = abs(c);
        polygon = new Polygon();
        addItem(polygon);
      }
    }
  }
}