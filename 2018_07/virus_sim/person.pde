class person{
  float vTimer = 10000;
  float maxS = random(1,3);
  float immunity = random(0,0.2);
  boolean virus = false;
  boolean dead = false;
  boolean doctor = false;
  PVector pos = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  PVector home = new PVector(0,0);
  person(PVector h,PVector p){
    if(random(1)<0.01){
      doctor = true;
    }
    home = h;
    pos = p;
  }
  void update(){
    if(virus&&random(1)>immunity){
      vTimer--;
      if(random(1)<0.01){
        immunity += 0.001;
      }
    }
    if(vTimer <= 0){
      dead = true;
    }
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  void findTarget
}