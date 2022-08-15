class drawing{
  ArrayList<lineS>lines = new ArrayList();
  ArrayList<PVector>points = new ArrayList();
  drawing(){
    
  }
  void addPoint(PVector p){
    points.add(p);
  }
  void display(){
    for(PVector p:points){
      fill(255);
      noStroke();
      ellipse(p.x,p.y,5,5);
    }
    for(lineS l:lines){
      stroke(255);
      strokeWeight(1);
      line(l.start.x,l.start.y,l.end.x,l.end.y);
    }
  }
  void createLine(){
    lines = new ArrayList();
    PVector prev = new PVector(0,0);
    if(points.size()!=0){
      prev = points.get(points.size()-1);
    }
    for(PVector p:points){
      if(points.size()!=0){
        lines.add(new lineS(prev,p));
        prev = new PVector(p.x,p.y);
      }
    }
  }
  void clearPoints(){
    lines = new ArrayList();
    points = new ArrayList();
  }
}