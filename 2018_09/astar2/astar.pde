class astar{
  PVector start;
  PVector end;
  
  int[][] current;
  astar(int[][] m,PVector s,PVector e){
    start = s;
    end = e;
    current = m;
    for(int i = 0;i < current.length;i++){
      for(int j = 0;j < current[i].length;j++){
        current[i][j] = 0;
      }
    }
    current[int(start.y)][int(start.x)] = 1;
  }
  void display(){
    noStroke();
    for(int i = 0;i < current.length;i++){
      for(int j = 0;j < current[i].length;j++){
        if(current[i][j] == 2){
          fill(0,255,30,100);
        }else if(current[i][j] == 1){
          fill(0,100,255,100);
        }else{
          noFill();
        }
        rect(j*width/size,i*width/size,width/size,height/size);
      }
    }
  }
  void checkNeighbours(int[][] m){
    for(int i = 0;i < current.length;i++){
      for(int j = 0;j < current[i].length;j++){
        if(current[i][j] == 1){
          for(int x = -1;x < 2;x++){
            for(int y = -1;y < 2;y++){
              if(y != 0 || x != 0&&m[i][j] != 1){
                current[i+y][j+x] = 2;
              }
            }
          }
        }
      }
    }
  }
  void updateTarget(){
    PVector newP = new PVector(-1,-1);
    float SD = current.length + current[0].length;
    for(int i = 0;i < current.length;i++){
      for(int j = 0;j < current[i].length;j++){
        if(current[i][j] == 2&&dist(j,i,end.x,end.y) < SD){
          SD = dist(j,i,end.x,end.y);
          newP = new PVector(i,j);
        }
      }
    }
    current[int(newP.x)][int(newP.y)] = 1;
  }
}