class pointMap{
  point cNode;
  ArrayList<dmarker> path = new ArrayList();
  
  ArrayList<point>points = new ArrayList();
  
  PVector start;
  PVector fin;
  
  pointMap(PVector s, PVector f){
    
    points.add(new point(s.copy(),2));
    cNode = points.get(0);
    path.add(new dmarker(s.copy()));
    points.add(new point(f.copy(),0));
    
    for(int i = 0;i < 200;i++){
      PVector tesPos = new PVector(random(width),random(height));
      boolean allowed = true;
      for(block b:blocks){
        if(tesPos.x>b.pos.x&&tesPos.x<b.pos.x+b.dime.y&&tesPos.y>b.pos.y&&tesPos.y<b.pos.y+b.dime.y){
          allowed = false;
        }
      }
      if(allowed){
        println("point added at " + str(tesPos.x) + " " + str(tesPos.y));
        points.add(new point(tesPos,0));
      }else{
        println("There was a block at " + str(tesPos.x) + " " + str(tesPos.y));
      }
    }
    
    start = s;
    fin = f;
    
    for(point p:points){
      p.distToFin = dist(p.pos.x,p.pos.y,fin.x,fin.y);
      p.distFromC = dist(p.pos.x,p.pos.y,cNode.pos.x,cNode.pos.y);
      println("Dist to finish is " + str(p.distToFin));
    }
  }
  public void updateFromC(){
    for(point p:points){
      p.distFromC = dist(p.pos.x,p.pos.y,cNode.pos.x,cNode.pos.y);
    }
  }
  public void roundC(){
    for(point p1:points){
      for(point p2:cNode.reachable){
        if(p1 == p2&&p1.state != 1){
          p1.state = 3;
        }
      }
    }
  }
  public int cNodeIndex(){
    for(point p:points){
      if(p == cNode){
        return points.indexOf(p);
      }
    }
    return 0;
  }
  public void checkAllReachable(){
    for(point p1:points){
      for(point p2:points){
        if(dist(p1.pos.x,p1.pos.y,p2.pos.x,p2.pos.y)<200){
          if(p1 != p2&&CheckPointBlocked(p1.pos,p2.pos,blocks)){
            println("From " + str(p1.pos.x) + " " + str(p1.pos.y) + " to " + str(p2.pos.x) + " " + str(p2.pos.y) + " is not blocked");
            p1.reachable.add(p2);
          }else{
            println("From " + str(p1.pos.x) + " " + str(p1.pos.y) + " to " + str(p2.pos.x) + " " + str(p2.pos.y) + " is blocked");
          }
        }else{
          //println("From " + str(p1.pos.x) + " " + str(p1.pos.y) + " to " + str(p2.pos.x) + " " + str(p2.pos.y) + " is too long");
        }
      }
    }
  }
  public boolean CheckPointBlocked(PVector p1, PVector p2,ArrayList<block> blocks){
    boolean hit = false;
    ray r = new ray(p1,p2.copy().sub(p1).setMag(0.1));
    while(!hit){
      if(dist(p2.x,p2.y,r.pos.x,r.pos.y)<0.2){
        return true;
      }
      for(block b:blocks){
        if(dist(b.pos.x,b.pos.y,r.pos.x,r.pos.y)<100){
          if(r.pos.copy().add(r.dir).x>b.pos.x&&r.pos.copy().add(r.dir).x<b.pos.x+b.dime.y&&r.pos.copy().add(r.dir).y>b.pos.y&&r.pos.copy().add(r.dir).y<b.pos.y+b.dime.y){
            r.t = -1;
            hit = true;
            break;
          }
        }
      }
      if(r.pos.x>width||r.pos.x<0||r.pos.y>height||r.pos.y<0){
        r.t = -1;
        hit = true;
        break;
      }
      r.pos.add(r.dir);
    }
    return false;
  }
  public void displayPoint(){
    for(point p:points){
      p.display();
    }
    fill(255,0,0);
    ellipse(cNode.pos.x,cNode.pos.y,10,10);
  }
  public void checkClosest(){
    float closestDist = (width+height)*2;
    point best = points.get(0);
    for(point p:points){
      //+p.distFromC
      if(p.state == 3&&(p.distToFin)<closestDist&&p != cNode){
        closestDist = p.distToFin;
        best = p;
      }
    }
    points.get(cNodeIndex()).state = 1;
    cNode = best;
    path.add(new dmarker(best.pos.copy()));
  }
  public boolean rayToFin(ArrayList<block> blocks){
    boolean hit = false;
    ray r = new ray(cNode.pos,fin.copy().sub(cNode.pos).setMag(0.1));
    while(!hit){
      if(dist(fin.x,fin.y,r.pos.x,r.pos.y)<0.2){
        if(dist(fin.x,fin.y,path.get(path.size()-1).pos.x,path.get(path.size()-1).pos.y)>0.2){
          path.add(new dmarker(fin.copy()));
        }
        return true;
      }
      for(block b:blocks){
        if(r.pos.copy().add(r.dir).x>b.pos.x&&r.pos.copy().add(r.dir).x<b.pos.x+b.dime.y&&r.pos.copy().add(r.dir).y>b.pos.y&&r.pos.copy().add(r.dir).y<b.pos.y+b.dime.y){
          r.t = -1;
          hit = true;
          break;
        }
      }
      if(r.pos.x>width||r.pos.x<0||r.pos.y>height||r.pos.y<0){
        r.t = -1;
        hit = true;
        break;
      }
      r.pos.add(r.dir);
    }
    return false;
  }
  public void optPath(){
    ArrayList<dmarker>dmarkerR = new ArrayList();
    PVector[] PVpath = new PVector[path.size()];
    for(int i = 0;i < path.size();i++){
      PVpath[i] = path.get(i).pos;
    }
    for(int i = 0;i < PVpath.length;i++){
      for(int j = 0;j < i;j++){
        if(CheckPointBlocked(PVpath[i],PVpath[j],blocks)){
          float total = 0;
          for(int k = j;k < i;k++){
            total += dist(PVpath[k].x,PVpath[k].y,PVpath[k+1].x,PVpath[k+1].y);
          }
          if(total > dist(PVpath[i].x,PVpath[i].y,PVpath[j].x,PVpath[j].y)){
            for(int k = i-1;k > j;k--){
              println("from " + str(i) + " to " + str(j));
              println("removing " + str(k));
              dmarkerR.add(path.get(k));
            }
          }
          if(total > dist(PVpath[i].x,PVpath[i].y,PVpath[j].x,PVpath[j].y)){
            stroke(255);
            strokeWeight(1);
            line(PVpath[i].x,PVpath[i].y,PVpath[j].x,PVpath[j].y);
          }
          path.removeAll(dmarkerR);
          if(total > dist(PVpath[i].x,PVpath[i].y,PVpath[j].x,PVpath[j].y)){
            return;
          }
        }
      }
    }
  }
  public void displayP(){
    stroke(255,0,0);
    strokeWeight(5);
    noFill();
    beginShape();
    for(dmarker dm:path){
      vertex(dm.pos.x,dm.pos.y);
      fill(255);
      ellipse(dm.pos.x,dm.pos.y,15,15);
      noFill();
    }
    endShape();
  }
}