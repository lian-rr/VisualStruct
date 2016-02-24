class Curve extends Shape {
  
  Curve(float x0, float y0, float x1, float y1, 
    float x2, float y2, float x3, float y3) {
      this(x0,y0,x1,y1,x2,y2,x3,y3,10);
  }
  
  Curve(float x0, float y0, float x1, float y1, 
    float x2, float y2, float x3, float y3, int n) {
    modeShape = OPEN;
    params = new float [(n+1)*2];

    double aX = (2.0f * x1);
    double aY = (2.0f * y1);
    double bX = (-x0 + x2);
    double bY = (-y0 + y2);
    double cX = (2.0f * x0 - 5.0f * x1 + 4 * x2 - x3);
    double cY = (2.0f * y0 - 5.0f * y1 + 4 * y2 - y3);
    double dX = (-x0 + 3.0f * x1 - 3.0f * x2 + x3);
    double dY = (-y0 + 3.0f * y1 - 3.0f * y2 + y3);

    for (int i=0; i <= n; ++i) {
      double t = (double)i / (double)n;
      double t2 = t * t;
      double t3 = t2 * t;
      double x = 0.5f * (aX + bX * t + cX * t2 + dX * t3);
      double y = 0.5f * (aY + bY * t + cY * t2 + dY * t3);
      params[i*2] = (float)x;
      params[i*2+1] = (float)y;
    }
    
    countVertex = params.length/2;
    updateBounds();
  }
}