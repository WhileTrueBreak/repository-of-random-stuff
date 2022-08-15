class line{
  PVector p1, p2;
  line(PVector p1, PVector p2){
    this.p1 = p1;
    this.p2 = p2;
  }
  
  public void update(){
    
  }
  
  public void render(){
    stroke(255);
    strokeWeight(1);
    line(p1.x,p1.y,p2.x,p2.y);
  }
  
  public PVector getStart(){
    return p1;
  }
  
  public PVector getEnd(){
    return p2;
  }
  
}