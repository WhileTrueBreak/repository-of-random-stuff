class target extends entity{
  boolean filled = false;
  
  PVector pos;
  target(PVector pos_){
    pos = pos_;
  }
  void checkFilled(){
    for(block part:blocks){
      if(round(part.pos.x) == round(pos.x)&&round(part.pos.y) == round(pos.y)&&!filled){
        toRemoveBlock.add(part);
        filled = true;
      }
    }
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