class block{
  
  handler h;
  
  PVector p1, p2, p3, p4;
  
  block(PVector p1,PVector p2,PVector p3,PVector p4, handler h){
    this.h = h;
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
    h.g.lm.addLine(new line(p1, p2));
    h.g.lm.addLine(new line(p2, p3));
    h.g.lm.addLine(new line(p3, p4));
    h.g.lm.addLine(new line(p4, p1));
  }
  
  void update(){
    
  }
  
  void render(){
    noStroke();
    fill(255);
    quad(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
  }
  
}