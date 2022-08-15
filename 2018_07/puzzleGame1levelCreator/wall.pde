class wall{
  PVector pos;
  wall(PVector pos_){
    pos = pos_;
  }
  void draw(){
    noStroke();
    fill(80);
    rect(pos.x,pos.y,20,20,5);
  }
}