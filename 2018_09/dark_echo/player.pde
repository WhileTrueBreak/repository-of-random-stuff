class player{
  ArrayList<sound> sounds = new ArrayList();
  ArrayList<sound> removeS = new ArrayList();
  
  int strokeA = 0;
  int alphaMax = 100;
  
  int counter = 0;
  int actionDelay = 40;
  boolean nextAction = true;
  
  int counterS = 0;
  int stepDelay = 20;
  boolean nextStep = false;
  
  PVector acc = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector pos = new PVector(500,200);
  
  player(){
    
  }
  void display(PVector shift){
    fill(0);
    stroke(255,map(strokeA,0,100,40,100));
    ellipse(pos.x+shift.x,pos.y+shift.y,50,50);
    for(sound s:sounds){
      s.display(shift);
    }
  }
  void update(){
    if(counter > actionDelay){
      nextAction = true;
    }else{
      counter++;
    }
    
    if(counterS > stepDelay){
      nextStep = true;
    }else{
      counterS++;
    }
    
    for(sound s:sounds){
      s.update();
      if(s.gone()){
        removeS.add(s);
      }
    }
    sounds.removeAll(removeS);
    vel.add(acc);
    if(shift){
      
      vel.limit(1);
    }else{
      vel.limit(2);
    }
    boolean hitx = false;
    boolean hity = false;
    for(wall w:walls){
      boolean collided = lineHit(w.pos1.x,w.pos1.y,w.pos2.x,w.pos2.y,pos.x,pos.y,26);
      if(collided){
        if(w.pos1.x-w.pos2.x!=0){
          float norm1 = sqrt(pow(vel.x,2)+pow(vel.y,2));
          float norm2 = sqrt(pow(w.pos1.x-w.pos2.x,2)+pow(w.pos1.y-w.pos2.y,2));
          
          PVector normVector1 = new PVector(vel.x/norm1,vel.y/norm1);
          PVector normVector2 = new PVector((w.pos2.x-w.pos1.x)/norm2,(w.pos2.y-w.pos1.y)/norm2);
          float dot = normVector1.x*normVector2.x+normVector1.y*normVector2.y;
          
          
          
          float theta;
          if(pos.y<(w.pos1.y-w.pos2.y)/(w.pos1.x-w.pos2.x)*(pos.x-w.pos1.x)+w.pos1.y){
            theta = 2*acos(dot);
          }else if(pos.y>(w.pos1.y-w.pos2.y)/(w.pos1.x-w.pos2.x)*(pos.x-w.pos1.x)+w.pos1.y){
            theta = -2*acos(dot);
          }else{
            theta = -2*acos(dot);
          }
          PVector newVel = new PVector(cos(theta)*vel.x-sin(theta)*vel.y,sin(theta)*vel.x+cos(theta)*vel.y);
          vel = newVel.copy().setMag(1);
        }else{
          vel.x *= -1;
        }
      }
    }
    pos.add(vel);
    acc.mult(0);
    vel.mult(0.9);
  }
  void checkKeys(){
    if(vel.mag()>0.1&&nextStep){
      strokeA = alphaMax;
    }else if(strokeA > 0){
      strokeA--;
    }
    if(!shift){
      if(up){
        acc.add(new PVector(0,-1));
      }
      if(down){
        acc.add(new PVector(0,1));
      }
      if(left){
        acc.add(new PVector(-1,0));
      }
      if(right){
        acc.add(new PVector(1,0));
      }
    }
    if(shift){
      if(up){
        acc.add(new PVector(0,-0.7));
      }
      if(down){
        acc.add(new PVector(0,0.7));
      }
      if(left){
        acc.add(new PVector(-0.7,0));
      }
      if(right){
        acc.add(new PVector(0.7,0));
      }
    }
    if(nextAction&&space){
      nextAction = false;
      counter = 0;
      for(int i = 0;i < 32;i++){
        sounds.add(new sound(150,150,PVector.fromAngle(radians((360/32)*i)),pos));
      }
    }else if(vel.mag()>1&&!shift){
      if(nextStep){
        nextStep=false;
        counterS = 0;
        for(int i = 0;i < 16;i++){
          sounds.add(new sound(100,150,PVector.fromAngle(radians((360/16)*i)),pos));
        }
      }
    }else if(vel.mag()>0.5){
      if(nextStep){
        nextStep=false;
        counterS = 0;
        for(int i = 0;i < 16;i++){
          sounds.add(new sound(65,150,PVector.fromAngle(radians((360/16)*i)),pos));
        }
      }
    }
  }
  //////////ALL CODE BELOW IS NOT MINE//////////
  boolean pointCircle(float px, float py, float cx, float cy, float r) {
    float distX = px - cx;
    float distY = py - cy;
    float distance = sqrt( (distX*distX) + (distY*distY) );
    if (distance <= r) {
      return true;
    }
    return false;
  }
  boolean linePoint(float x1, float y1, float x2, float y2, float px, float py) {
  
    float d1 = dist(px,py, x1,y1);
    float d2 = dist(px,py, x2,y2);
    float lineLen = dist(x1,y1, x2,y2);
    float buffer = 0.1;
    if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
      return true;
    }
    return false;
  }
  boolean lineHit(float x1, float y1, float x2, float y2, float cx, float cy, float r) {
  
    // is either end INSIDE the circle?
    // if so, return true immediately
    boolean inside1 = pointCircle(x1,y1, cx,cy,r);
    boolean inside2 = pointCircle(x2,y2, cx,cy,r);
    if (inside1 || inside2) return true;
  
    // get length of the line
    float distX = x1 - x2;
    float distY = y1 - y2;
    float len = sqrt( (distX*distX) + (distY*distY) );
  
    // get dot product of the line and circle
    float dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len,2);
  
    // find the closest point on the line
    float closestX = x1 + (dot * (x2-x1));
    float closestY = y1 + (dot * (y2-y1));
  
    // is this point actually on the line segment?
    // if so keep going, but if not, return false
    boolean onSegment = linePoint(x1,y1,x2,y2, closestX,closestY);
    if (!onSegment) return false;
    // get distance to closest point
    distX = closestX - cx;
    distY = closestY - cy;
    float distance = sqrt( (distX*distX) + (distY*distY) );
  
    if (distance <= r) {
      return true;
    }
    return false;
  }
}