class player extends entity{
  float speed = 4;
  float jumpForce = 6;
  
  int lengthT = 4;
  int timer = 0;
  
  boolean climbable = false;
  boolean onBlock = false;
  boolean climbing = false;
  
  PVector acc = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector pos;
  player(PVector p){
    pos = p.copy();
  }
  void update(){
    if(climbable&&!onBlock){
      climbing = true;
    }
    onBlock = false;
    vel.add(acc);
    if(!collide(pos.x,pos.y+vel.y,10,20)){
      pos.add(new PVector(0,vel.y));
      onBlock = false;
    }else{
      if(vel.y <= 0){
        onBlock = true;
      }
      vel.y = 0;
    }
    if(!collide(pos.x+vel.x,pos.y,10,20)){
      pos.add(new PVector(vel.x,0));
    }else{
      vel.x = 0;
    }
    acc.mult(0);
  }
  void display(){
    fill(0);
    noStroke();
    rect(pos.x,pos.y,10,20);
  }
  void gravity(){
    applyForce(new PVector(0,0.5));
  }
  void applyForce(PVector force){
    acc.add(force);
  }
  void move(){
    if(w&&!collide(pos.x,pos.y-speed,10,20)&&climbable){
      pos.add(new PVector(0,-speed));
    }
    if(a&&!collide(pos.x-speed,pos.y,10,20)){
      pos.add(new PVector(-speed,0));
    }
    if(s&&!collide(pos.x,pos.y+speed,10,20)&&climbable){
      pos.add(new PVector(0,speed));
    }else{
      onBlock = false;
      if(collide(pos.x,pos.y+speed,10,20)){
        onBlock = true;
      }
    }
    if(d&&!collide(pos.x+speed,pos.y,10,20)){
      pos.add(new PVector(speed,0));
    }
    if(!onBlock){
      timer = 0;
    }else{
      timer++;
    }
    if(space&&onBlock&&!climbing&&timer>lengthT){
      acc.add(new PVector(0,-jumpForce));
      onBlock = false;
      timer=0;
    }
  }
}