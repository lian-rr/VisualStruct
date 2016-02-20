class Group extends Graphic {

  private ArrayList children;
  Font font;
  
  Group() {
    children = new ArrayList();
  }
  
  void addItem(Graphic g) {
    children.add(g);
    g.parent = this;
  }
  
  void empty() {
    children.clear();
  }
  
  void draw() {
    preDraw();
    if (font!=null)
      font.draw();
    for (int i=0; i<children.size();i++)
      ((Graphic)children.get(i)).draw();
    postDraw();
  }
}