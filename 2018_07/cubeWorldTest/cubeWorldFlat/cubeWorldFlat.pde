ArrayList<tile> tiles = new ArrayList();
PVector center = new PVector(0,0,0);

void setup(){
  size(700,700,P3D);
  for(int i = 0;i < 100;i++){
    for(int j = 0;j < 100;j++){
      tiles.add(new tile(new PVector(width/2+i*10-500,height/2+50,j*10-500),new PVector(10,10,10)));
    }
  }
}

void draw(){
  background(100);
  ellipse(width/2,height/2,10,10);
  for(tile part:tiles){
    part.display(new PVector(-45,0,0),center);
  }
  if(up){
    center.add(new PVector(0,0,-1));
  }
  if(down){
    center.add(new PVector(0,0,1));
  }
  if(left){
    center.add(new PVector(-1,0,0));
  }
  if(right){
    center.add(new PVector(1,0,0));
  }
}