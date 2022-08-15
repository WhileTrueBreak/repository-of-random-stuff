class Tile{
  
  int building;
  int tile;
  
  Tile(){
    tile = (int)random(0, 3);
  }
  
  void update(){
    
  }
  
  void render(int x, int y){
    noStroke();
    switch(tile){
      case 0:
      fill(167,255,25);
      break;
      case 1:
      fill(203,245,66);
      break;
      case 2:
      fill(231,255,153);
      break;
      default:
      fill(255);
    }
    rect(x,y,GRID_SIZE,GRID_SIZE);
  }
  
}