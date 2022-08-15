class chunk{
  float jaggedness = 50;
  
  float seed;
  
  int[][] chunkMap = new int[10][1000];
  float xincrement = 0.05;
  float xoff;
  float yoff = -100;
  float px;
  float py = -chunkMap[0].length/2*10+500;
  chunk(float seed_,float x){
    xoff = seed_;
    seed = seed_;
    px = x;
    for(int i = 0;i < chunkMap.length;i++){
      for(int j = 0;j < chunkMap[i].length;j++){
        chunkMap[i][j] = 0;
      }
    }
    for(int i = 0;i < chunkMap.length;i++){
      for(int j = chunkMap[i].length-1;j >= floor(noise(xoff)*jaggedness+chunkMap[i].length/2);j--){
        chunkMap[i][j] = 1;
        if(j-floor(noise(xoff)*jaggedness+chunkMap[i].length/2)<noise(xoff*2,yoff)*20){
          chunkMap[i][j] = 2;
        }if(j-1<=floor(noise(xoff)*jaggedness+chunkMap[i].length/2)&&chunkMap[i][j] == 2){
          chunkMap[i][j] = 3;
        }
      }
      xoff+=xincrement;
    }
  }
  void display(){
    for(int i = 0;i < chunkMap.length;i++){
      for(int j = 0;j < chunkMap[i].length;j++){
        noStroke();
        if(chunkMap[i][j] == 1){
          fill(138);
          rect(i*10+px,j*10+py,10,10);
        }else if(chunkMap[i][j] == 2){
          fill(125,50,0);
          rect(i*10+px,j*10+py,10,10);
        }else if(chunkMap[i][j] == 3){
          fill(0,255,0);
          rect(i*10+px,j*10+py,10,10);
        }
 
      }
    }
  }
}