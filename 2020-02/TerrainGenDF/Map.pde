import java.util.Arrays;
class Map{
  
  final int MAX_HEIGHT_BEFORE = 100;
  final int SEA_LEVEL = 25;
  
  int mapX, mapY;
  
  int[][] heightMap;
  float[][] humidityMap;
  float[][] drainageMap;
  float[][] riverMap;
  
  float landPercentage = 0;
  float shorePercentage = 0;
  float shoreComplexity = 0;
  
  public Map(int x, int y){
    this.mapX = x;
    this.mapY = y;
    heightMap = new int[x][y];
    humidityMap = new float[x][y];
    drainageMap = new float[x][y];
    riverMap = new float[x][y];
  }
  
  public void createHeightMap(int seed){
    println("Seed: ",seed);
    noiseSeed(seed);
    println("Generating height map...");
    float[] offsetsX = {4f/mapX};
    float[] offsetsY = {4f/mapY};
    for(int i = 0;i < mapX;i++){
      for(int j = 0;j < mapY;j++){
        float distM = dist(i, j, mapX/2, mapY/2);
        if(distM > mapX/4){
          distM = map(distM, mapX/2, mapX/4, 2, -2);
          distM = map((float)(1/(1+Math.exp(-distM))), (float)(1/(1+Math.exp(-2))), (float)(1/(1+Math.exp(2))), 1, 0);
          distM = min(distM, 1);
        }else{
          distM = 0;
        }
        heightMap[i][j] = (int)((noise(i*offsetsX[0], j*offsetsY[0])-distM)*MAX_HEIGHT_BEFORE);
      }
    }
    calcInfo();
  }
  
  public void createHumidityMap(int seed){
    println("Seed: ",seed);
    noiseSeed(seed);
    println("Generating humidity map...");
    float[] offsetsX = {4f/mapX};
    float[] offsetsY = {4f/mapY};
    for(int i = 0;i < mapX;i++){
      for(int j = 0;j < mapY;j++){
        humidityMap[i][j] = noise(i*offsetsX[0], j*offsetsY[0]);
        humidityMap[i][j] -= map(heightMap[i][j], 0, MAX_HEIGHT_BEFORE, 0, 0.5f);
        humidityMap[i][j] = max(humidityMap[i][j], 0);
      }
    }
  }
  
  public void createDrainageMap(int seed){
    println("Seed: ",seed);
    noiseSeed(seed);
    println("Generating drainage map...");
    float shift = mapX*10;
    float[] offsetsX = {4f/mapX};
    float[] offsetsY = {4f/mapY};
    for(int i = 0;i < mapX;i++){
      for(int j = 0;j < mapY;j++){
        drainageMap[i][j] =min(noise(i*offsetsX[0], j*offsetsY[0]), noise(i*offsetsX[0]+shift, j*offsetsY[0]+shift));
      }
    }
  }
  
  public void createRivers(){
    for(int i = 0;i < mapX;i++){
      for(int j = 0;j < mapY;j++){
        if(humidityMap[i][j]>random(1)&&5>random(100)){
          riverMap[i][j] = humidityMap[i][j];
        }
      }
    }
  }
  
  public void calcInfo(){
    int shoreCount = 0;
    int landCount = 0;
    ArrayList<Float> shoreDist = new ArrayList<Float>();
    for(int i = 0;i < mapX;i++){
      for(int j = 0;j < mapY;j++){
        if(heightMap[i][j] >= SEA_LEVEL){
          landCount++;
          for(int im = -1;im < 2;im++){
            for(int jm = -1;jm < 2;jm++){
              try{
                if(heightMap[i+im][j+jm] < SEA_LEVEL){
                  shoreCount++;
                  shoreDist.add(map(dist(i, j, mapX/2, mapY/2), 0, mapX/2, 0, 1));
                  im=2;
                  break;
                }
              }catch(ArrayIndexOutOfBoundsException e){
              }
            }
          }
        }
      }
    }
    landPercentage = (float)landCount/(mapX*mapY);
    shorePercentage = (float)shoreCount/landCount;
    //float[] shoreDistArr = new float[shoreDist.size()];
    int[] distribution = new int[10];
    for(int i = 0;i < shoreDist.size();i++){
      for(int j = 0;j < distribution.length;j++){
        if(shoreDist.get(i) < (float)1/distribution.length*(j+1)){
          distribution[j]++;
          break;
        }
      }
    }
    float distributionAvg = 0;
    for(int i = 0;i < distribution.length;i++){
      distributionAvg+=distribution[i];
    }
    distributionAvg/=distribution.length;
    float distributionDiff = 0;
    for(int i = 0;i < distribution.length;i++){
      distributionDiff += abs(distribution[i]-distributionAvg);
    }
    shoreComplexity = distributionDiff;
  }
  
  public void render(){
    noStroke();
    float scaleX = (float)width/mapX;
    float scaleY = (float)height/mapY;
    for(int i = 0;i < mapX;i++){
      for(int j = 0;j < mapY;j++){
        fill(map(heightMap[i][j],0,MAX_HEIGHT_BEFORE,0,255),0,0);
        if(heightMap[i][j] < SEA_LEVEL){
          fill(0,0,map(heightMap[i][j],0,MAX_HEIGHT_BEFORE,100,255));
        }
        //rect(i*scaleX, j*scaleY, scaleX, scaleY);
        
        fill(0, 0, humidityMap[i][j]*255);
        rect(i*scaleX, j*scaleY, scaleX, scaleY);
      }
    }
    for(int i = 0;i < mapX;i++){
      for(int j = 0;j < mapY;j++){
        if(riverMap[i][j]!=0){
          fill(255, 0, 0);
          ellipse(i*scaleX, j*scaleY, 3, 3);
        }
      }
    }
    
    println("Land percentage: ", landPercentage*100,"%");
    println("Shore to land percentage: ", shorePercentage*100,"%");
    println("Shore Complexity: ", shoreComplexity);
    
  }
  
  public float getLandPercentage(){
    return landPercentage;
  }
  
  public float getShorePercentage(){
    return shorePercentage;
  }
  
  public float getShoreComplexity(){
    return shoreComplexity;
  }
  
}
