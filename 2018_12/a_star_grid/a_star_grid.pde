Grid grid = new Grid(40,40);

public void setup(){
  size(400,400);
  grid.render();
  PVector[] path = getPath(new PVector(0,0),new PVector(39,20),grid);
  for(PVector vector:path){
    fill(0,255,255,100);
    noStroke();
    rect(vector.x*10,vector.y*10,10,10);
  }
}