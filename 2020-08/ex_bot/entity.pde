class Entity{
  float value;
  PVector pos;
  Entity(PVector pos, float value){
    this.pos = pos;
    this.value = value;
  }
  public void render(){
    noStroke();
    fill(map(value,-1,1,255,0),map(value,-1,1,0,255),0);
    ellipse(pos.x, pos.y, 5, 5);
  }
}
