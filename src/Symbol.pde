class Symbol {
  float[] vertices;
  int mode;
  
  Symbol() {
    vertices = new float[] {-0.5,0.5,0.5,0.5,0.5,-0.5,-0.5,-0.5};
  }
  
  Symbol(float[] v, int m) {
    vertices=v; mode=m;
  }
}

Symbol newSymbol() {
  return new Symbol();
}