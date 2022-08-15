class player{
  
  PVector dir = new PVector(0,-3);
  
  float r = 0;
  
  handler h;
  
  PVector pos;
  
  player(PVector pos, handler h){
    this.h = h;
    this.pos = pos;
  }
  
  public void update(){
    for(float i = 0;i < 1000;i++){
      h.g.rm.addRay(new ray(pos, PVector.fromAngle(radians(i/10+r)), i, map(i, 0, 1000, -60, 60)));
    }
    //r+=1;
    //pos.add(dir);
    //if(pos.y<0){
    //  r = 230-180;
    //  if(pos.y<-100){
    //    dir = new PVector(0,3);
    //  }
    //}
    //if(pos.y>1000){
    //  r = 230;
    //  if(pos.y>1100){
    //    dir = new PVector(0,-3);
    //  }
    //}
  }
  
  public void render(){
    stroke(255);
    strokeWeight(20);
    point(pos.x,pos.y);
  }
  
}