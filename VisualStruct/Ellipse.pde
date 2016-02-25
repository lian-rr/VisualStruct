class Ellipse extends Shape {

  Ellipse(float x, float y, float a, float b) {
    this(x, y, a, b, CENTER);
  }

  Ellipse(float x, float y, float a, float b, int m) {
    this(x, y, a, b, m, 90);
  }

  Ellipse(float x, float y, float a, float b, int m, int n) {
    switch (m) {
    case CORNERS:
      _Ellipse ((x+a)/2, (y+b)/2, a-x, b-y, n);
      break;
    case CENTER:
      _Ellipse (x, y, a, b, n);
      break;
    case RADIUS:
      _Ellipse (x, y, a*2, b*2, n);
      break;
    case CORNER:
      _Ellipse (x+a/2, y+b/2, a, b, n);
      break;
    }
  }

  void _Ellipse(float cx, float cy, float w, float h, int n) {
    params = new float[n*2];
    int parts = n;
    int t;
    for (t = 0; t < parts; t++) {
      float theta = 2.0f * 3.1415926f * t / parts;
      double x = cx + w / 2 * Math.cos(theta);
      double y = cy + h / 2 * Math.sin(theta);
      params[t*2] = (float)(x);
      params[t*2+1] = (float)(y);
    }
    countVertex = params.length/2;
    createBounds();
  }
}