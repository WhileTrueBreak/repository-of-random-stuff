class board{
  int[][] tiles;
  board(int w, int h){
    tiles = new int[w][h];
  }
  void update(){
    
  }
  void display(){
    for(int i = 0;i < tiles.length;i++){
      for(int j = 0;j < tiles[i].length;j++){
        if(tiles[i][j] == 0){
          fill(205,193,180);
        }else{
          fill(244,200,66);
          fill(255,255/(log(tiles[i][j])/log(2)));
        }
        strokeWeight(5);
        stroke(255);
        rect(i*mult,j*mult,mult,mult,6);
      }
    }
    
  }
  void addRtile(){
    boolean foundTile = false;
    while(!foundTile){
      int rIndexX = floor(random(4));
      int rIndexY = floor(random(4));
      int value = 4;
      if(random(1)<0.9){
        value = 2;
      }
      if(tiles[rIndexX][rIndexY] == 0){
        tiles[rIndexX][rIndexY] = value;
      }
    }
  }
  void checkMove(){
    if(up){
      
    }
    if(down){
      
    }
    if(left){
      
    }
    if(right){
      
    }
  }
}