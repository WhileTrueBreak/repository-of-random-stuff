class Grid{
  
  int[][] grid;
  
  Grid(int w, int h){
    grid = new int[h][w];
    for(int i = 0;i < grid.length;i++){
      for(int j = 0;j < grid[i].length;j++){
        if(random(1) < 0.4){
          grid[i][j] = 100;
        }else{
          grid[i][j] = 1;
        }
      }
    }
  }
  
  public void render(){
    for(int i = 0;i < grid.length;i++){
      for(int j = 0;j < grid[i].length;j++){
        if(grid[i][j] == 100){
          fill(0);
        }else{
          fill(255);
        }
        rect(j*10,i*10,10,10);
      }
    }
  }
  
  public int getValue(int x, int y){
    return grid[y][x];
  }
  
  public int[][] getGrid(){
    return grid;
  }
  
}

public PVector[] getPath(PVector start, PVector end, Grid grid){
  ArrayList<PVector> path = new ArrayList();
  ArrayList<PVector> to_be_checked = new ArrayList();
  int[][] path_grid = new int[grid.getGrid().length][grid.getGrid()[0].length];
  for(int i = 0;i < grid.getGrid().length;i++){
    for(int j = 0;j < grid.getGrid().length;j++){
      path_grid[i][j] = grid.getGrid()[i][j];
    }
  }
  
  //setup the path grid
  for(int i = 0;i < path_grid.length;i++){
    for(int j = 0;j < path_grid[i].length;j++){
      path_grid[i][j] = -1;
    }
  }
  //starts the first check
  PVector current_checking = start;
  path_grid[int(current_checking.y)][int(current_checking.x)] = 0;
  //marker
  while(true){
    //marking surrounding grid points for checking
    for(int i = -1;i <= 1;i++){
      for(int j = -1;j <= 1;j++){
        int sX = int(current_checking.x) +j;
        int sY = int(current_checking.y) +i;
        if(sX >= 0 && sX < path_grid[0].length && sY >= 0 && sY < path_grid.length && !(i == 0 && j == 0) && path_grid[sY][sX] == -1 && grid.getValue(sX, sY) != 0){
          path_grid[sY][sX] = -2;
          to_be_checked.add(new PVector(sX, sY));
        }
      }
    }
    //finds the next point to next check
    float shortest_dist = 10000000;
    PVector best = null;
    for(PVector vector:to_be_checked){
      //println(grid.getValue(int(current_checking.x),int(current_checking.y)));
      float avg_dis = (grid.getValue(int(vector.x),int(vector.y))+grid.getValue(int(current_checking.x),int(current_checking.y)))/2;
      float dist_end = dist(vector.x,vector.y,end.x,end.y);
      if(avg_dis+dist_end < shortest_dist && grid.getValue(int(vector.x),int(vector.y)) != 0){
        shortest_dist = avg_dis+dist_end;
        best = vector;
      }
    }
    if(best == null){
      return null;
    }
    
    to_be_checked.remove(best);
    //
    int lowest = 10000000;
    for(int i = -1;i <= 1;i++){
      for(int j = -1;j <= 1;j++){
        int sX = int(best.x) +j;
        int sY = int(best.y) +i;
        if(sX >= 0 && sX < path_grid[0].length && sY >= 0 && sY < path_grid.length){
          if(path_grid[sY][sX] >= 0 && path_grid[sY][sX] < lowest){
            lowest = path_grid[sY][sX];
          }
        }
      }
    }
    path_grid[int(best.y)][int(best.x)] = lowest +1;
    if(int(best.x) == int(end.x) && int(best.y) == int(end.y)){
      break;
    }
    current_checking = best;
  }
  //goto marker
  
  //ascii path map
  for(int i = 0;i < path_grid.length;i++){
    for(int j = 0;j < path_grid[i].length;j++){
      print(path_grid[i][j]);
      print(" ");
    }
    println("");
  }
  
  current_checking = start;
  path.add(current_checking);
  
  while(true){
    
    int highest = path_grid[int(current_checking.y)][int(current_checking.x)];
    PVector point = null;
    for(int i = -1;i <= 1;i++){
      for(int j = -1;j <= 1;j++){
        int sX = int(current_checking.x) +j;
        int sY = int(current_checking.y) +i;
        if(sX >= 0 && sX < path_grid[0].length && sY >= 0 && sY < path_grid.length){
          if(path_grid[sY][sX] > highest){
            highest = path_grid[sY][sX];
            point = new PVector(sX, sY);
          }
        }
      }
    }
    
    if(point == null){
      break;
    }
    
    path.add(point);
    current_checking = point;
  }
  
  PVector[] path_ = new PVector[path.size()];
  
  for(int i = 0;i < path_.length;i++){
    path_[i] = path.get(i);
  }
  
  return path_;
}