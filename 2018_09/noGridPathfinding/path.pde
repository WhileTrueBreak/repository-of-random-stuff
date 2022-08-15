class path{
  ArrayList<dmarker> path = new ArrayList();
  
  ArrayList<marker>dMarkers = new ArrayList();
  ArrayList<marker>markers = new ArrayList();
  
  PVector start;
  PVector fin;
  
  marker current;
  path(PVector s, PVector f){
    start = s;
    fin = f;
    markers.add(new marker(start.copy(),2,0));
    path.add(new dmarker(s.copy(),0));
    current = markers.get(0);
  }
  public void display(){
    float size = 2;
    noStroke();
    for(marker m:markers){
      if(m.state == 1){
        fill(100,255,160);
        ellipse(m.pos.x,m.pos.y,3,3);
      }else if(m.state == 2){
        fill(100,255,160);
        ellipse(m.pos.x,m.pos.y,10,10);
      }else if(m.state == 3){
        fill(160,255,255);
        ellipse(m.pos.x,m.pos.y,size,size);
      }
      fill(255,0,0);
      ellipse(fin.x,fin.y,5,5);
    }
  }
  public boolean rayToFin(ArrayList<block> blocks){
    for(marker m:markers){
      if(m.state == 2){
        boolean hit = false;
        ray r = new ray(m.pos,fin.copy().sub(m.pos).setMag(0.1));
        while(!hit){
          if(dist(fin.x,fin.y,r.pos.x,r.pos.y)<0.2){
            if(dist(fin.x,fin.y,path.get(path.size()-1).pos.x,path.get(path.size()-1).pos.y)>0.2){
              path.add(new dmarker(fin.copy(),m.num));
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
      }
    }
    return false;
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
  public void checkCrowd(){
    for(marker m:dMarkers){
      for(marker m1:markers){
        if(m1.state == 3){
          if(dist(m1.pos.x,m1.pos.y,m.pos.x,m.pos.y)<30&&abs(m.num-m1.num)>2){
            m.state = 1;
            m1.state = 1;
          }
        }
      }
    }
    for(marker m:markers){
      if(m.state == 2){
        current = m;
      }
      if(m.state == 3){
        for(marker m1:markers){
          if(m1.state == 3){
            if(dist(m1.pos.x,m1.pos.y,m.pos.x,m.pos.y)<30&&abs(m.num-m1.num)>2){
              m.state = 1;
              m1.state = 1;
            }
          }
        }
      }
    }
  }
  public void removeUseless(){
    ArrayList<marker>markersToRemove = new ArrayList();
    for(marker m:markers){
      if(m.state == 1){
        markersToRemove.add(m);
      }
    }
    markers.removeAll(markersToRemove);
  }
  public void removeCrowd(){
    ArrayList<marker>markersToRemove = new ArrayList();
    for(marker m:markers){
      if(m.state == 3){
        for(marker m1:markers){
          if(m1.state == 3){
            if(dist(m1.pos.x,m1.pos.y,m.pos.x,m.pos.y)<5&&m1 != m){
              markersToRemove.add(m1);
            }
          }
        }
        m.state = 3;
      }
    }
    if(markersToRemove.size()!=0){
      fill(255,0,0,100);
      ellipse(markersToRemove.get(markersToRemove.size()-1).pos.x,markersToRemove.get(markersToRemove.size()-1).pos.y,20,20);
    }
    markers.removeAll(markersToRemove);
  }
  public void moveDoneM(){
    ArrayList<marker>markersToRemove = new ArrayList();
    for(marker m:markers){
      if(m.state == 1){
        dMarkers.add(m);
        markersToRemove.add(m);
      }
    }
    markers.removeAll(markersToRemove);
  }
  public void rayC(ArrayList<block> blocks){
    ArrayList<marker>markersToAdd = new ArrayList();
    for(marker m:markers){
      if(m.state == 2){
        boolean allZ = false;
        ArrayList<ray>rays = new ArrayList();
        for(int i = 0;i < 32;i++){
          rays.add(new ray(m.pos,PVector.fromAngle(30*i).setMag(0.1f)));
        }
        while(!allZ){
          allZ = true;
          for(ray r:rays){
            if(r.t>0){
              boolean move = true;
              for(block b:blocks){
                if(r.pos.copy().add(r.dir).x>b.pos.x&&r.pos.copy().add(r.dir).x<b.pos.x+b.dime.y&&r.pos.copy().add(r.dir).y>b.pos.y&&r.pos.copy().add(r.dir).y<b.pos.y+b.dime.y){
                  r.t = -1;
                  move = false;
                }
              }
              if(r.pos.x>width||r.pos.x<0||r.pos.y>height||r.pos.y<0){
                r.t = -1;
                move = false;
              }
              if(move){
                r.pos.add(r.dir);
                r.t--;
              }
              allZ = false;
            }else if(r.t == 0){
              boolean add = true;
              for(marker m1:markers){
                if(m1 != m&&dist(m1.pos.x,m1.pos.y,m.pos.x,m.pos.y)<1.5){
                  add = false;
                }
              }
              if(add){
                markersToAdd.add(new marker(r.pos.copy(),3,m.num+1));
              }
              r.t--;
            }
          }
        }
        m.state = 1;
      }
    }
    markers.addAll(markersToAdd);
  }
  public void checkClosest(){
    marker closest = markers.get(0);
    float distC = width+height;
    for(marker m:markers){
      if(m.state == 3){
        //&&CheckPointBlocked(current.pos,new PVector(m.pos.x,m.pos.y),blocks)
        if(dist(m.pos.x,m.pos.y,fin.x,fin.y)<distC){
          distC = dist(m.pos.x,m.pos.y,fin.x,fin.y);
          closest = m;
        }
      }
    }
    path.add(new dmarker(closest.pos.copy(),closest.num));
    closest.state = 2;
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
          if(total > dist(PVpath[i].x,PVpath[i].y,PVpath[j].x,PVpath[j].y)*1.25){
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
          if(total > dist(PVpath[i].x,PVpath[i].y,PVpath[j].x,PVpath[j].y)*1.25){
            return;
          }
        }
      }
    }
  }
  public void removeIllegal(){
    ArrayList<dmarker>dmarkerR = new ArrayList();
    PVector[] PVpath = new PVector[path.size()];
    PVector lastLegal = start;
    for(int i = 0;i < path.size();i++){
      PVpath[i] = path.get(i).pos;
    }
    for(int i = 0;i < PVpath.length;i++){
      if(!CheckPointBlocked(PVpath[i],lastLegal,blocks)){
        dmarkerR.add(path.get(i));
      }else{
        lastLegal = PVpath[i];
      }
    }
    path.removeAll(dmarkerR);
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