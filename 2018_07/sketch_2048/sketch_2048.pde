board b = new board(4,4);

int mult = 100;

void setup(){
  size(400,400);
  b.addRtile();
  b.addRtile();
}

void draw(){
  background(255);
  b.update();
  b.display();
  b.checkMove();
  up = false;
  down = false;
  left = false;
  right = false;
}