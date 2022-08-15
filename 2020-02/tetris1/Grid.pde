class Grid{
  
  boolean blocks[][];
  
  Grid(int w, int h){
    blocks = new boolean[w][h];
  }
  
  void render(){
    stroke(0);
    fill(255);
    for(int i = 0;i < blocks.length;i++){
      for(int j = 0;j < blocks[i].length;j++){
        if(blocks[i][j]){
          rect(i*30, j*30, 30, 30);
        }
      }
    }
  }
  
}