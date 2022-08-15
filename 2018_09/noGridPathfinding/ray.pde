class ray{
  int t = 300;
  PVector pos;
  PVector dir;
  ray(PVector p,PVector d){
    pos = p.copy();
    dir = d.copy();
  }
}