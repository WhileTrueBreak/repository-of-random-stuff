public class Grid{
  
  public long gridSeed;
  
  public int currentGenLayer;
  
  public float cP = 1;
  
  public static final int GRID_SIZE = 20;
  
  private int x, y;
  private float grid_Xoff, grid_Yoff;
  
  private float[][] heightMap;
  private float[][] temperatureMap;
  private float[][] humidityMap;
  
  private ArrayList<Settlement> settlements = new ArrayList<Settlement>();
  
  public Grid(int x, int y){
    this.currentGenLayer = 0;
    this.heightMap = new float[GRID_SIZE][GRID_SIZE];
    this.temperatureMap = new float[GRID_SIZE][GRID_SIZE];
    this.humidityMap = new float[GRID_SIZE][GRID_SIZE];
    this.x = x;
    this.y = y;
    this.grid_Xoff = x*GRID_SIZE*Chunk.CHUNK_SIZE;
    this.grid_Yoff = y*GRID_SIZE*Chunk.CHUNK_SIZE;
    
    gridSeed = worldSeed^(long)(spiralOffset(x,y)+1);
    
  }
  
  public void render(){
    noStroke();
    for(int i = 0;i < GRID_SIZE;i++){
      for(int j = 0;j < GRID_SIZE;j++){
        fill(map(heightMap[i][j],0,1,0,255));
        if(heightMap[i][j]<water_level)
          fill(0,map(heightMap[i][j],0,1,0,255),255);
        //rect((i+x*GRID_SIZE)*cP+camOffset.x, (j+y*GRID_SIZE)*cP+camOffset.y, cP, cP);
        //fill(0,0,map(humidityMap[i][j],0,1,0,255),50);
        //rect((i+x*GRID_SIZE)*cP, (j+y*GRID_SIZE)*cP, cP, cP);
        //fill(map(temperatureMap[i][j],0,1,0,255),0,0,50);
        //rect((i+x*GRID_SIZE)*cP, (j+y*GRID_SIZE)*cP, cP, cP);
      }
    }
    noFill();
    stroke(100);
    //rect(x*GRID_SIZE*cP+camOffset.x, y*GRID_SIZE*cP+camOffset.y, GRID_SIZE*cP, GRID_SIZE*cP);noStroke();
    for(Settlement settlement:settlements){
      settlement.render(cP);
    }
  }
  
  public boolean gen4(){
    //start time logging
    long startTime = System.nanoTime();
    //init
    ArrayList<PVector> allNSettlements = new ArrayList<PVector>();
    ArrayList<Settlement> allSettlements = new ArrayList<Settlement>();
    //check if triangulation is needed
    if(settlements.size()==0){
      logGridMSG("No settlements", false);
      return false;
    }
    //check neighbours
    for(int i=-1;i<=1;i++){
      for(int j=-1;j<=1;j++){
        String gridKey = xyToString(x+i,y+j);
        Grid g = gridDict.get(gridKey);
        if(g==null){
          logGridMSG("unknown grid: "+gridKey, false);
          return false;
        }
        if(g.currentGenLayer<3){
          logGridMSG("below required gen: "+gridKey, false);
          return false;
        }
        for(Settlement settlement:g.getSettlements()){
          allNSettlements.add(settlement.getPos());
          allSettlements.add(settlement);
        }
      }
    }
    //triangulation
    //triangle covering all points
    float modGS = GRID_SIZE*cP;
    PVector[] triVertices = {new PVector(x*GRID_SIZE-GRID_SIZE, y*GRID_SIZE-GRID_SIZE), new PVector(x*GRID_SIZE-GRID_SIZE, y*GRID_SIZE+GRID_SIZE*3), new PVector(x*GRID_SIZE+GRID_SIZE*3, y*GRID_SIZE-GRID_SIZE)};
    Triangle triangle = new Triangle(triVertices[0], triVertices[1], triVertices[2]);
    ArrayList<Line> connections = triangulate(allNSettlements, triangle);
    //remove outer triangle
    ArrayList<Line> toRemove = new ArrayList<Line>();
    for(Line connection:connections){
      boolean valid = true;
      Settlement v1 = null;
      Settlement v2 = null;
      for(PVector vertex:triVertices){
        if(vertex == connection.v1||vertex == connection.v2){
          valid = false;
          toRemove.add(connection);
        }
      }
      if(x==7&&y==-10){
        logGridMSG("yes", true);
      }
      for(Settlement settlement:settlements){
        if(!((settlement.getPos() == connection.v1)||(settlement.getPos() == connection.v2))){
          valid = false;
          toRemove.add(connection);
        }
      }
      for(Settlement settlement:allSettlements){
        if(settlement.getPos() == connection.v1){
          v1 = settlement;
        }
        if(settlement.getPos() == connection.v2){
          v2 = settlement;
        }
      }
      if(valid&&v1!=null&&v2!=null){
        ArrayList<Settlement> cv1 = v1.getConnected();
        if(!cv1.contains(v2))cv1.add(v2);
        //cv1.add(v2);
        v1.setConnected(cv1);
        ArrayList<Settlement> cv2 = v2.getConnected();
        if(!cv2.contains(v1))cv2.add(v1);
        //cv2.add(v1);
        v2.setConnected(cv2);
      }
    }
    connections.removeAll(toRemove);
    //remove dupes
    
    
    
    //end time logging
    long endTime = System.nanoTime();
    long duration = (endTime - startTime)/1000000;
    logGridMSG("Gen 4 took "+duration+"ms", false);
    currentGenLayer = 4;
    return true;
  }
  
  public boolean gen3(){
    //start time logging
    long startTime = System.nanoTime();
    //init
    ArrayList<Settlement> allNSettlements = new ArrayList<Settlement>();
    //check neighbours
    for(int i=-1;i<=1;i++){
      for(int j=-1;j<=1;j++){
        String gridKey = xyToString(x+i,y+j);
        Grid g = gridDict.get(gridKey);
        if(g==null){
          logGridMSG("unknown grid: "+gridKey, false);
          return false;
        }
        if(g.currentGenLayer<2){
          logGridMSG("below required gen: "+gridKey, false);
          return false;
        }
        for(Settlement settlement:g.getSettlements()){
          allNSettlements.add(settlement);
        }
      }
    }
    //check point too close
    float checkDist = 10;
    ArrayList<Settlement> toRemove = new ArrayList<Settlement>();
    for(int i = 0; i < allNSettlements.size();i++){
      Settlement p1 = allNSettlements.get(i);
      if(settlements.contains(p1)){
        for(int j = i+1; j < allNSettlements.size();j++){
          Settlement p2 = allNSettlements.get(j);
          if(dist(p1.getPos().x, p1.getPos().y, p2.getPos().x, p2.getPos().y)<checkDist){
            toRemove.add(p1);
          }
        }
      }
    }
    settlements.removeAll(toRemove);
    //end time logging
    long endTime = System.nanoTime();
    long duration = (endTime - startTime)/1000000;
    logGridMSG("Gen 3 took "+duration+"ms", false);
    currentGenLayer = 3;
    return true;
  }
  
  public boolean gen2(){
    //start time logging
    long startTime = System.nanoTime();
    //check neighbour grids
    for(int i=-1;i<=1;i++){
      for(int j=-1;j<=1;j++){
        String gridKey = xyToString(x+i,y+j);
        Grid g = gridDict.get(gridKey);
        if(g==null){
          logGridMSG("unknown grid: "+gridKey, false);
          return false;
        }
        if(g.currentGenLayer<1){
          logGridMSG("below required gen: "+gridKey, false);
          return false;
        }
      }
    }
    //random gen points
    Random rnggen2 = new Random(gridSeed);
    int count = round(rnggen2.nextFloat());
    for(float i = 0;i < count;i++){
      PVector pos = new PVector(rnggen2.nextFloat()*GRID_SIZE, rnggen2.nextFloat()*GRID_SIZE);
      if(heightMap[(int)pos.x][(int)pos.y] < water_level) {
        continue;
      }
      settlements.add(new Settlement(new PVector(pos.x+x*GRID_SIZE, pos.y+y*GRID_SIZE)));
    }
    //end time logging
    long endTime = System.nanoTime();
    long duration = (endTime - startTime)/1000000;
    logGridMSG("Gen 2 took "+duration+"ms", false);
    currentGenLayer = 2;
    return true;
  }
  
  public boolean gen1(){
    //start time logging
    long startTime = System.nanoTime();
    //init
    OpenSimplexNoise L1heightGen = new OpenSimplexNoise(seedDict.get("L1heightSeed"));
    OpenSimplexNoise L2heightGen = new OpenSimplexNoise(seedDict.get("L2heightSeed"));
    OpenSimplexNoise temperatureGen = new OpenSimplexNoise(seedDict.get("temperatureSeed"));
    OpenSimplexNoise humidityGen = new OpenSimplexNoise(seedDict.get("humiditySeed"));
    //create maps
    float chunkCenter = (Chunk.CHUNK_SIZE-1)/2;
    for(int i = 0;i < GRID_SIZE;i++){
      for(int j = 0;j < GRID_SIZE;j++){
        heightMap[i][j] = (float)(L1heightGen.eval((i*Chunk.CHUNK_SIZE+chunkCenter+grid_Xoff)*L1height_Xoff, (j*Chunk.CHUNK_SIZE+chunkCenter+grid_Yoff)*L1height_Yoff)*water_level
                          +L2heightGen.eval((i*Chunk.CHUNK_SIZE+chunkCenter+grid_Xoff)*L2height_Xoff, (j*Chunk.CHUNK_SIZE+chunkCenter+grid_Yoff)*L2height_Yoff));
        heightMap[i][j] = map(heightMap[i][j],0,1+water_level,0,1);
        temperatureMap[i][j] = (float)temperatureGen.eval((i*Chunk.CHUNK_SIZE+chunkCenter+grid_Xoff)*temperature_Xoff, (j*Chunk.CHUNK_SIZE+chunkCenter+grid_Yoff)*temperature_Yoff);
        humidityMap[i][j] = (float)humidityGen.eval((i*Chunk.CHUNK_SIZE+chunkCenter+grid_Xoff)*humidity_Xoff, (j*Chunk.CHUNK_SIZE+chunkCenter+grid_Yoff)*humidity_Yoff);
      }
    }
    //end time logging
    long endTime = System.nanoTime();
    long duration = (endTime - startTime)/1000000;
    logGridMSG("Gen 1 took "+duration+"ms", false);
    currentGenLayer = 1;
    return true;
  }
  
  public int spiralOffset(int x, int y){
    //if(x == 0 && y == 0) return 0;
    int cross = 0;
    int offset = 0;
    int sum = x+y;
    int n = 0;
    int i = 0;
    if(sum>0){
      i = 2;
      if(x>y){
        n = abs(x);
        offset = n-y;
      }else{
        n = abs(y);
        offset = x-n;
      }
    }else{
      i = 6;
      if(x>y){
        n = abs(y);
        offset = -n-x;
      }else{
        n = abs(x);
        offset = n+y;
      }
    }
    cross = 4*n*(n-1)+n*i;
    return cross+offset;
  }
  
  public float[][] getHeightMap(){
    return heightMap;
  }
  
  public float[][] getTemperatureMap(){
    return temperatureMap;
  }
  
  public float[][] getHumidityMap(){
    return humidityMap;
  }
  
  public ArrayList<Settlement> getSettlements(){
    return settlements;
  }
  
  public void setKeypoints(ArrayList<Settlement> settlements){
    this.settlements = settlements;
  }
  
  public void logGridMSG(String log, boolean important){
    String msg = "("+this.x+","+this.y+")\t"+log;
    if(Verbose || important)println(msg);
  }
  
}
