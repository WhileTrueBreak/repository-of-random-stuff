class fire{
  cube c;
  int life = 0;
  
  PVector pos = new PVector(0,0,0);
  PVector vel = new PVector(random(-0.5,0.5),random(-0.5,0.5),0);
  PVector acc = new PVector(0,0,0);
  fire(PVector pos_){
    life = 70;
    c = new cube(pos,new PVector(10,10,10));
    c.r=255;
    c.g=random(150,200);
    c.b=20;
    c.a=255;
    pos = pos_;
  }
  void update(){
    acc.add(grav.copy().mult(-1));
    acc.add(new PVector(random(-0.1,0.1),random(-0.1,0.1),0));
    vel.add(acc);
    vel.limit(2);
    pos.add(vel);
    acc.mult(0);
    c.c = color(255,c.g,20,life*255/70);
    c.dimension = new PVector(life*10/70,life*10/70,life*10/70);
    c.pos = pos.copy();
    life-=random(0.25,1.75);
  }
  void display(PVector rotate,PVector pr){
    c.display(rotate,pr);
  }
  boolean dead(){
    if(life < 0){
      return true;
    }else{
      return false;
    }
  }
}