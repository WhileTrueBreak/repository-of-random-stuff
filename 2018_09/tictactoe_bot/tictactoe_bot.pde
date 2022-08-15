int[][] map = new int[3][3];
int turn = 1;

PVector clickedPos = new PVector(-1,-1);

void setup(){
  size(300,300);
  for(int i = 0;i < map.length;i++){
    for(int j = 0;j < map[i].length;j++){
      map[i][j] = 0;
    }
  }
}

void draw(){
  background(255);
  for(int i = 0;i < map.length;i++){
    for(int j = 0;j < map[i].length;j++){
      stroke(0);
      if(map[i][j]==0){
        noFill();
      }else if(map[i][j]==1){
        fill(255,0,0);
      }else if(map[i][j]==2){
        fill(0,255,0);
      }
      rect(width/map[i].length*j,height/map.length*i,width/map[i].length,height/map.length);
    }
  }
}

void mouseReleased(){
  clickedPos = new PVector(mouseX,mouseY);
  int indexX = floor(clickedPos.y/(width/map.length));
  int indexY = floor(clickedPos.x/(height/map[0].length));
  if(map[indexX][indexY]==0){
    map[indexX][indexY] = turn;
    if(turn == 1){
      turn = 2;
    }else{
      turn = 1;
    }
  }
}