
void setup(){
  size(1000,1000);
  QuadTree anySpace=new QuadTree(1,new Boundry(0,0,1000,1000));
  anySpace.insert(100,100,1);
  anySpace.insert(500,500,1);
  anySpace.insert(600,600,1);
  anySpace.insert(700,600,1);
  anySpace.insert(800,600,1);
  anySpace.insert(900,600,1);
  anySpace.insert(510,610,1);
  anySpace.insert(520,620,1);
  anySpace.insert(530,630,1);
  anySpace.insert(540,640,1);
  anySpace.insert(550,650,1);
  anySpace.insert(555,655,1);
  anySpace.insert(560,660,1);
  //Travelingthegraph
  QuadTree.dfs(anySpace);
}