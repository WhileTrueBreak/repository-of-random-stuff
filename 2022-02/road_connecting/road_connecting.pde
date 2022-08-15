
Map map;

int x = 800;
int y = 800;

void setup(){
  
  randomSeed(10);
  noiseSeed(10);
  size(800,800);
  noStroke();
  map = new Map(x,y);
  map.addTown((int)(x/2), (int)(y/2));
  for(int i = 0;i < 10;i++){
    map.addTown((int)random(x), (int)random(y));
  }
  map.connectTowns();
  map.render();
}

void draw(){
  
}
