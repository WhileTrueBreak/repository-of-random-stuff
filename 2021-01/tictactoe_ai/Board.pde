class Board{
  
  int[] grid = {0,0,0,0,0,0,0,0,0};
  
  public Board(){
    
  }
  
  public int[] getGrid(){
    return grid;
  }
  
  public boolean play(int index, int side){
    if(grid[index] == 0){
      grid[index] = side;
      return true;
    }
    return false;
  }
  
}
