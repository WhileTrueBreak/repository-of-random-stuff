/**
*rules
*when dead the corpse will stay of 20 frames
*1, 2, 3, 4 stays alive
*3, 5 born
*all 5, 6, 7, 8 dies
**/

int w = 100;
int h = 100;

int bornLife = 20;

boolean pause = false;
boolean clicked = false;
boolean clear = false;
boolean rand = false;

int timer = 100;

boolean[][] map = new boolean[w][h];
int[][] life = new int[w][h];

void setup(){
  size(1000,1000);
  for(int i = 0;i < map.length;i++){
    for(int j = 0;j < map[i].length;j++){
      int temp = round(random(1));
      if(temp == 1){
        map[i][j] = false;
      }else{
        map[i][j] = false;
      }
    }
  }
}

void draw(){
  background(200,200);
  if(timer<0 && pause == false){
    for(int i = 0;i < life.length;i++){
      for(int j = 0;j < life[i].length;j++){
        life[i][j]--;
        if(life[i][j]<0){
          life[i][j] = 0;
        }
      }
    }
    boolean[][] tempMap = new boolean[w][h];
    for(int i = 0;i < map.length;i++){
      for(int j = 0;j < map[i].length;j++){
        int num = 0;
        for(int i1 = -1;i1 < 2;i1++){
          for(int j1 = -1;j1 < 2;j1++){
            if(!(i1==0&&j1==0)){
              //calc neighbors
              int x = i+i1;
              int y = j+j1;
              if(x<0){
                x = w-1;
              }
              if(y<0){
                y = h-1;
              }
              if(x>h-1){
                x = 0;
              }
              if(y>h-1){
                y = 0;
              }
              if(map[x][y]){
                num++;
              }
            }
          }
        }
        fill(255,0,0);
        textSize(50);
        /**RULES**/
        if(true){
          if(map[i][j] == true){
            tempMap[i][j] = false;
          }
          if((num==1||num==2||num==3||num==4)&&map[i][j] == true){
            tempMap[i][j] = true;
            life[i][j] = bornLife;
          }
          if((num==4||num==5)&&map[i][j] == false&&life[i][j] == 0){
            tempMap[i][j] = true;
          }
        }
      }
    }
    timer = 1;
    map = tempMap;
  }
  //display
  for(int i = 0;i < map.length;i++){
    for(int j = 0;j < map[i].length;j++){
      stroke(255);
      fill(0,255*life[i][j]/bornLife);
      rect(i*width/w,j*height/h,width/w,height/h);
    }
  }  
  timer--;
  if(clear){
    for(int i = 0;i < map.length;i++){
      for(int j = 0;j < map[i].length;j++){
        map[i][j] = false;
        life[i][j] = 0;
      }
    }
  }
  if(clicked){
    if(life[mouseX/(width/w)][mouseY/(height/h)] == 0&&mouseButton == LEFT){
      life[mouseX/(width/w)][mouseY/(height/h)] = bornLife;
      map[mouseX/(width/w)][mouseY/(height/h)] = true;
    }else if(mouseButton == RIGHT){
      life[mouseX/(width/w)][mouseY/(height/h)] = 0;
      map[mouseX/(width/w)][mouseY/(height/h)] = false;
    }
  }
  if(pause){
    fill(255,0,0);
    textSize(30);
    text("paused",10,width-50);
  }
  if(rand){
    for(int i = 0;i < map.length;i++){
      for(int j = 0;j < map[i].length;j++){
        int temp = round(random(1));
        if(temp == 1){
          map[i][j] = true;
        }else{
          map[i][j] = false;
        }
      }
    }
  }
}

void mousePressed(){ 
  clicked = true;
}
void mouseReleased(){
  clicked = false;
}

void keyPressed(){
  if(key == ' '){
    pause = !pause;
  }
  if(key == 'c'){
    clear = true;
  }
  if(key == 'r'){
    rand = true;
  }
}

void keyReleased(){
  if(key == 'c'){
    clear = false;
  }
  if(key == 'r'){
    rand = false;
  }
}