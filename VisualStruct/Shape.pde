abstract class Shape extends Graphic {

  protected float[] params;
  protected int maxVertex = 20;
  protected int countVertex = 0;
  protected int modeShape = CLOSE;

  void draw() {
    if (!visible) return;
    preDraw();
    beginShape();
    for (int i=0; i<countVertex; i++)
      vertex(params[i*2], height-params[i*2+1]);
    endShape(modeShape);
    postDraw();
  }

  void createBounds() {
    for (int i=0; i<countVertex; i++) {
      if (bounds==null)
        bounds = new Bounds(params[i], params[i*2], params[i], params[i*2]);
      else
        bounds.include(params[i], params[i*2]);
    }
  }
  
  void expand(int n) {
    maxVertex = n;
    float[] temp = new float[maxVertex*2];
    for (int i=0; i<countVertex*2; i++)
      temp[i] = params[i];
    // free(params);
    params = temp;
  }

  boolean contains(float x, float y) {
    return (bounds.contains(x, y)&&pointInPolygon(x, y));
  }

  boolean pointInPolygon(float x, float y) {
    int i, j, n = countVertex;
    boolean c = false;

    for (i = 0, j = n - 1; i < n; j = i++) {
      if ( ( (params[i*2+1] > y ) != (params[j*2+1] > y) ) &&
        (x < (params[j*2] - params[i*2]) * (y - params[i*2+1]) / 
        (params[j*2+1] - params[i*2+1]) + params[i*2])
        )
        c = !c;
    }
    return c;
  }

  double distancePointLine(float x, float y, float x1, float y1, float x2, float y2) {
    float A = x - x1; float B = y - y1;
    float C = x2 - x1; float D = y2 - y1;

    float dot = A * C + B * D;
    float len_sq = C * C + D * D;
    float param = -1;
    if (len_sq != 0)
      param = dot / len_sq;

    float xx, yy;

    if (param < 0) {
      xx = x1; yy = y1;
    } else if (param > 1) {
      xx = x2; yy = y2;
    } else {
      xx = x1 + param * C;
      yy = y1 + param * D;
    }

    float dx = x - xx;
    float dy = y - yy;
    return Math.sqrt(dx * dx + dy * dy);
  }
  
  double distancePointPath(float x,  float y) {
    int n = countVertex;

    float distance=MAX_FLOAT;
    float temp;

    for (int i=0; i<n-1; i++) {
      temp = (float)distancePointLine(x, y, 
        params[i*2], params[i*2+1], 
        params[i*2+2], params[i*2+3]);
      if (distance > temp)
        distance = temp;
    }
    return distance;
  }
}