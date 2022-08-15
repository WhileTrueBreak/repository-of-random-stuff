PVector shift = new PVector(-500,0);

float scl = 70;
int w;
int h;

//npc n = new npc(new PVector(500,300));
player p = new player(new PVector(40,250));

void setup(){
  size(1000,1000);
  w = width;
  h = height;
  for(int i = 0;i < scenes[cStory][cScene].length;i++){
    for(int j = 0;j < scenes[cStory][cScene][i].length;j++){
      if(scenes[cStory][cScene][i][j] == 1){
        float x = j*scl;
        float y = i*scl;
        walls.add(new wall(new PVector(x,y)));
      }else if(scenes[cStory][cScene][i][j] == 3){
        float x = j*scl;
        float y = i*scl;
        npcs.add(new npc(new PVector(x,y)));
      }
    }
  }
}

void draw(){
  shift = new PVector(p.pos.x-w/2,p.pos.y-h/2).copy().mult(-1);
  updateScene();
  background(0);
  for(wall w:walls){
    w.display(shift);
  }
  for(npc n:npcs){
    n.display(shift);
    n.wander();
    n.update();
  }
  p.display(shift);
  p.move();
  p.update();
}