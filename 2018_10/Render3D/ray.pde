class ray{
  
  float angle;
  float xToSpawn;
  PVector dir, pos;
  
  ray(PVector pos, PVector dir, float xToSpawn, float angle){
    this.pos = pos.copy();
    this.dir = dir.setMag(3);
    this.xToSpawn = xToSpawn;
    this.angle = angle;
  }
  
  public void update(){
    pos.add(dir);
  }
  
  public void render(){
    //stroke(255);
    //strokeWeight(20);
    //point(pos.x,pos.y);
  }
  
}