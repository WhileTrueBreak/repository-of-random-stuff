class marker{
  int num;
  PVector pos;
  int state = 0;
  marker(PVector p,int s,int n){
    pos = p.copy();
    state = s;
    num = n;
  }
}