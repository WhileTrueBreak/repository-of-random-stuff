ArrayList<Cube>cubes;
ArrayList<Plane>planes;

double angle = Math.PI/4;

void setup(){
  size(800,800);
  cubes = new ArrayList<Cube>();
  planes = new ArrayList<Plane>();
  //for(int i = 0;i < 20;i++){
  //    cubes.add(new Cube(random(-4,4),random(-5,-3),random(-4,4),1,1,1));
  //}
  int sides = 10;
  for(double i = 0;i < sides;i++){
    planes.add(new Plane(3*Math.cos(2*(i+0)/sides*Math.PI),0,3*Math.sin(2*(i+0)/sides*Math.PI),
                         3*Math.cos(2*(i+1)/sides*Math.PI),0,3*Math.sin(2*(i+1)/sides*Math.PI),
                         4*Math.cos(2*(i+0.5)/sides*Math.PI),1,4*Math.sin(2*(i+0.5)/sides*Math.PI)));
    planes.add(new Plane(4*Math.cos(2*(i+0.5)/sides*Math.PI),1,4*Math.sin(2*(i+0.5)/sides*Math.PI),
                         4*Math.cos(2*(i+1.5)/sides*Math.PI),1,4*Math.sin(2*(i+1.5)/sides*Math.PI),
                         3*Math.cos(2*(i+1)/sides*Math.PI),0,3*Math.sin(2*(i+1)/sides*Math.PI)));
    
    planes.add(new Plane(2*Math.cos(2*(i-0.5)/sides*Math.PI),1,2*Math.sin(2*(i-0.5)/sides*Math.PI),
                         2*Math.cos(2*(i+0.5)/sides*Math.PI),1,2*Math.sin(2*(i+0.5)/sides*Math.PI),
                         3*Math.cos(2*(i+0)/sides*Math.PI),0,3*Math.sin(2*(i+0)/sides*Math.PI)));
    planes.add(new Plane(3*Math.cos(2*(i+0)/sides*Math.PI),0,3*Math.sin(2*(i+0)/sides*Math.PI),
                         3*Math.cos(2*(i+1)/sides*Math.PI),0,3*Math.sin(2*(i+1)/sides*Math.PI),
                         2*Math.cos(2*(i+0.5)/sides*Math.PI),1,2*Math.sin(2*(i+0.5)/sides*Math.PI)));
    
    planes.add(new Plane(3*Math.cos(2*(i+0)/sides*Math.PI),3,3*Math.sin(2*(i+0)/sides*Math.PI),
                         3*Math.cos(2*(i+1)/sides*Math.PI),3,3*Math.sin(2*(i+1)/sides*Math.PI),
                         4*Math.cos(2*(i+0.5)/sides*Math.PI),1,4*Math.sin(2*(i+0.5)/sides*Math.PI)));
    planes.add(new Plane(4*Math.cos(2*(i+0.5)/sides*Math.PI),1,4*Math.sin(2*(i+0.5)/sides*Math.PI),
                         4*Math.cos(2*(i+1.5)/sides*Math.PI),1,4*Math.sin(2*(i+1.5)/sides*Math.PI),
                         3*Math.cos(2*(i+1)/sides*Math.PI),3,3*Math.sin(2*(i+1)/sides*Math.PI)));
    
    planes.add(new Plane(2*Math.cos(2*(i-0.5)/sides*Math.PI),1,2*Math.sin(2*(i-0.5)/sides*Math.PI),
                         2*Math.cos(2*(i+0.5)/sides*Math.PI),1,2*Math.sin(2*(i+0.5)/sides*Math.PI),
                         3*Math.cos(2*(i+0)/sides*Math.PI),3,3*Math.sin(2*(i+0)/sides*Math.PI)));
    planes.add(new Plane(3*Math.cos(2*(i+0)/sides*Math.PI),3,3*Math.sin(2*(i+0)/sides*Math.PI),
                         3*Math.cos(2*(i+1)/sides*Math.PI),3,3*Math.sin(2*(i+1)/sides*Math.PI),
                         2*Math.cos(2*(i+0.5)/sides*Math.PI),1,2*Math.sin(2*(i+0.5)/sides*Math.PI)));
  }
  cubes.add(new Cube(-500,3,-500,1000,1,1000));
  
  
}

void draw(){
  noStroke();
  background(0);
  double FOV = 60;
  double vertstep, hozstep;
  vertstep = 2*Math.sin(Math.toRadians(FOV)/2)/height;
  hozstep = 2*Math.sin(Math.toRadians(FOV)/2)/width; 
  ArrayList<Plane>planes = getPlanes();
  int start = millis();
  for(int i = 0;i < height;i++){
    for(int j = 0;j < width;j++){
      //looking location
      double yaw = angle;
      double pitch = Math.PI/6;
      
      double vertoff, hozoff;
      vertoff = vertstep*(i-height/2);
      hozoff = hozstep*(j-width/2);
      double projx, projy, projz;
      projx = Math.cos(yaw)*Math.cos(pitch)+hozoff*(Math.cos(yaw+Math.PI/2)*Math.cos(pitch))+vertoff*(Math.cos(yaw)*Math.cos(pitch+Math.PI/2));
      projy = Math.sin(pitch)+vertoff*Math.sin(pitch+Math.PI/2);
      projz = Math.sin(yaw)*Math.cos(pitch)+hozoff*(Math.sin(yaw+Math.PI/2)*Math.cos(pitch))+vertoff*(Math.sin(yaw)*Math.cos(pitch+Math.PI/2));
      Ray ray = new Ray(-16*Math.cos(angle), -8, -16*Math.sin(angle), projx, projy, projz);
      double out = ray.trace(planes);
      if(out == Double.POSITIVE_INFINITY){
        fill(0,55,55);
      }else{
        fill(map((float)out, 0, 1, 0, 255));
      }
      rect(j, i, 1, 1);
    }
  }
  println("Rays: "+str(height*width));
  println("RTime: "+str(((float)(millis()-start)/(height*width))));
  println("TTime: "+str(millis()-start));
  angle += Math.PI/30;
}

public ArrayList<Plane> getPlanes(){
  ArrayList<Plane>out = new ArrayList<Plane>();
  out.addAll(planes);
  for(Cube cube:cubes){
    out.addAll(cube.getPlanes());
  }
  return out;
}
