
void setup(){
  noStroke();
  size(1200, 1200);
  colorMode(HSB);
  int step=1;
  float threshhold = 0.01;
  
  int maxI = 200;
  for(int i = 0;i < width;i+=step){
    for(int j = 0;j < height;j+=step){
      Complex c = new Complex(map(i,0,width,-2,2),map(j,0,height,-2,2));
      Complex x = new Complex(0, 0);
      int k = 0;
      while(k<maxI){
        x = x.mult(x);
        x.real+=c.real;
        x.img+=c.img;
        
        //x.real=x.real-x.real%threshhold;
        //x.img=x.img-x.img%threshhold;
        if(k!=0&&(x.real+threshhold>=c.real&&x.real<=c.real+threshhold)&&(x.img<=c.img+threshhold&&x.img+threshhold>=c.img)) break;
        k++;
      }
      fill(k*10,255,255-k*255/maxI);
      rect(i, j, step, step);
    }
  }
}

void draw(){
  
}
