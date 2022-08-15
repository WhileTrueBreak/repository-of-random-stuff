float scale = 80;
float speed = 10;

PVector playerWorldCords = new PVector(0,0);

player p = new player(new PVector(0,0));
terrain t = new terrain(100,100);

void setup(){
  //fullScreen();
  size(1000,1000);
  t.createLayers();
}

void draw(){
  background(200);
  t.update();
  t.display1();
  ////////////////////////////
  p.move();
  p.update();
  p.display();
  ////////////////////////////
  t.display2();
  ////////////////////////////
  fill(255,0,0);
  textSize(10);
  text(frameRate,width-50,10);
}