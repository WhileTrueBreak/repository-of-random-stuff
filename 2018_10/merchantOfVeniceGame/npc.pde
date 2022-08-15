class npc{
  float accSpeed = 1;
  float max_force = 0.2;
  PVector steering = new PVector(0,0);
  float speed = 2;
  PVector dime = new PVector(scl-10,scl-10);
  PVector setP;
  PVector target;
  
  PVector pos = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  npc(PVector p){
    pos = p.copy();
    setP = p.copy();
    target = new PVector(random(setP.x-200,setP.x+200),random(setP.y-200,setP.y+200));
  }
  void wander(){
    if(frameCount%100 == 0||dist(target.x,target.y,pos.x,pos.y)<60){
      target = new PVector(random(setP.x-200,setP.x+200),random(setP.y-200,setP.y+200));
    }
    PVector d_vel = new PVector(0,0);
    PVector temp = target.copy();
    d_vel = ((temp.copy().sub(pos)).mult(speed));
    steering = d_vel.copy().sub(vel);
    steering = truncate(steering,max_force);
    steering.mult(1/1);
    acc.add(steering);
  }
  void update(){
    acc = truncate(acc,accSpeed);
    vel.add(acc);
    vel = truncate(vel,speed);
    for(hitbox h:hitboxes){
      if(collision(new PVector(pos.x+vel.x,pos.y),dime,h.pos,h.dime)){
        vel.x = 0;
        target.x = random(setP.x-200,setP.x+200);
      }
      if(collision(new PVector(pos.x,pos.y+vel.y),dime,h.pos,h.dime)){
        vel.y = 0;
        target.y = random(setP.y-200,setP.y+200);
      }
    }
    pos.add(vel);
    vel.mult(1);
    acc.mult(0);
  }
  void display(PVector s){
    fill(255,100);
    stroke(255,0,0);
    strokeWeight(3);
    //ellipse(target.x,target.y,10,10);
    rect(pos.x+s.x,pos.y+s.y,dime.x,dime.y);
  }
}