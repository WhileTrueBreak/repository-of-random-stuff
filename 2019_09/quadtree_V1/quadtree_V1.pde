ArrayList<Block>blocks = new ArrayList<Block>();

Quadtree qt = new Quadtree(1200, 1200);

void setup(){
  size(1200,1200);
  for(int i = 0;i < 1;i++){
    float w = random(50,100), h = random(50,100);
    float x = random(0,width-w), y = random(0,height-h);
    blocks.add(new Block(x, y, w, h));
  }
  for(Block b:blocks){
    b.render();
  }
  qt.addBlocks(blocks);
  qt.dfs();
  qt.createNavMesh();
  qt.renderNavMesh();
}

void draw(){
  
}