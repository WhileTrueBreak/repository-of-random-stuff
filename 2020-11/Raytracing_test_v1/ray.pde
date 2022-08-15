class Ray{
  //the object the ray ends on
  RayObject endRayObject;
  //the next ray if required
  Ray ray;
  //distance of the ray
  float dist;
  //previous object the ray collided with
  RayObject prevCollision;
  //all ray objects
  ArrayList<RayObject>rayObjects;
  float x1, y1, x2, y2, theta;
  //current iteration of the ray
  int layer;
  //first ray initialization of the ray
  public Ray(float x,  float y, float theta, float dist){
    rayObjects = new ArrayList<RayObject>();
    this.dist = dist;
    this.x1 = x;
    this.y1 = y;
    this.x2 = x+dist*cos(theta);
    this.y2 = y+dist*sin(theta);
    this.theta = theta;
    this.ray = null;
    this.layer = 1;
  }
  
  public Ray(float x,  float y, float theta, float dist, int layer){
    rayObjects = new ArrayList<RayObject>();
    this.dist = dist;
    this.x1 = x;
    this.y1 = y;
    this.x2 = x+dist*cos(theta);
    this.y2 = y+dist*sin(theta);
    this.theta = theta;
    this.ray = null;
    this.layer = layer;
  }
  
  public void render(){
    stroke(0, 255, 255);
    line(x1, y1, x2, y2);
    if(ray!=null){
      ray.render();
    }
  }
  
  public void update(){
    //get collision
    RayObject closestCollision = getClosestCollision();
    float pointDistance = dist;
    //check if collision exists
    if(closestCollision != null){
      //get distance to collision
      PVector collisionPoint = lineLine(closestCollision.getX1(), closestCollision.getY1(), closestCollision.getX2(), closestCollision.getY2(), x1, y1, x2, y2);
      pointDistance = dist(x1, y1, collisionPoint.x, collisionPoint.y);
    }
    //if collision is mirror and not at iteration limit create reflected ray
    if(layer < reflectionLimit){
      if(closestCollision instanceof RayMirror){
        ray = getReflectedRay(closestCollision, dist-pointDistance);
      }else if(closestCollision instanceof RayRotate){
        ray = getRotatedRay((RayRotate)closestCollision, dist-pointDistance);
      }
    }
    //set new distance
    dist = pointDistance;
    //update x2 and y2
    x2 = x1+pointDistance*cos(theta);
    y2 = y1+pointDistance*sin(theta);
    //update next ray if exist
    if(ray!=null) ray.update();
  }
  
  private Ray getRotatedRay(RayRotate reflectObject, float remainingDistance){
    //get side
    //get a, b, c in ax+by=c
    float a = reflectObject.getY1()-reflectObject.getY2();
    float b = reflectObject.getX2()-reflectObject.getX1();
    float c = -(reflectObject.getX1()*reflectObject.getY2()-reflectObject.getX2()*reflectObject.getY1());
    //get Collision point
    PVector collisionPoint = lineLine(reflectObject.getX1(), reflectObject.getY1(), reflectObject.getX2(), reflectObject.getY2(), x1, y1, x2, y2);
    //create ray
    Ray newRay;
    //check if ray is from left or right
    if(a*this.x1+b*this.y1<c){
      //right
      newRay = new Ray(collisionPoint.x, collisionPoint.y, theta+reflectObject.getAngle()*PI/180, remainingDistance, layer+1);
    }else{
      //left
      newRay = new Ray(collisionPoint.x, collisionPoint.y, theta-reflectObject.getAngle()*PI/180, remainingDistance, layer+1);
    }
    //initialise variables
    newRay.updateRayObjects(rayObjects);
    newRay.setPrevCollision(reflectObject);
    return newRay;
  }
  
  private Ray getReflectedRay(RayObject reflectObject, float remainingDistance){
    //get normal of reflected object
    float gradient = (reflectObject.getY2()-reflectObject.getY1())/(reflectObject.getX2()-reflectObject.getX1());
    float normalGradient = -1/gradient;
    float angle = atan(normalGradient);
    PVector normal = new PVector(cos(angle), sin(angle));
    
    //render normal
    PVector collisionPoint = lineLine(reflectObject.getX1(), reflectObject.getY1(), reflectObject.getX2(), reflectObject.getY2(), x1, y1, x2, y2);
    stroke(255,255,0);
    //line(collisionPoint.x, collisionPoint.y, collisionPoint.x+normal.x*100, collisionPoint.y+normal.y*100);
    
    //get reflected ray
    PVector normalizedRay = new PVector(cos(theta), sin(theta));
    float dot = normalizedRay.x*normal.x+normalizedRay.y*normal.y;
    normal = normal.mult(dot*2);
    normal = normalizedRay.sub(normal);
    
    //stroke(255,0,0);
    //line(collisionPoint.x, collisionPoint.y, collisionPoint.x+normal.x*100, collisionPoint.y+normal.y*100);
    
    //get angle of reflected vector
    angle = atan2(normal.y, normal.x);
    
    //create new ray
    Ray newRay = new Ray(collisionPoint.x, collisionPoint.y, angle, remainingDistance, layer+1);
    //initialise variables
    newRay.updateRayObjects(rayObjects);
    newRay.setPrevCollision(reflectObject);
    return newRay;
  }
  
  public RayObject getClosestCollision(){
    RayObject closest = null;
    float recordDist = (float) Double.POSITIVE_INFINITY;
    for(RayObject ro:rayObjects){
      if(ro == prevCollision) continue;
      PVector collisionPoint = lineLine(ro.getX1(), ro.getY1(), ro.getX2(), ro.getY2(), x1, y1, x2, y2);
      if(collisionPoint == null) continue;
      float pointDistance = dist(x1, y1, collisionPoint.x, collisionPoint.y);
      if(pointDistance < recordDist){
        closest = ro;
        recordDist = pointDistance;
      }
    }
    return closest;
  }
  
  public void updateRayObjects(ArrayList<RayObject>rayObjects){
    this.rayObjects = rayObjects;
  }
  
  public void setPrevCollision(RayObject prevCollision){
    this.prevCollision = prevCollision;
  }
  
}
