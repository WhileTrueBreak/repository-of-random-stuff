class sound{
  int state = 0;
  
  float vol;
  float max;
  
  PVector vel = new PVector(0,0);
  PVector pos;
  
  PVector origin;
  
  sound(float strength,float m, PVector direction, PVector start){
    max = m;
    vol = strength;
    pos = start.copy();
    vel = direction.setMag(5).copy();
    origin = start.copy();
  }
  
  void display(PVector shift){
    if(state == 0){
      fill(255,map(vol,0,max,0,255));
    }
    if(state == 1){
      fill(255,0,0,map(vol,0,max,0,255));
    }
    noStroke();
    ellipse(pos.x+shift.x,pos.y+shift.y,5,5);
  }
  
  void update(){
    for(wall w:walls){
      boolean collided = lineHit(w.pos1.x,w.pos1.y,w.pos2.x,w.pos2.y,pos.x,pos.y,6);
      if(collided){
        if(w.pos1.x-w.pos2.x!=0){
          float norm1 = sqrt(pow(vel.x,2)+pow(vel.y,2));
          float norm2 = sqrt(pow(w.pos2.x-w.pos1.x,2)+pow(w.pos2.y-w.pos1.y,2));
        
          PVector normVector1 = new PVector(vel.x/norm1,vel.y/norm1);
          PVector normVector2 = new PVector((w.pos2.x-w.pos1.x)/norm2,(w.pos2.y-w.pos1.y)/norm2);
          float dot = normVector1.x*normVector2.x+normVector1.y*normVector2.y;
          
          float theta = -2*acos(dot);
          if(pos.y<(w.pos1.y-w.pos2.y)/(w.pos1.x-w.pos2.x)*(pos.x-w.pos1.x)+w.pos1.y){
            theta = 2*acos(dot);
          }else if(pos.y>(w.pos1.y-w.pos2.y)/(w.pos1.x-w.pos2.x)*(pos.x-w.pos1.x)+w.pos1.y){
            theta = -2*acos(dot);
          }else{
            theta = -2*acos(dot);
          }
          PVector newVel = new PVector(cos(theta)*vel.x-sin(theta)*vel.y,sin(theta)*vel.x+cos(theta)*vel.y);
          //println(w.pos2.x-w.pos1.x/norm2);
          vel = newVel.copy().setMag(5);
        }else{
          vel.x *= -1;
        }
      }
    }
    pos.add(vel);
    vol--;
    for(enemy e:enemies){
      if(dist(pos.x,pos.y,e.pos.x,e.pos.y)<40){
        state = 1;
        if(e.target!=origin){
          e.target = origin;
        }
      }
    }
  }
  
  boolean gone(){
    if(vol <= 0){
      return true;
    }
    return false;
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