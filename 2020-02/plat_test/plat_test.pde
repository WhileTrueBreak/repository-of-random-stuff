ArrayList<Block> blocks;

void setup(){
  size(600, 600);
  blocks = new ArrayList<Block>();
  for(int i = 0;i < 600*600/4;i++){
    blocks.add(new Block((int)random(width), (int)random(height)));
  }
}

void draw(){
  background(0);
  for(Block block:blocks){
    block.render(0, 0, 10);
  }
}
