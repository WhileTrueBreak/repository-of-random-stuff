class Map{
  
  int[][] groundMap;
  float[][] heightMap;
  int x, y;
  float dimy, dimx;
  
  ArrayList<PVector> towns;
  
  Map(int x, int y){
    this.x = x;
    this.y = y;
    heightMap = new float[y][x];
    groundMap = new int[y][x];
    dimy = height/heightMap.length;
    dimx = width/heightMap[0].length;
    this.towns = new ArrayList<PVector>();
    createMap();
  }
  
  void createMap(){
    float scale1 = 0.2;
    for(int i = 0;i < heightMap.length;i++){
      for(int j = 0;j < heightMap[i].length;j++){
        heightMap[i][j] = noise(i*scale1, j*scale1);
        groundMap[i][j] = 0;
      }
    }
  }
  
  void render(){
    for(int i = 0;i < heightMap.length;i++){
      for(int j = 0;j < heightMap[i].length;j++){
        switch(groundMap[i][j]){
        case 0:
          fill(map(heightMap[i][j],0,1,0,255));
          break;
        case 1:
          fill(255, 255, 0, 100);
          break;
        }
        rect(j*dimx, i*dimy, dimx, dimy);
      }
    }
    for(PVector town:this.towns){
      fill(0,0,255);
      rect(town.x*dimx-dimx, town.y*dimy-dimy, dimx*3, dimy*3);
    }
  }
  
  void createPattern(int sx, int sy){
    
    float[][] weightMap = new float[x][y];
    PVector[][] linkedMap = new PVector[x][y];
    ArrayList<PVector> toCheck = new ArrayList<PVector>();
    ArrayList<PVector> toRemove = new ArrayList<PVector>();
    ArrayList<PVector> toAdd = new ArrayList<PVector>();
    toCheck.add(new PVector(sx, sy));
    for(int i = 0;i < weightMap.length;i++){
      for(int j = 0;j < weightMap[i].length;j++){
        weightMap[i][j] = -1;
      }
    }
    weightMap[sy][sx] = 0;
    while(toCheck.size() != 0){
      println(toCheck.size());
      for(PVector tile:toCheck){
        toRemove.add(tile);
        for(PVector neighbor:getNeighbors(tile)){
          float heightDiff = heightMap[(int)tile.y][(int)tile.x]-heightMap[(int)neighbor.y][(int)neighbor.x];
          float addedWeight = (heightDiff)*(heightDiff);
          float moveWeight = neighbor.z*0+addedWeight;
          float tileWeight = weightMap[(int)tile.y][(int)tile.x];
          float neighborWeight = weightMap[(int)neighbor.y][(int)neighbor.x];
          if(moveWeight+tileWeight<neighborWeight||neighborWeight<0){
            weightMap[(int)neighbor.y][(int)neighbor.x] = moveWeight+tileWeight;
            linkedMap[(int)neighbor.y][(int)neighbor.x] = tile;
            toAdd.add(neighbor);
          }
        }
      }
      toCheck.removeAll(toRemove);
      toCheck.addAll(toAdd);
      toRemove = new ArrayList<PVector>();
      toAdd = new ArrayList<PVector>();
    }
    
    stroke(255);
    strokeWeight(1);
    for(int i = 0;i < linkedMap.length;i++){
      for(int j = 0;j < linkedMap[i].length;j++){
        if(linkedMap[i][j] != null){
          line(j*dimx+dimx/2, i*dimy+dimy/2, linkedMap[i][j].x*dimx+dimx/2, linkedMap[i][j].y*dimy+dimy/2);
        }
      }
    }
    
  }
  
  ArrayList<PVector> getNeighbors(PVector tile){
    ArrayList<PVector> neighbors = new ArrayList<PVector>();
    boolean up = tile.y>=1;
    boolean left = tile.x>=1;
    boolean down = tile.y<this.y-1;
    boolean right = tile.x<this.x-1;
    
    
    if(left) neighbors.add(new PVector(tile.x-1, tile.y, 1));
    if(left&&down) neighbors.add(new PVector(tile.x-1, tile.y+1, sqrt(2)));
    if(left&&up) neighbors.add(new PVector(tile.x-1, tile.y-1, sqrt(2)));
    if(up) neighbors.add(new PVector(tile.x, tile.y-1, 1));
    if(right) neighbors.add(new PVector(tile.x+1, tile.y, 1));
    if(right&&down) neighbors.add(new PVector(tile.x+1, tile.y+1, sqrt(2)));
    if(right&&up) neighbors.add(new PVector(tile.x+1, tile.y-1, sqrt(2)));
    if(down) neighbors.add(new PVector(tile.x, tile.y+1, 1));
    
    
    return neighbors;
  }
  
  float[][] getHeightMap(){
    return heightMap;
  }
  
}
