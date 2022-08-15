class Cline{
  
  float x1, y1, x2, y2;
  float grad;
  
  Cline(float x1, float y1, float x2, float y2){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.grad = (y1-y2)/(x1-x2);
  }
  
  void render(){
    stroke(255);
    line(x1, y1, x2, y2);
  }
  
}
