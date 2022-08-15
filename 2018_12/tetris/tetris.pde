float scl = 30;
int wBorder, hBorder;

block[][] grid;
block cBlock;

void setup(){
  cBlock = new block(5,0);
  size(300,600);
  frameRate(30);
  wBorder = round(width/scl)-1;
  hBorder = round(height/scl)-1;
  grid = new block[hBorder+2][wBorder+1];
}

void draw(){
  background(0);
  if(frameCount%2 == 0 && cBlock.indexY < hBorder && grid[cBlock.indexY+1][cBlock.indexX] == null){
    cBlock.moveDown();
  }else if(cBlock.indexY >= hBorder || grid[cBlock.indexY+1][cBlock.indexX] != null){
    grid[cBlock.indexY][cBlock.indexX] = cBlock;
    cBlock = new block(5,0);
  }
  cBlock.render();
  for(int i = 0;i < grid.length;i++){
    for(int j = 0;j < grid[i].length;j++){
      if(grid[i][j] != null){
        grid[i][j].render();
      }
    }
  }
}

void keyPressed(){
  if(keyCode == LEFT && grid[cBlock.indexY][cBlock.indexX-1] == null){
    cBlock.moveLeft();
  }
  if(keyCode == RIGHT && grid[cBlock.indexY][cBlock.indexX+1] == null){
    cBlock.moveRight();
  }
}