class GoL{
  
  boolean[][] grid;
  
  GoL(int w, int h){
    grid = new boolean[w+2][h+2];
  }
  
  void update(){
    
  }
  
  void render(){
    for(int i = 0;i < grid.length;i++){
      for(int j = 0;j < grid[i].length;j++){
        if(grid[i][j]){
          fill(0);
        }else{
          fill(255);
        }
        rect(10*i,10*j,10,10);
      }
    }
  }
  
  boolean[][] getGrid(){
    return grid;
  }
  
}