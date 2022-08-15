int reflectionLimit = 2;
float rayLength;

ArrayList<RayObject>rayObjects = new ArrayList<RayObject>();

ArrayList<Ray>rays = new ArrayList<Ray>();

void setup(){
  size(800, 600);
  
  rayLength = dist(0, 0, width, height)*100;
  
  for(int i=0;i<360;i++){
    rayObjects.add(new RayMirror(width/2*sin(i*PI/180)+width/2,height/2*cos(i*PI/180)+height/2,width/2*sin((i-1)*PI/180)+width/2,height/2*cos((i-1)*PI/180)+height/2));
  }
  
  
  //rayObjects.add(new RayRotate(300, 800, 300, 0, 45));
  //rayObjects.add(new RayRotate(500, 0, 500, 800, 45));
  //rayObjects.add(new RayMirror(700, 0, 700, 800));
  
}

void draw(){
  background(0);
  for(int i = 0;i < 360;i+=2){
    rays.add(new Ray(mouseX, mouseY, i*PI/180, rayLength));
    rays.get(rays.size()-1).updateRayObjects(rayObjects);
  }
  for(Ray r:rays){
    r.update();
    r.render();
  }
  rays = new ArrayList<Ray>();
  
  for(RayObject ro:rayObjects){
    ro.render();
  }
  fill(255, 0, 0);
  text((int)frameRate, width-20, 10);
}
