int dx = 50;
int dy = 50;

ArrayList<tile>tiles = new ArrayList();
PVector centerOfAttention = new PVector(0,0,dy*5);

void setup(){
  smooth();
  size(500,500,P3D);
  for(int x = 0;x < dx;x++){
    for(int z = 0;z < dy;z++){
      tiles.add(new tile(new PVector(x*10,height/2,z*10)));
    }
  }
}

void draw(){
  background(100);
  ellipse(width/2,height/2,10,10);
  for(tile part:tiles){
    part.display();
  }
}