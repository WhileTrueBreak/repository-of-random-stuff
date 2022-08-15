class Block{
  
  PVector pos;
  
  public Block(int x, int y){
    this.pos = new PVector(x, y);
  }
  
  public void render(int xOff, int yOff, float scale){
    noStroke();
    fill(255);
    rect((pos.x-xOff)*scale, (pos.y-yOff)*scale, scale, scale);
  }
  
}
