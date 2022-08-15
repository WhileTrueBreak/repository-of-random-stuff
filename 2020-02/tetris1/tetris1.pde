
Grid grid;

void setup(){
  size(300, 720);
  grid = new Grid(10, 24);
}

void draw(){
  background(0);
  grid.render();
}