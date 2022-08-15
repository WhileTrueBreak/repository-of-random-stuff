class Wall{
  color c;
  float x1, y1, x2, y2;
  
  public Wall(float x1, float y1, float x2, float y2){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    
    this.c = color(255,random(255),random(255));
  }
  
  void render(){
    stroke(c);
    strokeWeight(1);
    line(x1, y1, x2, y2);
  }
  
}
