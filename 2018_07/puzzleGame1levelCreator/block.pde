class block{
  PVector pos;
  block(PVector pos_){
    pos = pos_;
  }
  void draw(){
    noStroke();
    fill(255,255,200);
    rect(pos.x,pos.y,20,20,5);
  }
}