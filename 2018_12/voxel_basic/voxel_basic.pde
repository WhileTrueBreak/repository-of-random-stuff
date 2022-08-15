import peasy.*;
Voxel voxel_grid[][][] = new Voxel[30][30][30];
PeasyCam cam;
//public variables
int scl = 40;

void setup(){
  cam = new PeasyCam(this, 100);
  for(int z = 0;z < voxel_grid.length;z++){
    for(int y = 0;y < voxel_grid[z].length;y++){
      for(int x = 0;x < voxel_grid[z][y].length;x++){
        voxel_grid[z][y][x] = new Voxel(x*scl,y*scl,z*scl,scl);
      }
    }
  }
  size(400,400,P3D);
}

void draw(){
  println(frameRate);
  cam.setPitchRotationMode();
  background(255);
  for(int z = 0;z < voxel_grid.length;z++){
    for(int y = 0;y < voxel_grid[z].length;y++){
      for(int x = 0;x < voxel_grid[z][y].length;x++){
        voxel_grid[z][y][x].render();
      }
    }
  }
}