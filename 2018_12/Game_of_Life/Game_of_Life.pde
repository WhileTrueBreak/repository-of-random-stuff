
GoL gol = new GoL(80,80);

void setup(){
  size(400,400);
  frameRate(10);
}

void draw(){
  gol.update();
  gol.render();
}