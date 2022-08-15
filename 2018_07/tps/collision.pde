public boolean collision(PVector c11,PVector c21,PVector c31,PVector c41,PVector c12,PVector c22,PVector c32,PVector c42){

  float q1x[] = {c11.x,c21.x,c31.x,c41.x};
  float q1y[] = {c11.y,c21.y,c31.y,c41.y};
  float q2x[] = {c12.x,c22.x,c32.x,c42.x};
  float q2y[] = {c12.y,c22.y,c32.y,c42.y};
  
  PVector v1x[] = {new PVector(0,0),new PVector(0,0),new PVector(0,0),new PVector(0,0)};
  PVector v2x[] = {new PVector(0,0),new PVector(0,0),new PVector(0,0),new PVector(0,0)};
  PVector v1y[] = {new PVector(0,0),new PVector(0,0),new PVector(0,0),new PVector(0,0)};
  PVector v2y[] = {new PVector(0,0),new PVector(0,0),new PVector(0,0),new PVector(0,0)};
  
  float v1ix[] = {0,0,0,0};
  float v2ix[] = {0,0,0,0};
  float v1iy[] = {0,0,0,0};
  float v2iy[] = {0,0,0,0};
  
  PVector oc1 = new PVector(q1x[0]-q1x[1],q1y[0]-q1y[1]).setMag(1);
  PVector oa1 = new PVector(q1x[0]-q1x[3],q1y[0]-q1y[3]).setMag(1);
  PVector oc2 = new PVector(q2x[0]-q2x[1],q2y[0]-q2y[1]).setMag(1);
  PVector oa2 = new PVector(q2x[0]-q2x[3],q2y[0]-q2y[3]).setMag(1);
  
  //calculates the newX and newY vector
  PVector newX = new PVector((oa1.x+oa2.x)/2,(oa1.y+oa2.y)/2).setMag(1);
  PVector newY = new PVector((oc1.x+oc2.x)/2,(oc1.y+oc2.y)/2).setMag(1);
  
  strokeWeight(0.5);
  stroke(0,255,0);
  //line(c11.x,c11.y,c11.x+newY.x*100,c11.y+newY.y*100);
  //calculates the projection to the newX and newY vectors
  for(int i = 0;i < q1x.length;i++){
    float d = q1x[i]*newX.x+q1y[i]*newX.y;
    //println(d,q1x[i],newX.x,q1y[i],newX.y);
    v1x[i] = newX.copy().mult(d);
  }
  for(int i = 0;i < q2x.length;i++){
    float d = q2x[i]*newX.x+q2y[i]*newX.y;
    //println(d,q2x[i],newX.x,q2y[i],newX.y);
    v2x[i] = newX.copy().mult(d);
  }
  for(int i = 0;i < q1x.length;i++){
    float d = q1x[i]*newY.x+q1y[i]*newY.y;
    v1y[i] = newY.copy().mult(d);
  }
  for(int i = 0;i < q2x.length;i++){
    float d = q2x[i]*newY.x+q2y[i]*newY.y;
    v2y[i] = newY.copy().mult(d);
  }  
  
  //creates a index of every point on the plane
  for(int i = 0;i < v1x.length;i++){
    PVector p = v1x[i];
    float temp = 0.5/p.x;
    if(p.x == 0){
      //println(temp);
      temp = 0;
    }
    v1ix[i] = temp + p.y;
  }
  for(int i = 0;i < v2x.length;i++){
    PVector p = v2x[i];
    float temp = 0.5/p.x; //<>//
    if(p.x == 0){ //<>//
      //println(temp);
      temp = 0; //<>//
    } //<>//
    v2ix[i] = temp + p.y; //<>//
  } //<>//
  for(int i = 0;i < v1y.length;i++){ //<>//
    PVector p = v1y[i]; //<>//
    float temp = 0.5/p.x;
    if(p.x == 0){
      //println(temp);
      temp = 0;
    }
    v1iy[i] = temp + p.y;
  }
  for(int i = 0;i < v2y.length;i++){
    PVector p = v2y[i];
    float temp = 0.5/p.x;
    if(p.x == 0){
      //println(temp);
      temp = 0;
    }
    v2iy[i] = temp + p.y;
  }
  
  //finding min and max of the rectangles along vecter newX and newY
  float Minx1 = v1ix[0];
  float Minx2 = v2ix[0];
  float Miny1 = v1iy[0];
  float Miny2 = v2iy[0];
  
  float Maxx1 = v1ix[0];
  float Maxx2 = v2ix[0];
  float Maxy1 = v1iy[0];
  float Maxy2 = v2iy[0];
  
  for(int i = 0;i < v1ix.length;i++){
    if(v1ix[i]<Minx1){
      Minx1 = v1ix[i];
    }else if(v1ix[i]>Maxx1){
      Maxx1 = v1ix[i];
    }
  }
  for(int i = 0;i < v2ix.length;i++){
    if(v2ix[i]<Minx2){
      Minx2 = v2ix[i];
    }else if(v2ix[i]>Maxx2){
      Maxx2 = v2ix[i];
    }
  }
  for(int i = 0;i < v1iy.length;i++){
    if(v1iy[i]<Miny1){
      Miny1 = v1iy[i];
    }else if(v1iy[i]>Maxy1){
      Maxy1 = v1iy[i];
    }
  }
  for(int i = 0;i < v2iy.length;i++){
    if(v2iy[i]<Miny2){
      Miny2 = v2iy[i];
    }else if(v2iy[i]>Maxy2){
      Maxy2 = v2iy[i];
    }
  }
  
  // checking for overlap
  boolean overlapX = false;
  boolean overlapY = false;
  
  //println(Minx1,Maxx2,Maxx1,Minx2,c11.x,c11.y);
  if(Minx1<Maxx2&&Maxx1>Minx2){
    overlapX = true;
  }
  //println(Miny1,Maxy2,Maxy1,Miny2);
  if(Miny1<Maxy2&&Maxy1>Miny2){
    overlapY = true;
  }    
  //for(PVector p:v1x){
  //  strokeWeight(3);
  //  stroke(255,0,0);
  //  point(p.x,p.y+60);
  //}
  //for(PVector p:v2x){
  //  strokeWeight(3);
  //  stroke(0,255,0);
  //  point(p.x,p.y+60);
  //}
  //for(PVector p:v1y){
  //  strokeWeight(3);
  //  stroke(255,0,255);
  //  point(p.x+60,p.y);
  //}
  //for(PVector p:v2y){
  //  strokeWeight(3);
  //  stroke(0,0,255);
  //  point(p.x+60,p.y);
  //}
  if(overlapX == true && overlapY == true){
    //println(overlapX,overlapY,c11.x,c11.y);
    return true;
  }
  return false;
}