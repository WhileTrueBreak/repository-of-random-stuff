class Grid{
  
  GoL gol;
  
  boolean[][][] grid;
  
  Grid(int w, int h, int d){
    gol = new GoL(w,h);
    grid = new boolean[d][h][w];
  }
  
  void render(){
    for(int d = 0;d < grid.length;d++){
      for(int h = 0;h < grid[d].length;h++){
        for(int w = 0;w < grid[d][h].length;w++){
          if(grid[d][h][w]){
            pushMatrix();
            stroke(100);
            fill(0);
            translate(w*10,h*10,d*10);
            box(10,10,10);
            popMatrix();
          }
        }
      }
    }
  }
  
  void update(){
    if(frameCount % 10 == 0){
      for(int d = grid.length-2;d >= 0;d--){
        for(int h = 0;h < grid[d].length;h++){
          for(int w = 0;w < grid[d][h].length;w++){
            grid[d+1][h][w] = grid[d][h][w];
          }
        }
      }
      gol.update();
      grid[0] = gol.getGrid();
    }  
  }
}