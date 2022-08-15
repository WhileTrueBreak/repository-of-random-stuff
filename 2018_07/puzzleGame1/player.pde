class player extends entity{
  int nextMoveTimer = 0;
  
  PVector pos;
  player(PVector pos_){
    pos = pos_;
  }
  void update(){
    nextMoveTimer++;
  }
  void move(){
    if(nextMoveTimer > 10){
      
      nextMoveTimer = 0;
    }
  }
  void draw(){
    noStroke();
    fill(123,234,60);
    rect(pos.x,pos.y,20,20,5);
  }
}