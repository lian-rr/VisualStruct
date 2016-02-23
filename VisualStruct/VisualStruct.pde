View view;

void setup() {
  size(320, 280);

  String[] names = new String[] {"Juan", "Pedro", "Pablo"};

  view = new View(10, 10, 300, 250);
  Group chart = new Group();

  RectAxis rect1 = new RectAxis(60, 50, 200, LEFT);
  rect1.items = names;
  rect1.update();
  chart.addItem(rect1);

  RectAxis rect2 = new RectAxis(60, 50, 200, BOTTOM);
  rect2.minValue = 0;
  rect2.maxValue = 100;
  rect2.update();
  chart.addItem(rect2);

  chart.bounds.print();
  view.addItem(chart);
  view.zoomToFullExtent();
}

void setup1() {
  size(640, 480);
  view = new View(100, 100, 320, 240);
  Layer layer = new Layer();
  layer.style = new Style(#FF0000, #00FF00, 1);
  layer.loadBNA("cantones.bna");
  print("layer: ");
  layer.bounds.print();
  view.addItem(layer);
  view.zoomToFullExtent();
}

void draw() {
  background(255);
  view.draw();
}

void keyPressed() {
  view.keyPressed(keyCode);
}

void mouseDragged() {
  view.translateCenter(pmouseX-mouseX, pmouseY-mouseY);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e<0) 
    view.zoomToScale(0.9);
  else
    view.zoomToScale(1.1);
}

void mouseClicked() {
  view.execute(new Callback () {
    public void run(Graphic g) {
      if (g.parent!=null&&g.parent.parent!=null)
      g.style=null;
    }
  }
  );
  view.pick(mouseX, height-mouseY, new Callback () {
    public void run(Graphic g) {
      if (g.contains(System.xCoord, System.yCoord)&&
        g.parent!=null&&g.parent.parent!=null) {
        g.style = new Style(#000000, #FF0000, 1);
        View view2 = (View)g.parent.parent;
        view2.zoomToExtent(g.bounds);
      }
    }
  }
  );
}