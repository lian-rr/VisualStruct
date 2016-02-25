/* @pjs preload="cantones.bna"; */
View view;

void setup() {
  size(640, 480); 
  view = new View(100, 100, 320, 240);
  Layer layer = new Layer();
  layer.style = new Style(#FF0000, #00FF00, 1);
  layer.loadBNA("cantones.bna");
  view.addItem(layer);
  print(layer.bounds.xMin+" "+layer.bounds.yMin+" "+layer.bounds.xMax+" "+layer.bounds.yMax);
  view.zoomToFullExtent();
}

void draw() {
  background(220);
  view.draw();
}

void mouseDragged() {
  view.translateCenter(pmouseX-mouseX, pmouseY-mouseY);
}

void mouseMoved() {
  if (keyPressed&&(key == CODED)&&(keyCode == SHIFT)) {
    view.zoomToScale(pmouseX*1.0/mouseX);
  }
}