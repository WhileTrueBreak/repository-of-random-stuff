
simulation s;

void setup(){
  size(1000,1000);
  s = new simulation();
  s.lineM.addBarrier(new barrier(new PVector(0,0), new PVector(0,height)));
  s.lineM.addBarrier(new barrier(new PVector(0,height), new PVector(width,height)));
  s.lineM.addBarrier(new barrier(new PVector(width,height), new PVector(width,0)));
  s.lineM.addBarrier(new barrier(new PVector(width,0), new PVector(0,0)));
  //s.lineM.addBarrier(new barrier(new PVector(700,400), new PVector(700,800)));
  s.lineM.addBarrier(new barrier(new PVector(400,700), new PVector(700,400)));
  s.lineM.addBarrier(new barrier(new PVector(700,400), new PVector(400,700)));
}

void draw(){
  background(0);
  s.update();
  s.render();
}

void mouseReleased(){
  s.ballM.addBall(new ball(new PVector(mouseX,mouseY), random(10,30), s.h));
}