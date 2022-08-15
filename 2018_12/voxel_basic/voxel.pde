class Voxel{
  //basic variable
  int x,y,z;
  int scl;
  
  //infomation variables
  color voxel_c = color(0,0,0,25);
  
  Voxel(int x, int y, int z, int scl){
    this.scl = scl;
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void render(){
    pushMatrix();
    translate(x,y,z);
    noStroke();
    fill(voxel_c);
    box(scl);
    popMatrix();
  }
  
}