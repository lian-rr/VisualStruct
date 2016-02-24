class Path extends Shape {
  
  int maxVertex = 20;
  
  Path() {
    params = new float[maxVertex*2];
  }
  
  void addPart(Shape seg) {
    if (countVertex+seg.countVertex>maxVertex)
      expand(countVertex+seg.countVertex);
    for (int i=0; i<seg.countVertex*2;i++)
      params[(countVertex*2)+i] = seg.params[i];
      
    countVertex += seg.countVertex;
    updateBounds();
  }
  
  void expand(int n) {
    maxVertex = n;
    float[] temp = new float[maxVertex*2];
    for (int i=0; i<countVertex*2; i++)
      temp[i] = params[i];
    // free(params);
    params = temp;
  }
}