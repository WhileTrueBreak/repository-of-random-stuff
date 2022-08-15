import java.util.Collections;
import java.util.Comparator;

class Map{
  
  boolean debug = true;
  
  int[][] groundMap;
  float[][] heightMap;
  int x, y;
  float dimy, dimx;
  
  OpenSimplexNoise hlayer1, hlayer2, layersNoise;
  
  ArrayList<PVector> towns;
  
  Map(int x, int y){
    this.x = x;
    this.y = y;
    dimy = height/y;
    dimx = width/x;
    this.towns = new ArrayList<PVector>();
    hlayer1 = new OpenSimplexNoise((long)(random(1)*Long.MAX_VALUE));
    hlayer2 = new OpenSimplexNoise((long)(random(1)*Long.MAX_VALUE));
    layersNoise = new OpenSimplexNoise((long)(random(1)*Long.MAX_VALUE));
    
    
    createMap();
  }
  
  void createMap(){
    float scale1 = 0.005;
    float scale2 = 0.02;
    float scale3 = 0.01;
    heightMap = new float[y][x];
    groundMap = new int[y][x];
    for(int i = 0;i < heightMap.length;i++){
      for(int j = 0;j < heightMap[i].length;j++){
        float lheight = (float)(hlayer1.eval(i*scale1, j*scale1)+hlayer2.eval(i*scale2, j*scale2)*0.1);
        float layers = map((float)layersNoise.eval(i*scale3, j*scale3),-1,1,1,100);
        if(layers < 100){
          lheight = (float)round(lheight*layers)/layers;
        }
        heightMap[i][j] = lheight;
        groundMap[i][j] = 0;
      }
    }
  }
  
  void render(){
    for(int i = 0;i < heightMap.length;i++){
      for(int j = 0;j < heightMap[i].length;j++){
        switch(groundMap[i][j]){
        case 0:
          fill(map(heightMap[i][j],-1,1,0,200),200);
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
  
  void addTown(int x, int y){
    towns.add(new PVector(x, y));
  }
  
  void connectTowns(){
    ArrayList<PVector> done = new ArrayList<PVector>();
    ArrayList<PVector> todo = new ArrayList<PVector>();
    ArrayList<PVector> toRemove = new ArrayList<PVector>();
    todo.addAll(towns);
    while(todo.size() != 0){
      PVector t1 = todo.get(0);
      float bestWeight = (float)Double.POSITIVE_INFINITY;
      PVector bestTown = null;
      for(PVector t2:done){
        if(t1 == t2) continue;
        float weight = dist(t1.x, t1.y, t2.x, t2.y);
        if(weight < bestWeight){
          bestWeight = weight;
          bestTown = t2;
        }
      }
      if(bestTown != null) createPath((int)t1.x, (int)t1.y, (int)bestTown.x, (int)bestTown.y);
      if(!done.contains(t1)) done.add(t1);
      if(!done.contains(bestTown) && bestTown != null) done.add(bestTown);
      toRemove.add(t1);
      todo.removeAll(toRemove);
      toRemove = new ArrayList<PVector>();
    }
  }
  
  void createPath(int sx, int sy, int ex, int ey){
    
    int start = millis();
    
    int MAX_CYCLES = 5;
    
    float[][] weightMap = new float[x][y];
    PVector[][] linkedMap = new PVector[x][y];
    int[][] cycleMap = new int[x][y];
    ArrayList<PVector> toCheck = new ArrayList<PVector>();
    ArrayList<PVector> toRemove = new ArrayList<PVector>();
    ArrayList<PVector> toAdd = new ArrayList<PVector>();
    toCheck.add(new PVector(sx, sy, 0));
    for(int i = 0;i < weightMap.length;i++){
      for(int j = 0;j < weightMap[i].length;j++){
        weightMap[i][j] = -1;
        cycleMap[i][j] = 0;
      }
    }
    boolean done = false;
    weightMap[sy][sx] = 0;
    while(toCheck.size() != 0&&!done){
      int count = 0;
      for(PVector tile:toCheck){
        if(count>toCheck.size()/4) break;
        count++;
        toRemove.add(tile);
        if((int)tile.x==ex&&(int)tile.y==ey) {
          done = true;
          break;
        }
        if(cycleMap[(int)tile.y][(int)tile.x] >= MAX_CYCLES){
          if(debug){
            fill(255, 0, 0);
            ellipse(tile.x*dimx+dimx/2, tile.y*dimy+dimy/2, dimx/2, dimy/2);
          }
          continue;
        }else{
          if(debug){
            fill(0, 0, 255);
            ellipse(tile.x*dimx+dimx/2, tile.y*dimy+dimy/2, dimx/2, dimy/2);
          }
        }
        for(PVector neighbor:getNeighbors(tile)){
          float heightDiff = heightMap[(int)tile.y][(int)tile.x]-heightMap[(int)neighbor.y][(int)neighbor.x];
          float addedWeight = (heightDiff)*(heightDiff);
          float moveWeight = neighbor.z*0.00004+addedWeight;
          float tileWeight = weightMap[(int)tile.y][(int)tile.x];
          float neighborWeight = weightMap[(int)neighbor.y][(int)neighbor.x];
          if(moveWeight+tileWeight<neighborWeight||neighborWeight<0){
            weightMap[(int)neighbor.y][(int)neighbor.x] = moveWeight+tileWeight;
            linkedMap[(int)neighbor.y][(int)neighbor.x] = tile;
            cycleMap[(int)neighbor.y][(int)neighbor.x]++;
            neighbor.z = dist(neighbor.x, neighbor.y, ex, ey)*0.00004+addedWeight;
            toAdd.add(neighbor);
          }
        }
      }
      toCheck.removeAll(toRemove);
      for(PVector tile:toAdd){
        toCheck.add(0,tile);
      }
      
      Collections.sort(toCheck, new Comparator<PVector>() {
          @Override
          public int compare(PVector lhs, PVector rhs) {
              // -1 - less than, 1 - greater than, 0 - equal, all inversed for descending
              return lhs.z > rhs.z ? 1 : (lhs.z < rhs.z) ? -1 : 0;
          }
      });
      
      toRemove = new ArrayList<PVector>();
      toAdd = new ArrayList<PVector>();
    }
    
    boolean atStart = false;
    PVector currentTile = new PVector(ex, ey);
    while(!atStart){
      groundMap[(int)currentTile.y][(int)currentTile.x] = 1;
      if((int)currentTile.x == sx && (int)currentTile.y == sy){
        atStart = true;
        break;
      }
      currentTile = linkedMap[(int)currentTile.y][(int)currentTile.x];
    }
    println("Done in "+str(millis()-start)+"ms");
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
