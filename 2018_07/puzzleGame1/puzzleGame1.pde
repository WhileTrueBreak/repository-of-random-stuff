ArrayList<player> players = new ArrayList();
ArrayList<block> blocks = new ArrayList();
ArrayList<block> toRemoveBlock = new ArrayList();
ArrayList<wall> walls = new ArrayList();
ArrayList<target> targets = new ArrayList();

boolean levelComplete = true;
int currentLevel = 0;

void setup(){
  size(400,400);
  for(int i = 0;i < levelSetup[currentLevel].length;i++){
    for(int j = 0;j < levelSetup[currentLevel][i].length;j++){
      if(levelSetup[currentLevel][i][j] == 1){
        walls.add(new wall(new PVector(j*20,i*20)));
      }
      if(levelSetup[currentLevel][i][j] == 2){
        blocks.add(new block(new PVector(j*20,i*20)));
      }
      if(levelSetup[currentLevel][i][j] == 3){
        players.add(new player(new PVector(j*20,i*20)));
      }
      if(levelSetup[currentLevel][i][j] == 4){
        targets.add(new target(new PVector(j*20,i*20)));
      }
    }
  }
}

void draw(){
  if(r||levelComplete){
    players = new ArrayList();
    blocks = new ArrayList();
    walls = new ArrayList();
    toRemoveBlock = new ArrayList();
    targets = new ArrayList();
    for(int i = 0;i < levelSetup[currentLevel].length;i++){
      for(int j = 0;j < levelSetup[currentLevel][i].length;j++){
        if(levelSetup[currentLevel][i][j] == 1){
          walls.add(new wall(new PVector(j*20,i*20)));
        }
        if(levelSetup[currentLevel][i][j] == 2){
          blocks.add(new block(new PVector(j*20,i*20)));
        }
        if(levelSetup[currentLevel][i][j] == 3){
          players.add(new player(new PVector(j*20,i*20)));
        }
        if(levelSetup[currentLevel][i][j] == 4){
          targets.add(new target(new PVector(j*20,i*20)));
        }
      }
    }
    levelComplete = false;
  }
  background(115,255,255);
  ////////////////////entity////////////////////
  for(wall part:walls){
    part.draw();
  }
  for(block part:blocks){
    part.draw();
  }
  levelComplete = true;
  for(target part:targets){
    if(!part.filled){
      levelComplete = false;
    }
    part.checkFilled();
    part.draw();
  }
  blocks.removeAll(toRemoveBlock);
  ////////////////////player////////////////////
  for(player part:players){
    part.draw();
    part.update();
    part.move();
  };
  if(levelComplete){
    currentLevel++;
    if(levelSetup.length-1 == currentLevel){
      currentLevel = 0;
    }
  }
}