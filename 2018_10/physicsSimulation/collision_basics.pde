boolean circleLine(PVector c1, PVector l1, PVector l2, float r){//circle and line collision
  float d1 = dist(c1.x, c1.y, l1.x, l1.y);
  float d2 = dist(c1.x, c1.y, l2.x, l2.y);
  if(d1 <= r||d2 <= r){
    return true;
  }
  PVector a = new PVector(c1.x-l1.x,c1.y-l1.y);
  PVector b = new PVector(l2.x-l1.x,l2.y-l1.y);
  float m1 = sqrt(pow(a.x,2)+pow(a.y,2));
  float m3 = cos(PVector.angleBetween(a,b))*m1;
  PVector c = b.copy().setMag(m3);
  PVector closestPoint = l1.copy().add(c);
  if(!pointLine(l1, l2, closestPoint)){
    return false;
  }
  return circlePoint(c1, closestPoint, r);
}

boolean pointLine(PVector l1, PVector l2, PVector p1){//poitn and line collision
  float d1 = dist(l1.x, l1.y, p1.x, p1.y);
  float d2 = dist(l2.x, l2.y, p1.x, p1.y);
  float totalDist = dist(l1.x,l1.y,l2.x,l2.y);
  float buffer = 0.1;
  return d1+d2<=totalDist+buffer;
}

boolean circlePoint(PVector c1, PVector p1, float r){//circle and point collision
  float d1 = dist(c1.x, c1.y, p1.x, p1.y);
  return d1 <= r;
}