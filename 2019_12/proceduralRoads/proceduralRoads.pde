
public Map map;

void setup(){
  size(600, 600);
  map = new Map(600, 600);
  map.startCity(300, 300, 100);
}

void draw(){
  map.render();
  //println(frameRate);
}
