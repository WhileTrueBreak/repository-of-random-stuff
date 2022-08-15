float scl = 1000/8;
int numMines = 8;

boolean lost = false;
boolean win = false;
boolean first = true;
boolean mouse = false;
boolean right = false;
boolean left = false;
boolean wrongFlag = false;
int numFlagged = 0;

int[][] neighbours;
boolean[][] flagged;
boolean[][] mine;
boolean[][] checked;

void setup(){
  size(1000,1000);
  neighbours = new int[round(width/scl)][round(height/scl)];
  flagged = new boolean[round(width/scl)][round(height/scl)];
  mine = new boolean[round(width/scl)][round(height/scl)];
  checked = new boolean[round(width/scl)][round(height/scl)];
  for(int x = 0;x < neighbours.length;x++){
    for(int y = 0;y < neighbours[x].length;y++){
      neighbours[x][y] = 0;
      checked[x][y] = false;
      mine[x][y] = false;
      flagged[x][y] = false;
    }
  }
  for(int i = 0;i < numMines;i++){
    int x = round(random(mine.length-1));
    int y = round(random(mine[x].length-1));
    if(mine[x][y]){
      i--;
    }else{
      mine[x][y] = true;
      if(x != 0){
        neighbours[x-1][y]++;
        if(y != 0){
          neighbours[x-1][y-1]++;
        }
        if(y != neighbours.length-1){
          neighbours[x-1][y+1]++;
        }
      }
      if(x != neighbours.length-1){
        neighbours[x+1][y]++;
        if(y != 0){
          neighbours[x+1][y-1]++;
        }
        if(y != neighbours.length-1){
          neighbours[x+1][y+1]++;
        }
      }
      if(y != 0){
        neighbours[x][y-1]++;
      }
      if(y != neighbours.length-1){
        neighbours[x][y+1]++;
      }
    }
  }
}
void draw() {
  background(200);
  if(lost){
    for(int x = 0;x < neighbours.length;x++){
      for(int y = 0;y < neighbours[x].length;y++){
        checked[x][y] = true;
      }
    }
  }
  for(int x = 0;x < neighbours.length;x++){
    for(int y = 0;y < neighbours[x].length;y++){
      if(checked[x][y]&&neighbours[x][y] == 0){
        if(x != 0){
          checked[x-1][y] = true;
          if(y != 0){
            checked[x-1][y-1] = true;
          }
          if(y != neighbours.length-1){
            checked[x-1][y+1] = true;
          }
        }
        if(x != neighbours.length-1){
          checked[x+1][y] = true;
          if(y != 0){
            checked[x+1][y-1] = true;
          }
          if(y != neighbours.length-1){
            checked[x+1][y+1] = true;
          }
        }
        if(y != 0){
          checked[x][y-1] = true;
        }
        if(y != neighbours.length-1){
          checked[x][y+1] = true;
        }
      }
      if(mine[x][y]&&flagged[x][y]){
        numFlagged++;
      }
      if(!mine[x][y]&&flagged[x][y]){
        wrongFlag = true;
      }
      if(mine[x][y]&&!flagged[x][y]){
        noStroke();
        fill(0);
        ellipse(x*scl+scl/2,y*scl+scl/2,scl/2,scl/2);
      }else if(neighbours[x][y] != 0&&!flagged[x][y]){
        textAlign(LEFT,TOP);
        textSize(scl);
        fill(0);
        text(neighbours[x][y],x*scl,y*scl);
      }
      if(!checked[x][y]||flagged[x][y]){
        stroke(200);
        fill(100);
        rect(x*scl,y*scl,scl,scl);
      }else{
        stroke(100);
        fill(255,0,0,10);
        rect(x*scl,y*scl,scl,scl);
      }
      if(flagged[x][y]){
        noStroke();
        fill(255,0,0);
        ellipse(x*scl+scl/2,y*scl+scl/2,scl/2,scl/2);
      }
    }
  }
  println(wrongFlag,numFlagged,numMines);
  if(!wrongFlag&&numFlagged == numMines){
    win = true;
  }else{
    numFlagged = 0;
    wrongFlag = false;
  }
  stroke(0);
  fill(0);
  if(mouse&&!lost){
    int indexX = floor(mouseX/scl);
    int indexY = floor(mouseY/scl);
    if(indexX >= round(width/scl)){
      indexX = 49;
    }
    if(indexY >= round(height/scl)){
      indexY = 49;
    }
    if(indexX <= -1){
      indexX = 0;
    }
    if(indexY <= -1){
      indexY = 0;
    }
    if((mouseButton == RIGHT)){
      
    }else if(!flagged[indexX][indexY]){
      checked[indexX][indexY] = true;
      if(first){
        if(mine[indexX][indexY]){
          if(indexX != 0){
            neighbours[indexX-1][indexY]--;
            if(indexY != 0){
              neighbours[indexX-1][indexY-1]--;
            }
            if(indexY != neighbours.length-1){
              neighbours[indexX-1][indexY+1]--;
            }
          }
          if(indexX != neighbours.length-1){
            neighbours[indexX+1][indexY]--;
            if(indexY != 0){
              neighbours[indexX+1][indexY-1]--;
            }
            if(indexY != neighbours.length-1){
              neighbours[indexX+1][indexY+1]--;
            }
          }
          if(indexY != 0){
            neighbours[indexX][indexY-1]--;
          }
          if(indexY != neighbours.length-1){
            neighbours[indexX][indexY+1]--;
          }
        }
        mine[indexX][indexY] = false;
        first = !first;
      }
      if(mine[indexX][indexY]){
        lost = true;
      }
    }
  }
  println(win);
  if(win){
    fill(0);
    textSize(200);
    textAlign(CENTER,CENTER);
    text("You WIN",width/2,height/2);
  }
}
void mousePressed(){
  mouse = true;
}
void mouseReleased(){
  mouse = false;
  int indexX = floor(mouseX/scl);
  int indexY = floor(mouseY/scl);
  if(indexX >= round(width/scl)){
    indexX = 49;
  }
  if(indexY >= round(height/scl)){
    indexY = 49;
  }
  if(indexX <= -1){
    indexX = 0;
  }
  if(indexY <= -1){
    indexY = 0;
  }
  if(mouseButton == RIGHT){
    flagged[indexX][indexY] = !flagged[indexX][indexY];
  }
}