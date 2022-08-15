float xr=90;
float yr=0;

PVector grav = new PVector(0,0,-0.1);

ArrayList<torch>torchs = new ArrayList();

void setup(){
  frameRate(20);
  size(900,600,P3D);
  for(int i = 0;i < 30;i++){
    torchs.add(new torch(new PVector(i*15+100,height/2,200)));
  }
}

void draw(){
  background(255);
  for(torch c:torchs){
    c.update();
    c.display(new PVector(radians(xr),0,radians(yr)),new PVector(width/2, height/2+100, 100));
    //c.pos.z+=0.25;
  }
  if(up){
    xr--;
  }
  if(down){
    xr++;
  }
  if(left){
    yr--;
  }
  if(right){
    yr++;
  }
}