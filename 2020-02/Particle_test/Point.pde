class Point{
  
  PVector pos, vel;
  
  int life;
  
  public Point(float x, float y, float vx, float vy, int life){
    this.pos = new PVector(x, y);
    this.vel = new PVector(vx, vy);
    this.life = life;
  }
  public void update(){
    life--;
    pos.add(vel);
    vel.mult(0.99);
  }
  
  public void render(){
    noStroke();
    fill(71, 237, 149);
    //ellipse(pos.x, pos.y, 5, 5);
  }
  
  public boolean isDead(){
    if(life<=0) return true;
    return false;
  }
  
}
