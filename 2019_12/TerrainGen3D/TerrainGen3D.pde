import peasy.*;
PeasyCam cam;

Map map;

void setup(){
  size(800,800,P3D);
  cam = new PeasyCam(this, 100);
  map = new Map(50,50,20);
  map.createMap();
}

void draw(){
  background(0);
  map.render();
}
