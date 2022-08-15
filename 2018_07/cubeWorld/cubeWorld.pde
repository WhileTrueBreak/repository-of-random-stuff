float xr=0;
float yr=0;

ArrayList<cube>cubes = new ArrayList();

void setup(){
  size(900,600,P3D);
  for(int x = 0;x < 100;x++){
    for(int y = 0;y < 100;y++){
      for(int z = 0;z < 100;z++){
        cubes.add(new cube(new PVector(width/2-100+x*2, height/2-100+y*2, z*2-100),new PVector(2,2,2)));
      }
    }
  }
}

void draw(){
  background(0);
  for(cube c:cubes){
    c.display(new PVector(radians(xr),radians(yr),0),new PVector(width/2, height/2, 0));
  }
  if(up){
    xr--;
  }
  if(down){
    xr++;
  }
  if(left){
    yr++;
  }
  if(right){
    yr--;
  }
}