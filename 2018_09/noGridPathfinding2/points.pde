class point{
  int state;
  float distFromC;
  float distToFin;
  PVector pos;
  ArrayList<point>reachable = new ArrayList();
  point(PVector p,int s){
    pos = p;
    state = s;
  }
  public void display(){
    if(state == 0){
      fill(255);
    }else if(state == 3){
      fill(160,255,255);
    }else if(state == 2){
      fill(100,255,160);
    }
    noStroke();
    ellipse(pos.x,pos.y,5,5);
    for(point p:reachable){
      stroke(255);
      strokeWeight(1);
      line(pos.x,pos.y,p.pos.x,p.pos.y);
    }
    fill(255,0,0);
    text(state,pos.x,pos.y);
  }
}