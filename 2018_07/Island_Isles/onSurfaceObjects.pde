class grass extends entity{
  float scl;
  PVector pos;
  grass(float x,float y,float scale){
    scl = scale;
    pos = new PVector(x,y);
  }
  void display(PVector shift){
    scl = scale;
    BASE_HEALTH = 60;
    shapel2Creator(0,pos.x+shift.copy().x,pos.y+shift.copy().y,scl,scl,16);
  }
}
class bigTree extends entity{
  float scl;
  PVector pos;
  bigTree(float x,float y,float scale){
    scl = scale;
    pos = new PVector(x,y);
  }
  void display(PVector shift){
    scl = scale;
    BASE_HEALTH = 600;
    shapel2Creator(2,pos.x+shift.copy().x,pos.y+shift.copy().y,scl,scl,12);
  }
}
class smallTree extends entity{
  float scl;
  PVector pos;
  smallTree(float x,float y,float scale){
    scl = scale;
    pos = new PVector(x,y);
  }
  void display(PVector shift){
    scl = scale;
    BASE_HEALTH = 600;
    shapel2Creator(1,pos.x+shift.copy().x,pos.y+shift.copy().y,scl,scl,12);
  }
}
class pebble extends entity{
  float scl;
  PVector pos;
  pebble(float x,float y,float scale){
    scl = scale;
    pos = new PVector(x,y);
  }
  void display(PVector shift){
    BASE_HEALTH = 200;
    pickable = true;
    shapel2Creator(3,pos.x+shift.copy().x,pos.y+shift.copy().y,scl,scl,16);
  }
}