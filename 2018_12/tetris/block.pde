class block{
  
  int indexX, indexY;
  
  block(int indexX, int indexY){
    this.indexX = indexX;
    this.indexY = indexY;
  }
  
  void render(){
    fill(100);
    stroke(200);
    strokeWeight(scl/16);
    rect(indexX*scl,indexY*scl,scl,scl,scl/4);
  }
  
  void moveDown(){
    indexY++;
  }
  
  void moveLeft(){
    indexX--;
  }
  
  void moveRight(){
    indexX++;
  }
  
}