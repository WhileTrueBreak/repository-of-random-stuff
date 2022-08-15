class block{
  PVector pos;
  PVector dime = new PVector(10,10);
  block(PVector p){
    pos = p;
  }
  public void display(){
    fill(255,100);
    noStroke();
    rect(pos.x,pos.y,dime.x,dime.y);
  }
}