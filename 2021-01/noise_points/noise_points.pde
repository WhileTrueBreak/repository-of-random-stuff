
float chance = 0;
float valImpact = 0.001;

float gridSpan = 1;
float off = 0.01;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(800,800);
  noStroke();
  noiseDetail(1);
  for(int i = 0;i < width;i+=gridSpan){
    for(int j = 0;j < height;j+=gridSpan){
      float val = noise(i*off,j*off);
      if(val<0.2||val>0.25)val=0;
      if(Math.random()<chance+val*valImpact){
        fill(255);
      }else{
        fill(0);
      }
      rect(i, j, gridSpan, gridSpan);
    }
  }
}

void draw() {
  
}