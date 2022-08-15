class Player{
  final float MAX_SLOPE_ANGLE = 45;
  final float SPEED = 4;
  final float JUMP_FORCE = 20;
  
  boolean onGround = true;
  
  float vx, vy;
  float x, y, r;
  
  Player(float x, float y, float r){
    this.x = x;
    this.y = y;
    this.r = r;
    
    this.vx = 0;
    this.vy = 0;
  }
  
  void render(){
    noStroke();
    fill(255);
    ellipse(x, y, r*2, r*2);
  }
  
  void update(){
    //apply forces
    if(left) vx-=SPEED;
    if(right) vx+=SPEED;
    if(up&&onGround){
      vy-=JUMP_FORCE;
      onGround = false;
    }else vy+=GRAVITY;
    if(abs(vx) > SPEED) vx = SPEED*Math.signum(vx);
    //update temp position
    float tx = x+vx;
    float ty = y+vy;
    onGround = false;
    //check and update velocities
    for(Cline l:lines){
      boolean collided = false;
      //check if line line collision exist
      if(lineLine(l.x1, l.y1, l.x2, l.y2, tx, ty, x, y)!=null){
        collided = true;
      }
      //check if line circle collision exist
      if(lineCircle(l.x1, l.y1, l.x2, l.y2, tx, ty, r)){
        collided = true;
      }
      if(collided){
        println("Collided");
        //get collision normal
        float perpendicularGrad = -1/l.grad;
        float lineAngle = atan2(perpendicularGrad,1);
        PVector collisionNormal = PVector.fromAngle(lineAngle);
        float dot = collisionNormal.dot(new PVector(vx, vy));
        collisionNormal.setMag(Math.signum(dot));
        //get slope angle
        double slopeAngle = abs(degrees(atan2(l.grad,1)));
        //if collision is b=happening from underneath
        if(y-l.y1>l.grad*(x-l.x1)) slopeAngle+=180;
        //if slope is angle less than max angle
        if(slopeAngle < MAX_SLOPE_ANGLE){
          //set on ground to true
          onGround = true;
          vy = 0;
        }
        //get new velocity vector
        PVector v = slide(collisionNormal, new PVector(vx, vy));
        //update variables
        vx = v.x;
        vy = v.y;
        tx = x+vx;
        ty = y+vy;
      }
    }
    //update position with correct velocity
    x += vx;
    y += vy;
    //apply friction
    if(onGround)vx *= 0;
    else vx *= 0.8;
  }
  
  PVector slide(PVector n, PVector v){
    //dot product of normal and v
    float dot = n.dot(v);
    //return v subtract normal multiplied by the dot product
    return v.copy().sub(n.copy().mult(dot));
  }
}
