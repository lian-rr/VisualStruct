class Bezier extends Shape {

  Bezier(float x1, float y1, float x2, float y2, 
    float x3, float y3, float x4, float y4) {
      this(x1,y1,x2,y2,x3,y3,x4,y4,10);
  }
  
  Bezier(float x1, float y1, float x2, float y2, 
    float x3, float y3, float x4, float y4, int n) {
    modeShape = OPEN;
    params = new float[(n+1)*2];

    for (int i=0; i <= n; ++i) {
      double t = (double)i / (double)n;
      double a = Math.pow((1.0 - t), 3.0);
      double b = 3.0 * t * Math.pow((1.0 - t), 2.0);
      double c = 3.0 * Math.pow(t, 2.0) * (1.0-t);
      double d = Math.pow(t, 3.0);
      double x = a * x1 + b * x2 + c * x3 + d * x4;
      double y = a * y1 + b * y2 + c * y3 + d * y4;
      params[i*2] = (float)x;
      params[i*2+1] = (float)y;
    }

    countVertex = params.length/2;
    updateBounds();
  }
}