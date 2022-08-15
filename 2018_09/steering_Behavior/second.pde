class element2{
  float max_force = 0.4;
  float max_speed = 3;

  PVector target = new PVector(random(width),random(height));
  PVector d_vel = new PVector(0,0);
  PVector steering = new PVector(0,0);

  PVector acc = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector pos = new PVector(0,0);
  element2(PVector p){
    pos = p;
  }
  void avoidBound(){
    if(pos.x>width-50){
      acc.x -= (50-(width-pos.x))*0.005;
    }else if(pos.x<50){
      acc.x += (50-(pos.x))*0.005;
    }if(pos.y>height-50){
      acc.y -= (50-(height-pos.y))*0.005;
    }else if(pos.y<50){
      acc.y += (50-(pos.y))*0.005;
    }
  }
  void steer(){
    PVector temp = target.copy();
    d_vel = ((temp.sub(pos)).mult(max_speed));
    steering = d_vel.copy().sub(vel);
    steering = truncate(steering,max_force);
    steering.mult(1/1);
    acc.add(steering);
  }
  void update(){
    vel.add(acc);
    vel = truncate(vel,max_speed);
    pos.add(vel);
    acc.mult(0);
  }
  void display(){
    if(debug){
      stroke(0,200,255);
      line(pos.x,pos.y,pos.x+vel.x*20,pos.y+vel.y*20);
      stroke(0,255,20);
      line(pos.x,pos.y,pos.x+d_vel.setMag(max_speed).x*30,pos.y+d_vel.setMag(max_speed).y*30);
    }
    noStroke();
    fill(255,0,0);
    //ellipse(target.x,target.y,10,10);
    float theta = this.vel.heading() + PI/2;
    noStroke();
    fill(255,200);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(theta);
    triangle(0,0,6,12,-6,12);
    popMatrix();
  }
}