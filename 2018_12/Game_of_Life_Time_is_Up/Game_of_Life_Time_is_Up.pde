import peasy.*;
PeasyCam cam;

Grid grid = new Grid(80,80,20);

void setup(){
  //size(800,800,P3D);
  fullScreen(P3D);
  cam = new PeasyCam(this, 100);
  frameRate(60);
}

void draw(){
  background(255);
  grid.update();
  grid.render();
}