int override = 0;
int scl = 10;
int temp;
int limit = 300000;
ArrayList<PVector> values = new ArrayList();
ArrayList<PVector> values1 = new ArrayList();
void setup(){
  size(1000,200);
  for(int i = 1;i <= limit;i++){
    temp = i;
    while(log(temp)/log(2) - round(log(temp)/log(2)) != 0){
      if(temp % 2 == 0){
        temp = temp/2;
      }else{
        temp = temp*3+1;
      }
      if(override >= 107){
        temp = 1;
        values1.add(new PVector(i,temp));
        override = 0;
      }
      override++;
    }
    override = 0;
    values.add(new PVector(i,temp));
  }
  noStroke();
  for(PVector point:values){
    fill(255);
    ellipse(log(point.x*scl)/log(10)*1000/(log(limit)/log(10)+1),height-(log(point.y)/log(2))*scl,scl,scl);
  }
  for(PVector point:values1){
    fill(255,0,0);
    ellipse(log(point.x*scl)/log(10)*1000/(log(limit)/log(10)+1),height-(log(point.y)/log(2))*scl,scl,scl);
  }
}