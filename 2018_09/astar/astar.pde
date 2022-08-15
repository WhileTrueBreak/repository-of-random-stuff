int size = 80;

PVector start = new PVector(3,3);
PVector end = new PVector(size-3,size-3);

boolean done = false;

float aj = 10;
float di = 14;

boolean[][] map = new boolean[size][size];
int[][] checked = new int[size][size];
int[][] pathNum = new int[size][size];
PVector[] path = new PVector[1];
//0 = unknown
//1 = checked
//2 = adjecent
void setup(){
  size(400,400);
  noStroke();
  for(int i = 0;i < pathNum.length;i++){
    for(int j = 0;j < pathNum[i].length;j++){
      pathNum[i][j] = 0;
    }
  }
  for(int i = 0;i < checked.length;i++){
    for(int j = 0;j < checked[i].length;j++){
      checked[i][j] = 0;
    }
  }
  for(int i = 0;i < map.length;i++){
    for(int j = 0;j < map[i].length;j++){
      if(random(1)<0.45||(i == start.x&&j == start.y)||(i == end.x&&j == end.y)){
        map[i][j] = true;
      }else{
        map[i][j] = false;
      }
      if(i == 0||j == 0||i == map.length-1||j == map[0].length-1){
        map[i][j] = false;
      }
    }
  }
  checked[int(start.x)][int(start.y)] = 1;
  pathNum[int(start.x)][int(start.y)] = 1;
  path[0] = start;
  frameRate(10);
}

void draw(){
  background(255);
  //draws checked map
  for(int i = 0;i < checked.length;i++){
    for(int j = 0;j < checked[i].length;j++){
      if(checked[i][j] == 1){
        fill(0,100,255,100);
      }else if(checked[i][j] == 2){
        fill(0,255,20,100);
      }else{
        noFill();
      }
      rect(j*width/size,i*height/size,width/size,height/size);
    }
  }
  //draws map
  for(int i = 0;i < map.length;i++){
    for(int j = 0;j < map[i].length;j++){
      if(map[i][j]){
        noFill();
      }else{
        fill(0);
      }
      rect(j*width/size,i*height/size,width/size,height/size);
    }
  }
  //draws start and fin
  fill(0,255,0);
  rect(start.x*width/size,start.y*height/size,width/size,height/size);
  fill(255,0,0);
  rect(end.x*width/size,end.y*height/size,width/size,height/size);
  textSize(width/size);
  for(int i = 0;i < pathNum.length;i++){
    for(int j = 0;j < pathNum[i].length;j++){
      fill(0);
      text(pathNum[i][j],j*width/size,i*height/size+height/size);
    }
  }
  if(!done){
    //finds adjecents
    for(int i = 0;i < checked.length;i++){
      for(int j = 0;j < checked[i].length;j++){
        if(checked[i][j] == 1){
          for(int x = -1;x < 2;x++){
            for(int y = -1;y < 2;y++){
              if(checked[i+x][j+y] == 0&&map[i+x][j+y] == true){
                checked[i+x][j+y] = 2;
                pathNum[i+x][j+y] = pathNum[i][j] +1;
              }
            }
          }
        }
      }
    }
    //find shortest dist
    float shortestDist = width+height;
    PVector best = new PVector(-1,-1);
    for(int i = 0;i < checked.length;i++){
      for(int j = 0;j < checked[i].length;j++){
        if(checked[i][j] == 2){
          if(dist(j,i,end.x,end.y)<shortestDist){
            shortestDist = dist(j,i,end.x,end.y);
            best = new PVector(i,j);
          }
        }
      }
    }
    println(best);
    append(path,best);
    checked[int(best.x)][int(best.y)] = 1;
    for(int i = 0;i < checked.length;i++){
      for(int j = 0;j < checked[i].length;j++){
        if(checked[i][j] == 1&&j == end.x&&i == end.y){
          done = true;
        }
      }
    }
  }
}