/*
  1=stone
  2=dirt
*/


class Map{
  
  final static float NOISE_STEP = 0.1;
  final static int RENDER_SCALE = 10;
  
  PVector dim;
  int[][][] terrainGrid;
  ArrayList<Integer>[][][] itemGrid;
  
  Map(int x, int y, int z){
    dim = new PVector(x, y, z);
    terrainGrid = new int[x][y][z];
    itemGrid = new ArrayList[x][y][z];
  }
  
  void createMap(){
    println("Raising Ground...");
    for(int i = 0;i < dim.x;i++){
      for(int j = 0;j < dim.y;j++){
        int gHeight = (int)(noise(i*NOISE_STEP, j*NOISE_STEP)*dim.z);
        for(int k = 0;k < gHeight-2;k++){
          terrainGrid[i][j][k] = 1;
        }
        for(int k = gHeight-2<0?0:gHeight-2;k < gHeight;k++){
          terrainGrid[i][j][k] = 2;
        }
      }
    }
    println("END");
  }
  void render(){
    for(int i = 0;i < dim.x;i++){
      for(int j = 0;j < dim.y;j++){
        for(int k = 0;k < dim.z;k++){
          switch(terrainGrid[i][j][k]){
            case 0:
            continue;
            case 1:
            fill(100);
            break;
            case 2:
            fill(0,255,0);
            break;
          }
          pushMatrix();
          translate((i-(dim.x/2))*RENDER_SCALE,(j-(dim.y/2))*RENDER_SCALE,(k-(dim.z/2))*RENDER_SCALE);
          box(RENDER_SCALE,RENDER_SCALE,RENDER_SCALE);
          popMatrix();
        }
      }
    }
  }
}
