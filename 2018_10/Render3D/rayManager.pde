class rayManager{
  
  ArrayList<ray> rays;
  
  handler h;
  
  rayManager(handler h){
    this.h = h;
    rays = new ArrayList();
  }
  
  public void update(){
    for(ray r:rays){
      PVector startPos = r.pos.copy();
      boolean reached = false;
      while(!reached){
        r.update();
        if(dist(startPos.x,startPos.y,r.pos.x,r.pos.y) > 400){
          h.g.b3dm.add3DBlock(new block3D(r.xToSpawn, 400, 1000,sin(radians(r.angle))*400));
          reached = true;
          continue;
        }
        boolean hit = false;
        int count = 0;
        PVector pointCol = new PVector(0,0);
        for(line l:h.g.lm.lines){
          if(lineLine(l.p1,l.p2,startPos,r.pos)&&!hit){
            pointCol = lineLineCol(l.p1,l.p2,startPos,r.pos);
            count++;
            hit = true;
          }
        }
        if(count>0){
          h.g.b3dm.add3DBlock(new block3D(r.xToSpawn, dist(startPos.x,startPos.y,pointCol.x,pointCol.y), 1000,sin(radians(r.angle))*dist(startPos.x,startPos.y,pointCol.x,pointCol.y)));
          reached = true;
          continue;
        }
      }
      if(!view3d){
        stroke(255,0,0);
        strokeWeight(1);
        line(startPos.x,startPos.y,r.pos.x,r.pos.y);
      }
    }
    rays = new ArrayList();
  }
  
  public void render(){
    for(ray r:rays){
      r.render();
    }
  }
  
  public void addRay(ray r){
    rays.add(r);
  }
  
  public boolean lineLine(PVector p1,PVector p2,PVector p3,PVector p4) {
    float uA = ((p4.x-p3.x)*(p1.y-p3.y) - (p4.y-p3.y)*(p1.x-p3.x)) / ((p4.y-p3.y)*(p2.x-p1.x) - (p4.x-p3.x)*(p2.y-p1.y));
    float uB = ((p2.x-p1.x)*(p1.y-p3.y) - (p2.y-p1.y)*(p1.x-p3.x)) / ((p4.y-p3.y)*(p2.x-p1.x) - (p4.x-p3.x)*(p2.y-p1.y));
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      return true;
    }
    return false;
  }
  
  PVector lineLineCol(PVector p1,PVector p2,PVector p3,PVector p4) {
    float uA = ((p4.x-p3.x)*(p1.y-p3.y) - (p4.y-p3.y)*(p1.x-p3.x)) / ((p4.y-p3.y)*(p2.x-p1.x) - (p4.x-p3.x)*(p2.y-p1.y));
    float uB = ((p2.x-p1.x)*(p1.y-p3.y) - (p2.y-p1.y)*(p1.x-p3.x)) / ((p4.y-p3.y)*(p2.x-p1.x) - (p4.x-p3.x)*(p2.y-p1.y));
    return new PVector(p1.x + (uA * (p2.x-p1.x)), p1.y + (uA * (p2.y-p1.y)));
  }
}