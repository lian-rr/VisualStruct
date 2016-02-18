class Shape extends Graphic {
 
  int maxVertex = 20;
  int countVertex = 0;
  int mode;
  
  Shape() {
      params = new float[maxVertex*2];
  }
  
  void addVertex(float a, float b) {
    if (countVertex==maxVertex)
      expandParams();
    params[countVertex*2]=a;
    params[countVertex*2+1]=b;
    countVertex++;
    updateBounds(a, b);
  }
  
  void expandParams() {
    maxVertex = int(maxVertex*1.75);
    float[] temp = new float[maxVertex*2];
    for (int i=0; i<countVertex*2; i++)
      temp[i] = params[i];
    params = temp;
  }

  void draw() {
    preDraw();
    beginShape();
    for (int i=0; i<countVertex; i++)
      vertex(params[i*2], height-params[i*2+1]);
    endShape(mode);
    postDraw();
  }
}