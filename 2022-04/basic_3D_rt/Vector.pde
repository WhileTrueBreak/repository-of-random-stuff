public static class Vector{
  
  public double x, y, z;
  
  public Vector(double x, double y, double z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  public Vector scalarProd(double num){
    this.x *= num;
    this.y *= num;
    this.z *= num;
    return this;
  }
  public Vector addVec(Vector v){
    this.x += v.x;
    this.y += v.y;
    this.z += v.z;
    return this;
  }
  public Vector subVec(Vector v){
    this.x -= v.x;
    this.y -= v.y;
    this.z -= v.z;
    return this;
  }
  public double distVec(){
    return Math.sqrt(x*x+y*y+z*z);
  }
  public Vector copyVec(){
    return new Vector(x, y, z);
  }
  public static double dotProd(Vector v1, Vector v2){
    return v1.x*v2.x+v1.y*v2.y+v1.z*v2.z;
  }
  public static Vector scalarProd(Vector v1, double num){
    return new Vector(v1.x*num, v1.y*num, v1.z*num);
  }
  public static Vector crossProd(Vector v1, Vector v2){
    return new Vector(v1.y*v2.z-v1.z*v2.y, v1.z*v2.x-v1.x*v2.z, v1.x*v2.y-v1.y*v2.x);
  }
  public static Vector addVec(Vector v1, Vector v2){
    return new Vector(v1.x+v2.x, v1.y+v2.y, v1.z+v2.z);
  }
  public static Vector subVec(Vector v1, Vector v2){
    return new Vector(v1.x-v2.x, v1.y-v2.y, v1.z-v2.z);
  }
  
}
