class player{
  float accSpeed = 1;
  float speed = 3;
  PVector dime = new PVector(scl-10,scl-10);
  
  PVector pos = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  player(PVector p){
    pos = p.copy();
  }
  void update(){
    acc = truncate(acc,accSpeed);
    vel.add(acc);
    vel = truncate(vel,speed);
    for(hitbox h:hitboxes){
      if(collision(new PVector(pos.x+vel.x,pos.y),dime,h.pos,h.dime)){
        vel.x = 0;
      }
      if(collision(new PVector(pos.x,pos.y+vel.y),dime,h.pos,h.dime)){
        vel.y = 0;
      }
    }
    pos.add(vel);
    vel.mult(0.8);
    acc.mult(0);
  }
  void display(PVector s){
    fill(255,100);
    stroke(255);
    strokeWeight(3);
    rect(pos.x+s.x,pos.y+s.y,dime.x,dime.y);
  }
  void move(){
    if(mUp){
      acc.y-=speed;
    }if(mDown){
      acc.y+=speed;
    }if(mLeft){
      acc.x-=speed;
    }if(mRight){
      acc.x+=speed;
    }
  }
}