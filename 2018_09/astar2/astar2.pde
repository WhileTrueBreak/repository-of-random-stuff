int size = 100;
int[][] map = new int[size][size];

PVector start = new PVector(3,3);
PVector end = new PVector(size-3,size-3);

astar as = new astar(map,start,end);

void setup(){
  size(1000,1000);
  for(int i = 0;i < map.length;i++){
    for(int j = 0;j < map[i].length;j++){
      map[i][j] = 0;
      if(random(1) < 1){
        map[i][j] = 1;
      }
      if(j == start.x && i == start.y && j == end.x && i == end.y){
        map[i][j] = 0;
      }
    }
  }
}

void draw(){
  background(255);
  as.display();
  for(int i = 0;i < map.length;i++){
    for(int j = 0;j < map[i].length;j++){if(map[i][j] == 1){
      if(map[i][j] == 0);
        fill(0);
      }else{
        noFill();
      }
      rect(j*width/size,i*width/size,width/size,height/size);
    }
  }
  //as.checkNeighbours(map);
  //as.updateTarget();
}