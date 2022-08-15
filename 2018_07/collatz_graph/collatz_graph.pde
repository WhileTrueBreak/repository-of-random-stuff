int index = 1;
int starter = 10;
ArrayList<PVector> indexes = new ArrayList();
float scale = 1;
int[] values = new int[200];

float scl;
float scl2;

PVector moveXY = new PVector(0,0);

void setup() {
  size(1000,1000);
  for(int i = 0;i < values.length;i++){
    if(i % 2 == 0){
      values[i] = i/2;
    }else{
      values[i] = i*3+1;
    }                                                                                                                
  }
  println(values);
  scl = width/values.length*scale;
  scl2 = scl/3*scale;
  while(index != 1){
    for(int i = 0;i < values.length;i++){
      if(values[i] % 2 == 0){
        //if()
      }else{
        
      }
    }
  }
}
void draw() {
  background(255);
  scl = width/values.length*scale;
  scl2 = scl/3*scale;
  for(int i = 0;i < values.length;i++){
    strokeWeight(5);
    fill(255,0,0);
    if(log(values[i])/log(2) - round(log(values[i])/log(2)) == 0){
      fill(0,0,255);
    }
    text(values[i],i*scl+moveXY.x,height-values[i]*scl2+moveXY.y);
    point(i*scl+moveXY.x,height-values[i]*scl2+moveXY.y);
  }
  for(int i = 0;i < values.length;i++){
    strokeWeight(1);
    stroke(100);
    if(values[i] % 2 == 0){
      line(i*scl+moveXY.x,height-values[i]*scl2+moveXY.y,values[i]*scl+moveXY.x,height-values[i]/2*scl2+moveXY.y);
    }else{
      line(i*scl+moveXY.x,height-values[i]*scl2+moveXY.y,values[i]*scl+moveXY.x,height-(values[i]*3+1)*scl2+moveXY.y);
    }
  }
  
  //scale+=0.001;
}