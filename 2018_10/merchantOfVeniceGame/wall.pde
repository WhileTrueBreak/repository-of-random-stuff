class wall{
  boolean createdH = false;
  PVector pos;
  PVector dime = new PVector(scl,scl);
  wall(PVector p){
    pos = p.copy();
    hitboxes.add(new hitbox(p));
  }
  void display(PVector s){
    fill(255);
    noStroke();
    rect(pos.x+s.x,pos.y+s.y,dime.x,dime.y);
  }
}