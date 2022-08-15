class tile{
  cube c;
  PVector pos = new PVector(0,0,0);
  float scl = 1;
  
  tile(PVector p){
    pos = p.copy();
    c = new cube(pos,new PVector(10,10,10));
  }
  void display(){
    c.display(new PVector(-45,45,0),centerOfAttention);
  }
}