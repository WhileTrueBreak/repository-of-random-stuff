public class Ray{
  
  private double x, y, z;
  private double dx, dy, dz;
  private int depth;
  
  public Ray(double x, double y, double z, double dx, double dy, double dz){
    this.x = x;
    this.y = y;
    this.z = z;
    double dLen = Math.sqrt(dx*dx+dy*dy+dz*dz);
    this.dx = dx/dLen;
    this.dy = dy/dLen;
    this.dz = dz/dLen;
    this.depth = 1;
  }
  
  public double trace(ArrayList<Plane>planes){
    double rcx = 0, rcy = 0, rcz = 0;
    double rnx = 0, rny = 0, rnz = 0;
    //loop var

    double minDist = Double.POSITIVE_INFINITY;
    for(Plane plane:planes){
      //if(true) continue;
      //check for intersection
      double far = 100000;
      double q1x, q1y, q1z, q2x, q2y, q2z;
      double p1x, p1y, p1z, p2x, p2y, p2z, p3x, p3y, p3z;
      q1x = x;
      q1y = y;
      q1z = z;
      q2x = x+dx*far;
      q2y = y+dy*far;
      q2z = z+dz*far;
      p1x = plane.getX1();
      p1y = plane.getY1();
      p1z = plane.getZ1();
      p2x = plane.getX2();
      p2y = plane.getY2();
      p2z = plane.getZ2();
      p3x = plane.getX3();
      p3y = plane.getY3();
      p3z = plane.getZ3();
      
      //get volumes to check if collision exists
      double q1p123 = signedVolume(q1x,q1y,q1z,p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z);
      double q2p123 = signedVolume(q2x,q2y,q2z,p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z);
      if(q1p123 * q2p123 > 0){
        continue;
      }
      double q12p12 = signedVolume(q1x,q1y,q1z,q2x,q2y,q2z,p1x,p1y,p1z,p2x,p2y,p2z);
      double q12p23 = signedVolume(q1x,q1y,q1z,q2x,q2y,q2z,p2x,p2y,p2z,p3x,p3y,p3z);
      double q12p31 = signedVolume(q1x,q1y,q1z,q2x,q2y,q2z,p3x,p3y,p3z,p1x,p1y,p1z);
      if((q12p12 < 0) != (q12p23 < 0) || (q12p23 < 0) != (q12p31 < 0) || (q12p31 < 0) != (q12p12 < 0)){
        continue;
      }
      
      //get collision by finding t
      double nx, ny, nz, cx, cy, cz;
      nx = (p2y - p1y)*(p3z - p1z) - (p2z - p1z)*(p3y - p1y);
      ny = (p2z - p1z)*(p3x - p1x) - (p2x - p1x)*(p3z - p1z);
      nz = (p2x - p1x)*(p3y - p1y) - (p2y - p1y)*(p3x - p1x);
      double t = -((q1x - p1x)*nx + (q1y - p1y)*ny + (q1z - p1z)*nz)/((q2x - q1x)*nx + (q2y - q1y)*ny + (q2z - q1z)*nz);
      cx = q1x + t*(q2x - q1x);
      cy = q1y + t*(q2y - q1y);
      cz = q1z + t*(q2z - q1z);
      
      //check if collision is closest
      double threshhold = 0.000001;
      double clensqr = Math.sqrt((cx-q1x)*(cx-q1x)+(cy-q1y)*(cy-q1y)+(cz-q1z)*(cz-q1z));
      if(clensqr < minDist){
        minDist = clensqr;
        double rayLen = Math.sqrt(dx*dx+dy*dy+dz*dz);
        rcx = cx-dx*threshhold/rayLen;
        rcy = cy-dy*threshhold/rayLen;
        rcz = cz-dz*threshhold/rayLen;
        rnx = nx;
        rny = ny;
        rnz = nz;
      }
    }
    //get light
    minDist = Math.sqrt(minDist);
    if(minDist != Double.POSITIVE_INFINITY && depth > 0){
      double lx, ly, lz;
      lx = 2;
      ly = -4;
      lz = -3;
      
      Ray lightRay = new Ray(rcx, rcy, rcz, lx-rcx, ly-rcy, lz-rcz);
      double lLen = Math.sqrt((lx-rcx)*(lx-rcx)+(ly-rcy)*(ly-rcy)+(lz-rcz)*(lz-rcz));
      double nLen = Math.sqrt(rnx*rnx+rny*rny+rnz*rnz);
      double dotln = Math.abs((lx-rcx)/lLen*rnx/nLen+(ly-rcy)/lLen*rny/nLen+(lz-rcz)/lLen*rnz/nLen);
      lightRay.setDepth(0);
      double light = lightRay.trace(planes);
      float shadowDist = 100000;
      if(light < lLen && light < shadowDist){
        float m = map((float)light,0,shadowDist,0,0);
        return dotln*m;
      }else{
        return dotln;
      }
    }
    return minDist;
  }
  private double signedVolume(double ax, double ay, double az, double bx, double by, double bz, double cx, double cy, double cz, double dx, double dy, double dz){
    return (dx - ax)*((by - ay)*(cz - az) - (bz - az)*(cy - ay)) + (dy - ay)*((bz - az)*(cx - ax) - (bx - ax)*(cz - az)) + (dz - az)*((bx - ax)*(cy - ay) - (by - ay)*(cx - ax));
  }
  public double getX(){
    return x;
  }
  public double getY(){
    return y;
  }
  public double getZ(){
    return z;
  }
  public int getDepth(){
    return depth;
  }
  public void setDepth(int depth){
    this.depth = depth;
  }
}
