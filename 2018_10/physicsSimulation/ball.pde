class ball{
  handler h;
  
  PVector acc = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector pos;
  float radius;
  ball(PVector pos, float radius, handler h){
    this.h = h;
    this.pos = pos;
    this.radius = radius;
  }
  
  void update(){
    vel.add(acc);
    bounceLine();
    //if(collideBarrier(new PVector(pos.x, pos.y+vel.y), radius)){
    //  vel.y = 0;
    //}if(collideBarrier(new PVector(pos.x+vel.x, pos.y), radius)){
    //  vel.x = 0;
    //}
    pos.add(vel);
    acc.mult(0.1);
  }
  
  void render(){
    noStroke();
    fill(255,150);
    ellipse(pos.x,pos.y,radius*2,radius*2);
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void bounceLine(){
    boolean hit = false;
    PVector newVel = new PVector(0,0);
    float currentVelMag = vel.mag();
    for(barrier b:h.s.lineM.barriers){
      //println(vel);
      if(circleLine(pos.copy().add(vel), b.p1,b.p2,radius)){
        float angleOfLine = abs(PVector.angleBetween(new PVector(1,0),new PVector(b.p2.x-b.p1.x,b.p2.y-b.p1.y)));
        if(angleOfLine>180){
          angleOfLine-=180;
        }
        float angleOfReflection = -abs(PVector.angleBetween(vel,new PVector(b.p2.x-b.p1.x,b.p2.y-b.p1.y)));
        newVel = PVector.fromAngle((angleOfReflection-angleOfLine));
        hit = true;
      }
    }
    if(hit){
      newVel.setMag(currentVelMag*0.99);
      vel = newVel;
    }
  }
  
  boolean collideBarrier(PVector pos, float r){
    for(barrier b:h.s.lineM.barriers){
      if(circleLine(pos.copy().add(vel), b.p1,b.p2,r)){
        return true;
      }
    }
    return false;
  }
}