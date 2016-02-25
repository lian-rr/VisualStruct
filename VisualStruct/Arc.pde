class Arc extends Shape {
  
  //static final int PIE;
  //static final int CHORD;

  Arc(float x, float y, float w, float h, float s, float e) {
    this(x, y, w, h, s, e, PIE);
  }

  Arc(float cx, float cy, float w, float h, float s, float e, int m) {
    this(cx, cy, w, h, s, e, m, 90);
  }
    
  Arc(float cx, float cy, float w, float h, float start, float end, int mode, int n) {
    params = new float[n*2];
    int parts = n;
    float part = 2.0f * 3.1415926f / parts;
    int t=0;

    if (mode==PIE) {
      params[t*2] = cx;
      params[t*2+1] = cy;
      t++;
    }

    for (float theta = start; theta < end; theta+=part, t++) {
      double x = w / 2 * Math.cos(theta);
      double y = h / 2 * Math.sin(theta);
      params[t*2] = (float)(x + cx);
      params[t*2+1] = (float)(y + cy);
    }
    countVertex = t;
    if (mode==CHORD||mode==PIE)
      modeShape = CLOSE;
    else
      modeShape = OPEN;
    createBounds();
  }
}