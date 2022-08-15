class Cell{
  int x, y, scl;
  float value = 0;
  float tempValue = value;
  Cell(int x,int y,int scl){
    this.x = x;
    this.y = y;
    this.scl = scl;
  }
  
  void render(){
    fill(0,0,0,map(value,1,0,255,0));
    noStroke();
    rect(x,y,scl,scl);
  }
  
  void diffuse(Cell[][] grid){
    float dr = 0.25;
    int indexX = x/scl;
    int indexY = y/scl;
    tempValue = value;
    if(indexX != 0){
      float tempV = grid[indexY][indexX-1].value;
      tempValue += (tempV-value)*dr;
    }
    if(indexY != 0){
      float tempV = grid[indexY-1][indexX].value;
      tempValue += (tempV-value)*dr;
    }
    if(indexX != grid[0].length-1){
      float tempV = grid[indexY][indexX+1].value;
      tempValue += (tempV-value)*dr;
    }
    if(indexY != grid.length-1){
      float tempV = grid[indexY+1][indexX].value;
      tempValue += (tempV-value)*dr;
    }
  }
  void change(){
    value = tempValue;
  }
}