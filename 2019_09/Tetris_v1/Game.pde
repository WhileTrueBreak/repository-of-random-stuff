import java.util.*;

class Game{
  
  public boolean gameOver = false;
  
  private int[][] board;
  
  private ArrayList<PVector> currentPiece = new ArrayList<PVector>();
  
  public Game(){
    board = new int[10][20];
    for(int x = 0;x < board.length;x++){
      for(int y = 0;y < board[x].length;y++){
      }
    }
  }
  
  public void render(){
    noStroke();
    fill(100);
    for(int x = 0;x < board.length;x++){
      for(int y = 0;y < board[x].length;y++){
        if(board[x][y] != 0)
          rect(x*width/board.length, y*height/board[x].length, width/board.length, height/board[x].length);
      }
    }
  }
  
  public void clearLine(int sy){
    for(int x = 0;x < board.length;x++)
      board[x][sy] = 0;
    for(int x = 0;x < board.length;x++){
      for(int y = sy;y > 0;y--){
        board[x][y] = board[x][y-1];
      }
      board[x][0] = 0;
    }
  }
  
  public void addPiece(ArrayList<PVector> positions){
    currentPiece = positions;
    for(PVector pos:positions){
      if(board[(int)pos.x][(int)pos.y] == 1)gameOver = true;
      board[(int)pos.x][(int)pos.y] = 1;
    }
  }
  
  public void dropPiece(){
    for(PVector pos:currentPiece){
      
    }
  }
  
}
