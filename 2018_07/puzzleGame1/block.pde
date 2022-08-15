class block extends entity{
  PVector pos;
  block(PVector pos_){
    pos = pos_;
  }
  boolean checkMoveable(PVector playerPos){
    if(up&&round(pos.y+10)==playerPos.y){
      for(wall part:walls){
        if(round(pos.y-10)==part.pos.y){
          return false;
        }
      }
    }
    if(down&&round(pos.y-10)==playerPos.y){
      for(wall part:walls){
        if(round(pos.y+10)==part.pos.y){
          return false;
        }
      }
    }
    if(right&&round(pos.x+10)==playerPos.x){
      for(wall part:walls){
        if(round(pos.x-10)==part.pos.x){
          return false;
        }
      }
    }
    if(left&&round(pos.x-10)==playerPos.x){
      for(wall part:walls){
        if(round(pos.x+10)==part.pos.x){
          return false;
        }
      }
    }
    return true;
  }
  void draw(){
    noStroke();
    fill(255,255,200);
    rect(pos.x,pos.y,20,20,5);
  }
}