class tile{
  boolean blocked = false;
  float x;
  float y;
  float size = TileSIZE;
  tile(float ix,float iy){
    x = ix;
    y = iy;
  }
  void display(){
    strokeWeight(1);
    if(!blocked){
      fill(0,0);
      stroke(0,0);
    }else{
      fill(0);
      stroke(255);
    }
    rect(x,y,size,size);
  }
  void checkBlocked(boolean in){
    blocked = in;
  }
}