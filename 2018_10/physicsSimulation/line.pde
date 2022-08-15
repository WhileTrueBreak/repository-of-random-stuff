class barrier{
  
  PVector p1, p2;
  
  barrier(PVector p1, PVector p2){
    this.p1 = p1;
    this.p2 = p2;
  }
  
  void update(){
    
  }
  
  void render(){
    stroke(255);
    strokeWeight(3);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
}