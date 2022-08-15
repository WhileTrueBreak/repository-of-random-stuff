boolean collision(PVector p1,PVector d1, PVector p2, PVector d2){
  if(p1.x<p2.x+d2.x&&p1.x+d1.x>p2.x&&p1.y<p2.y+d2.y&&p1.y+d1.y>p2.y){
    return true;
  }
  return false;
}
PVector truncate(PVector i1, float max){
  if(i1.mag()>max){
    return i1.copy().setMag(max);
  }
  return i1.copy();
}