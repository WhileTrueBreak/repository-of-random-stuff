public class Cube{
  
  private ArrayList<Plane>planes;
  
  public Cube(double x, double y, double z, double xd, double yd, double zd){
    this.planes = new ArrayList<Plane>();
    this.planes.add(new Plane(x, y, z, x+xd, y, z, x, y+yd, z));
    this.planes.add(new Plane(x, y, z, x, y+yd, z, x, y, z+zd));
    this.planes.add(new Plane(x, y, z, x, y, z+zd, x+xd, y, z));
    this.planes.add(new Plane(x+xd, y+yd, z, x+xd, y, z, x, y+yd, z));
    this.planes.add(new Plane(x, y+yd, z+zd, x, y+yd, z, x, y, z+zd));
    this.planes.add(new Plane(x+xd, y, z+zd, x, y, z+zd, x+xd, y, z));
    this.planes.add(new Plane(x, y+yd, z, x+xd, y+yd, z, x, y+yd, z+zd));
    this.planes.add(new Plane(x, y, z+zd, x, y+yd, z+zd, x+xd, y, z+zd));
    this.planes.add(new Plane(x+xd, y, z, x+xd, y, z+zd, x+xd, y+yd, z));
    this.planes.add(new Plane(x+xd, y+yd, z+zd, x+xd, y+yd, z, x, y+yd, z+zd));
    this.planes.add(new Plane(x+xd, y+yd, z+zd, x, y+yd, z+zd, x+xd, y, z+zd));
    this.planes.add(new Plane(x+xd, y+yd, z+zd, x+xd, y, z+zd, x+xd, y+yd, z));
  }
  
  public ArrayList<Plane> getPlanes(){
    return planes;
  }
  
}
