class Particle{
  
  PVector pos, vel, acc;
  float mass, radius;
  
  Particle(PVector pos){
    this.pos = pos;
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    radius = 5;
    mass = 10;
  }
  
  void render(){
    fill(0);
    noStroke();
    ellipse(pos.x,pos.y,radius*2,radius*2);
  }
  
  void update(){
    vel.add(acc);
    update_vel();
    vel.mult(0.99);
    acc.mult(0);
  }
  
  void update_vel(){
    if(check_bounds(new PVector(pos.x + vel.x,pos.y))){
      pos.x += vel.x;
    }else{
      vel.x = -vel.x;
    }
    if(check_bounds(new PVector(pos.x,pos.y + vel.y))){
      pos.y += vel.y;
    }else{
      vel.y = -vel.y;
    }
  }
  
  void add_random(){
    PVector vector = new PVector(random(-0.002,0.002),random(-0.002,0.002));
    apply_force(vector);
  }
  
  void collide_particles(){
    for(Particle p:particles){
      if(p != this){
        float dist = dist(p.pos.x,p.pos.y,pos.x,pos.y);
        if(dist < radius + p.radius){
          PVector vector = new PVector(pos.x-p.pos.x,pos.y-p.pos.y);
          vector.setMag(0.5);
          apply_force(vector);
        }
        if(dist > radius + p.radius+1 && dist < radius + p.radius + 10){
          PVector vector = new PVector(pos.x-p.pos.x,pos.y-p.pos.y);
          vector.setMag(-0.02);
          //apply_force(vector);
        }
      }
    }
  }
  
  void apply_force(PVector force){
    acc.add(force);
  }
  
  boolean check_bounds(PVector pos){
    if(pos.x > radius&&pos.x < width-radius&&pos.y > radius&&pos.y < height-radius){
      return true;
    }
    return false;
  }
  
}