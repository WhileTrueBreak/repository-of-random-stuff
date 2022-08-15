class Settlement{
  
  private PVector pos;
  
  private ArrayList<Settlement>connected;
  
  public Settlement(PVector pos){
    this.pos = pos;
    this.connected = new ArrayList<Settlement>();
  }
  
  public void render(float cP){
    fill(0,255,0);
    noStroke();
    ellipse(this.pos.x*cP+camOffset.x, this.pos.y*cP+camOffset.y, cP*3, cP*3);
    for(Settlement connection:connected){
      stroke(165,42,42);
      strokeWeight(cP);
      line(this.pos.x*cP+camOffset.x, this.pos.y*cP+camOffset.y, connection.getPos().x*cP+camOffset.x, connection.getPos().y*cP+camOffset.y);
    }
  }
  
  public PVector getPos(){
    return pos;
  }
  
  public void setPos(PVector pos){
    this.pos = pos;
  }
  
  public ArrayList<Settlement> getConnected(){
    return connected;
  }
  
  public void setConnected(ArrayList<Settlement> connected){
    this.connected = connected;
  }
  
}
