final int GRID_SIZE = 10;

World world;

void setup(){
  size(800,800);
  world = new World(width/GRID_SIZE,height/GRID_SIZE);
  world.createMap();
}

void draw(){
  background(0);
  world.render();
}