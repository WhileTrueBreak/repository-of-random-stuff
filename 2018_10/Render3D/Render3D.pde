boolean view3d = true;

game g;

void setup(){
  size(1000,1000);
  g = new game();
}

void draw(){
  background(0);
  g.update();
  g.render();
  
  fill(255,0,0);
  text(frameRate, width-100, 20);
}