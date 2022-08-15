class Block{
  
  float x, y, w, h;
  
  Block(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void render(){
    noStroke();
    fill(0);
    rect(x, y, w, h);
  }
  
}