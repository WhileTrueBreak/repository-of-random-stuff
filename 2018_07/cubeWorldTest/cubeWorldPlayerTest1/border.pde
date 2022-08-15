class border{
  cube c;
  int life = 0;
  
  PVector pos = new PVector(0,0,0);
  border(PVector pos_){
    life = 70;
    c = new cube(pos,new PVector(10,10,10));
    c.r=0;
    c.g=0;
    c.b=0;
    c.a=0;
    pos = pos_;
  }
  void update(){
    c.c=color(0,0);
    c.dimension = new PVector(life*10/70,life*10/70,life*10/70);
    c.pos = pos.copy();
    life-=random(0.25,1.75);
  }
  void display(PVector rotate,PVector pr){
    c.display(rotate,pr,true);
  }
  boolean dead(){
    if(life < 0){
      return true;
    }else{
      return false;
    }
  }
}