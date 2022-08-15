player p = new player();
ArrayList<wall> walls = new ArrayList();
ArrayList<enemy> enemies = new ArrayList();

PVector cShift = new PVector(0,0);

void setup(){
  smooth();
  size(1000,1000);
  quadWall(450,600,650,550,640,800,450,880);
  quadWall(450,100,650,50,640,380,450,300);
  enemies.add(new enemy(new PVector(1000,1000)));
}

void draw(){
  cShift = new PVector(width/2-p.pos.x,height/2-p.pos.y);
  
  background(0);
  //////////////////
  for(wall w:walls){
    w.display(cShift);
  }
  for(enemy e:enemies){
    e.display(cShift);
    e.update();
  }
  //////////////////
  
  p.checkKeys();
  p.update();
  p.display(cShift);
}

void quadWall(float x1,float y1,float x2,float y2,float x3,float y3,float x4,float y4){
  walls.add(new wall(new PVector(x2,y2),new PVector(x1,y1)));
  walls.add(new wall(new PVector(x2,y2),new PVector(x3,y3)));
  walls.add(new wall(new PVector(x3,y3),new PVector(x4,y4)));
  walls.add(new wall(new PVector(x4,y4),new PVector(x1,y1)));
}