
terrain t = new terrain(50,50,20,20,0.05,400,1);

void setup(){
  fullScreen();
}

void draw(){
  background(255);
  t.update();
  t.display(width/2,height/2+100);
}
