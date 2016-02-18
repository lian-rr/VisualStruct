Layer layer;
float factor = 1;
  
void setup() {
  size(320, 280);
  layer = new Layer();
  layer.loadBNA("cantones.bna");
  layer.transform = new Transform();
  zoom(1);
}

void draw() {
  background(255); // Processing function
  layer.draw();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e<0) 
    factor *= 0.9;
  else
    factor *= 1.1;
  zoom(factor);
}

void zoom(float factor) {
  layer.transform.reset();
  layer.transform.translation(width/2,height/2);
  layer.transform.scalation(factor,factor);
  layer.transform.translation(-(layer.bounds.xMin+layer.bounds.width()/2), 
                              -(layer.bounds.yMin+layer.bounds.height()/2));
  layer.style.strokeWidth = 1/factor;
}