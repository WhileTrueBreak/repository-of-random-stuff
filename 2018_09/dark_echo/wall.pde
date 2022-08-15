class wall{
  PVector pos1;
  PVector pos2;
  wall(PVector start,PVector end){
    pos1 = start;
    pos2 = end;
  }
  void display(PVector shift){
    stroke(255,100);
    line(pos1.x+shift.x,pos1.y+shift.y,pos2.x+shift.x,pos2.y+shift.y);
  }
}