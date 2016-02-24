class Text extends Shape {

  String str;
  Font font;

  Text(String _str, float a, float b) {
    params = new float[] {a,b};
    bounds = new Bounds(a,b-20,a+20,b+20);
    maxVertex = countVertex = params.length/2;
    str = _str;
  }
  
  void draw() {
    preDraw();
    if (font!=null)
      font.draw();
    text(str,params[0],height-params[1]);
    postDraw();
  }
}