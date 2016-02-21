View map;
  
void setup() {
  size(640, 480);
  map = new View(0,0,640,480);
  Layer layer = new Layer();
  layer.style = new Style(#FF0000,#00FF00,1);
  map.addItem(layer);
  layer.loadBNA("cantones.bna");
  map.zoomToFullExtent();
}

void draw() {
  background(255);
  map.draw();
}

void keyPressed() {
  map.keyPressed();
}

void mouseDragged() {
  map.translateCenter(pmouseX-mouseX,pmouseY-mouseY);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e<0) 
    map.zoomToScale(0.9);
  else
    map.zoomToScale(1.1);
}