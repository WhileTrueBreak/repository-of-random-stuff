class torch{
  ArrayList<fire>fires = new ArrayList();
  ArrayList<fire>firesToRemove = new ArrayList();
  PVector pos;
  torch(PVector pos_){
    pos = pos_.copy();
  }
  void display(PVector rotate,PVector pr){
    for(fire c:fires){
      c.display(rotate,pr);
    }
  }
  
  void update(){
    for(fire c:fires){
      c.update();
      if(c.dead()){
        firesToRemove.add(c);
      }
    }
    fires.removeAll(firesToRemove);
    firesToRemove = new ArrayList();
    if(fires.size()<100){
      fires.add(new fire(pos.copy()));
    }
  }
}