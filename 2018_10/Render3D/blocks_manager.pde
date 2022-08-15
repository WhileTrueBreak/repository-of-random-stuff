class blockManager{
  
  ArrayList<block> blocks;
  
  handler h;
  
  blockManager(handler h){
    this.h = h;
    blocks = new ArrayList();
  }
  
  public void update(){
    for(block b:blocks){
      b.update();
    }
  }
  
  public void render(){
    for(block b:blocks){
      b.render();
    }
  }
  
  public void addBlock(block b){
    blocks.add(b);
  }
}