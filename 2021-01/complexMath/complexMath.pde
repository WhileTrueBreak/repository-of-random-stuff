import peasy.*;

PeasyCam cam;

void setup(){
  fullScreen(P3D);
  cam = new PeasyCam(this, 100);
  cam.setYawRotationMode();
  cam.lookAt(0, 0, 0);
  cam.rotateX(PI/6);
  frameRate(60);
}

void draw(){
  background(0);
  stroke(0,0,255);
  line(0, 0, 0, 0, 0, 100);
  stroke(0,255,0);
  line(0, 0, 0, 0, -100, 0);
  stroke(255,0,0);
  line(0, 0, 0, 100, 0, 0);
  for(float i = -20;i<20;i+=0.02){
    ComplexNumber[] cNums = cplx_sqrt(sin(i), 0);
    for(ComplexNumber cNum:cNums){
      println(cNum.toString());
      stroke(255);
      point(i,-cNum.getRe(),cNum.getIm());
    }
  }
}

ComplexNumber[] cplx_sqrt(float x,float y){
  ArrayList<Float> aa = new ArrayList();
  if((x+sqrt(y*y+x*x))/2>0){
    aa.add(sqrt((x+sqrt(y*y+x*x))/2));
    aa.add(-sqrt((x+sqrt(y*y+x*x))/2));
  }
  if((x-sqrt(y*y+x*x))/2>0){
    aa.add(sqrt((x-sqrt(y*y+x*x))/2));
    aa.add(-sqrt((x-sqrt(y*y+x*x))/2));
  }
  float[]a = new float[aa.size()];
  for(int i = 0;i < aa.size();i++){
    a[i] = aa.get(i);
  }
  float[]b = new float[a.length];
  for(int i = 0;i < b.length;i++){
    b[i] = y/(2*a[i]);
  }
  ComplexNumber[] sols = new ComplexNumber[a.length];
  for(int i = 0;i < sols.length;i++){
    sols[i] = new ComplexNumber(a[i],b[i]);
  }
  return sols;
}

ComplexNumber[] cplx_f(float x){
  ComplexNumber[] ns1 = cplx_sqrt(sin(x),cos(x));
  for(ComplexNumber n:ns1){
    n.multiNum(cos(x),0);
    n.multiNum(40,0);
  }
  return ns1;
}