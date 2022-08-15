import peasy.*;
PeasyCam cam;

float xr=90;
float yr=0;

PVector grav = new PVector(0,0,-0.1);

ArrayList<torch>torchs = new ArrayList();

void setup(){
  frameRate(20);
  size(900,600,P3D);
  
  cam = new PeasyCam(this, 1000);
  for(int i = 0;i < 40;i++){
    torchs.add(new torch(new PVector(i*15,height/2,100)));
    //torchs.add(new torch(new PVector(random(-1500,1500),random(-1500,1500),100)));
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
  
  //
  
}