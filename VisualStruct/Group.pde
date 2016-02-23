class Group extends Graphic {

  private ArrayList children;
  Font font;
  
  Group() {
    children = new ArrayList();
  }
  
  void addItem(Graphic g) {
    children.add(g);
    g.parent = this;
    if (g.bounds!=null) {
      if (bounds==null)
        bounds = new Bounds(g.bounds);
      else
        updateBounds(g.bounds);
    }
  }
  
  void empty() {
    children.clear();
  }
  
  void draw() {
    if (!visible) return;
    preDraw();
    if (font!=null)
      font.draw();
    for (int i=0; i<children.size();i++)
      ((Graphic)children.get(i)).draw();
    postDraw();
  }
  
  void execute(Callback call) {
    super.execute(call);
    for (int i=0; i<children.size();i++)
      ((Graphic)children.get(i)).execute(call);
  }
}