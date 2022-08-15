player p;

void setup(){
  size(900,600,P3D);
  p = new player(new PVector(width/2,height/2-100,100),new PVector(10,10,10));
}

void draw(){
  background(0);
  p.move();
  p.update();
  p.display(new PVector(-45,0,0),new PVector(width/2,height/2-100,100));
}