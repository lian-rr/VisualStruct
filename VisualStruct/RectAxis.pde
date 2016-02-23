class RectAxis extends Group {

  int x = 0;
  int y = 0;

  int extent = 100;
  int position = BOTTOM;

  float minValue=0;
  float maxValue=10;

  int tickInc = 20;
  int tickLen = 10;

  int tickWidth = 1;
  int tickColor = 0;

  boolean tickEnable = true;
  boolean labelEnable = true;

  int labelColor = 0;
  int labelSize = 10;

  String[] items;

  Group ticks = new Group();
  Group labels = new Group();
  Shape baseline ;

  RectAxis(int _x, int _y, int _extent, int _position) {
    x = _x; 
    y = _y; 
    extent = _extent; 
    position = _position;
  }

  void update() {
    if (position == BOTTOM)
      baseline = new Line(x, y, x+extent, y);
    else if (position == LEFT)
      baseline = new Line(x, y, x, y+extent);
    if (tickEnable&&items!=null)
      makeTicksCat();
    if (tickEnable&&items==null)
      makeTicksNum();
    if (labelEnable&&items!=null)
      makeLabelsCat();
    if (labelEnable&&items==null)
      makeLabelsNum();
    addItem(ticks);
    addItem(labels);
    addItem(baseline);
  }

  void makeTicksNum() {

    //ticks = new Group();
    ticks.style = new Style(tickColor, 0, tickWidth);

    int axisMode = 1;
    if (position == LEFT)
      axisMode = -1;

    for (float v=minValue; v<=maxValue; v+=tickInc) {
      int pos = (int)map(v, minValue, maxValue, 0, extent);
      if (position == BOTTOM)
        ticks.addItem(new Line(x+pos, y, x+pos, y-tickLen*axisMode));
      else
        ticks.addItem(new Line(x, y+pos, x+tickLen*axisMode, y+pos));
    }
  }

  void makeTicksCat() {
    //ticks = new Group();
    ticks.style = new Style(tickColor, 0, tickWidth);

    int axisMode = 1;
    if (position == LEFT)
      axisMode = -1;

    int inc = int(extent/items.length);

    for (int pos=0; pos<=extent; pos+=inc) {
      if (position == BOTTOM)
        ticks.addItem(new Line(x+pos, y, x+pos, y-tickLen*axisMode));
      else
        ticks.addItem(new Line(x, y+pos, x+tickLen*axisMode, y+pos));
    }
  }

  void makeLabelsNum() {

    //labels = new Group();
    labels.font = new Font(labelSize, null);
    labels.style = new Style(0, labelColor, 1);

    for (float v=minValue; v<=maxValue; v+=tickInc) {
      int pos = (int)map(v, minValue, maxValue, 0, extent);
      String label = str(v);
      int strWidth = (int)(label.length()*labelSize*0.7);
      if (position == BOTTOM)
        labels.addItem(new Text(label, x+pos-(tickInc/2), y-(tickLen+labelSize+5)));
      else
        labels.addItem(new Text(label, x-tickLen-strWidth, y+pos-5));
    }
  }

  void makeLabelsCat() {

    //labels = new Group();
    labels.font = new Font(labelSize, null);
    labels.style = new Style(0, labelColor, 1);

    int inc = int(extent/items.length);

    for (int pos=0, n=0; n<items.length; pos+=inc, n++) {
      String label = items[n];
      int strWidth = (int)(label.length()*labelSize*0.7);
      if (position == BOTTOM)
        labels.addItem(new Text(label, x+pos+(inc-strWidth)/2, y-(tickLen+labelSize+5)));
      else
        labels.addItem(new Text(label, x-tickLen-strWidth, y+pos+(inc/2)-5));
    }
  }
}