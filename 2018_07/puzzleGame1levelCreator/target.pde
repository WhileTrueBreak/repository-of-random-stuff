class target{
  boolean filled = false;
  
  PVector pos;
  target(PVector pos_){
    pos = pos_;
  }
  void draw(){
    noStroke();
    if(filled){
      fill(255,126,255,50);
    }else{
      fill(255,126,255);
    }
    rect(pos.x,pos.y,20,20,5);
  }
}