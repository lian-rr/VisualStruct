class Text extends Graphic {

  String str;
  Font font;

  Text(String _str, float x, float y) {
    params = new float[] {x, y};
    str = _str;
    bounds = new Bounds(x,y,x+5,y+5);
  }
  
  void draw() {
    preDraw();
    if (font!=null)
      font.draw();
    text(str,params[0],height-params[1]);
    postDraw();
  }
}