PVector[] shape = new PVector[4];

public void setup(){
  size(600, 600);
  
  background(0);
  
  shape[0] = new PVector(100, 100);
  shape[1] = new PVector(100, 200);
  shape[2] = new PVector(200, 200);
  shape[3] = new PVector(200, 100);
  
  for(PVector v:shape){
    fill(255);
    //ellipse(v.x, v.y, 2, 2);
  }
  
  println(getHitboxRotation(shape));
  
  PVector[] moving = getHitboxPolygon(shape, new PVector(100, 0), (int)Math.signum(getHitboxRotation(shape)));
  println(moving.length);
  for(PVector v:moving){
    fill(255);
    ellipse(v.x, v.y, 2, 2);
  }
  
}

public PVector[] getHitboxPolygon(PVector[] points, PVector vel, int rot) {
  //creates polygon stretched in the direction of vel for better collisions
  
  //loop through vertices
  int[] entryRots = new int[points.length];
  PVector tail = points[points.length-1];
  for(int i = 0;i < points.length;i++) {
    //line(points[i].x, points[i].y, tail.x, tail.y);
    PVector segment = PVector.sub(points[i], tail).setMag(1);
    
    entryRots[i] = (int) Math.signum(vel.x*segment.y-vel.y*segment.x);
    if(entryRots[i] == 0){
      entryRots[i] =-rot;
    }
    tail = points[i];
  }
  //create polygon
  ArrayList<PVector> newPoints = new ArrayList<PVector>();
  for(int i = 0;i < entryRots.length;i++) {
    int lastIndex = i-1;
    if(lastIndex < 0) lastIndex = points.length+lastIndex;
    println(i+","+lastIndex);
    if(entryRots[i] != rot) {
      if(entryRots[i] != entryRots[lastIndex]) {
        newPoints.add(points[lastIndex]);
      }
      newPoints.add(points[i]);
    }else {
      if(entryRots[i] != entryRots[lastIndex]) {
        newPoints.add(PVector.add(points[lastIndex], vel));
      }
      newPoints.add(PVector.add(points[i], vel));
    }
  }
  PVector[] newPointsArr = new PVector[newPoints.size()];
  newPointsArr = newPoints.toArray(newPointsArr);
  for(int i = 0;i < newPointsArr.length;i++) {
    //newPointsArr[i].add(new PVector(this.x, this.y));
  }
  //System.out.println(newPoints.size());
  return newPointsArr;
}
private float getHitboxRotation(PVector[] points) {
  //finds the direction which the vertices follow
  //+ : anticlockwise
  //- : clockwise
  if(points.length<3) System.out.println("[Player]\t\tHitbox does not have enough vertices: "+Integer.toString(points.length));
  PVector avgPoint = new PVector(0, 0);
  for(PVector point:points) {
    avgPoint.add(point);
  }
  avgPoint.mult(1/(float)points.length);

  fill(255, 0, 0);
  //ellipse(avgPoint.x, avgPoint.y, 4, 4);

  PVector v1 = PVector.sub(points[0], avgPoint).setMag(1);
  PVector v2 = PVector.sub(points[1], avgPoint).setMag(1);
  
  stroke(255);
  //line(points[0].x, points[0].y, avgPoint.x, avgPoint.y);
  //line(points[1].x, points[1].y, avgPoint.x, avgPoint.y);
  
  float cross = v1.x*v2.y-v1.y*v2.x;
  
  return cross;
}