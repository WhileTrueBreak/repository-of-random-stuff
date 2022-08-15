class tile{
  cube c;
  
  PVector pos = new PVector(0,0,0);
  tile(PVector p,PVector d){
    c = new cube(p,d);
    c.c = color(random(0,255),random(0,255),random(0,255));
  }
  void display(PVector rotate,PVector pr){
    c.display(rotate,pr);
  }
}