ArrayList<block> blocks = new ArrayList();
ArrayList<wall> walls = new ArrayList();
ArrayList<target> targets = new ArrayList();

int [][] createdLevel = new int[20][20];

void setup(){
  size(400,400);
  for(int i = 0;i < createdLevel.length;i++){
    for(int j = 0;j < createdLevel[i].length;j++){
      createdLevel[i][j] = in[i][j];
      if(in[i][j] == 1){
        walls.add(new wall(new PVector(j*20,i*20)));
      }
      if(in[i][j] == 2){
        blocks.add(new block(new PVector(j*20,i*20)));
      }
      if(in[i][j] == 4){
        targets.add(new target(new PVector(j*20,i*20)));
      }
    }
  }
}

void draw(){
  background(115,255,255);
  if(r){
    blocks = new ArrayList();
    walls = new ArrayList();
    targets = new ArrayList();
    for(int i = 0;i < createdLevel.length;i++){
      for(int j = 0;j < createdLevel[i].length;j++){
        createdLevel[i][j] = in[i][j];
      }
    }
  }
  ////////////////////entity////////////////////
  for(int i = 0;i < createdLevel.length;i++){
    for(int j = 0;j < createdLevel[i].length;j++){
      noFill();
      stroke(0);
      rect(i*20,j*20,20,20);
      if(createdLevel[i][j] == 3){
        noStroke();
        fill(123,234,60);
        rect(j*20,i*20,20,20,5);
      }
    }
  }
  for(wall part:walls){
    part.draw();
  }
  for(block part:blocks){
    part.draw();
  }
  for(target part:targets){
    part.draw();
  }
  if(mouseL){
    if(k1&&createdLevel[floor(mouseY/20)][floor(mouseX/20)] == 0){
      createdLevel[floor(mouseY/20)][floor(mouseX/20)] = 1;
      walls.add(new wall(new PVector(floor(mouseX/20)*20,floor(mouseY/20)*20)));
    }
    if(k2&&createdLevel[floor(mouseY/20)][floor(mouseX/20)] == 0){
      createdLevel[floor(mouseY/20)][floor(mouseX/20)] = 2;
      blocks.add(new block(new PVector(floor(mouseX/20)*20,floor(mouseY/20)*20)));
    }
    if(k3&&createdLevel[floor(mouseY/20)][floor(mouseX/20)] == 0){
      createdLevel[floor(mouseY/20)][floor(mouseX/20)] = 3;
    }
    if(k4&&createdLevel[floor(mouseY/20)][floor(mouseX/20)] == 0){
      createdLevel[floor(mouseY/20)][floor(mouseX/20)] = 4;
      targets.add(new target(new PVector(floor(mouseX/20)*20,floor(mouseY/20)*20)));
    }
  }
  if(e){
    println("{");
    for(int i = 0;i < createdLevel.length;i++){
      println("  "+"{"+createdLevel[i][0]+","+createdLevel[i][1]+","+createdLevel[i][2]+","+createdLevel[i][3]+","+createdLevel[i][4]+","+createdLevel[i][5]+","+createdLevel[i][6]+","+createdLevel[i][7]+","+createdLevel[i][8]+","+createdLevel[i][9]+","+createdLevel[i][10]+","+createdLevel[i][11]+","+createdLevel[i][12]+","+createdLevel[i][13]+","+createdLevel[i][14]+","+createdLevel[i][15]+","+createdLevel[i][16]+","+createdLevel[i][17]+","+createdLevel[i][18]+","+createdLevel[i][19]+"},");
    }
    println("},");
    temp = false;
  }
}