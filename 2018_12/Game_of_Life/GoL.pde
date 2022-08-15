class GoL{
  
  boolean[][] grid;
  
  GoL(int w, int h){
    grid = new boolean[h][w];
    
    //for(int i = 0;i < grid.length;i++){
    //  for(int j = 0;j < grid[i].length;j++){
    //    if(random(1) < 0.2){
    //      grid[i][j] = true;
    //    }else{
    //      grid[i][j] = false;
    //    }
    //  }
    //}
    
    grid[4][0] = true;
    grid[4][1] = true;
    grid[5][0] = true;
    grid[5][1] = true;
    
    grid[2][34] = true;
    grid[2][35] = true;
    grid[3][34] = true;
    grid[3][35] = true;
    
    grid[4][10] = true;
    grid[5][10] = true;
    grid[6][10] = true;
    grid[3][11] = true;
    grid[7][11] = true;
    grid[2][12] = true;
    grid[8][12] = true;
    grid[2][13] = true;
    grid[8][13] = true;
    grid[5][14] = true;
    grid[3][15] = true;
    grid[7][15] = true;
    grid[4][16] = true;
    grid[5][16] = true;
    grid[6][16] = true;
    grid[5][17] = true;
    
    grid[2][20] = true;
    grid[3][20] = true;
    grid[4][20] = true;
    grid[2][21] = true;
    grid[3][21] = true;
    grid[4][21] = true;
    grid[1][22] = true;
    grid[5][22] = true;
    grid[0][24] = true;
    grid[1][24] = true;
    grid[5][24] = true;
    grid[6][24] = true;
    
  }
  
  void render(){
    for(int i = 0;i < grid.length;i++){
      for(int j = 0;j < grid[i].length;j++){
        float xScl = width/grid[i].length;
        float yScl = height/grid.length;
        if(grid[i][j]){
          fill(0);
        }else{
          fill(255);
        }
        rect(j*xScl,i*yScl,xScl,yScl);
      }
    }
  }
  
  void update(){
    int[][] nGrid = new int[grid.length][grid[0].length];
    for(int i = 0;i < grid.length;i++){
      for(int j = 0;j < grid[i].length;j++){
        int num = 0;
        for(int x = -1;x < 2;x++){
          for(int y = -1;y < 2;y++){
            int sX = x+j;
            int sY = y+i;
            if(sX >= 0 && sX < grid[i].length && sY >= 0 && sY < grid.length){
              if(grid[sY][sX]){
                if(x != 0 || y != 0){
                  num++;
                }
              }
            }
          }
        }
        nGrid[i][j] = num;
      }
    }
    boolean[][] tGrid = new boolean[grid.length][grid[0].length];
    tGrid = grid;
    //rules
    for(int i = 0;i < nGrid.length;i++){
      for(int j = 0;j < nGrid[i].length;j++){
        int n = nGrid[i][j];
        if((n == 0||n == 1)&&grid[i][j] == true){
          tGrid[i][j] = false;
        }
        if((n == 2||n == 3)&&grid[i][j] == true){
          tGrid[i][j] = true;
        }
        if((n > 3)&&grid[i][j] == true){
          tGrid[i][j] = false;
        }
        if((n == 3)&&grid[i][j] == false){
          tGrid[i][j] = true;
        }
      }
    }
    //end
    grid = tGrid;
  }
  
  boolean[][] getGrid(){
    return grid;
  }
  
}