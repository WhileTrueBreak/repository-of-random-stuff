float[][] gridS;
float[][] yxgridS;

float monty_carlo(float min, float max){
  float r1 = random(min,max);
  float r2 = random(min,max);
  if(r1 < r2){
    return r1;
  }
  return r2;
}

void setup(){
  size(400,400);
  gridS = new float[width][height];
  yxgridS = new float[width][height];
  for(int i = 1;i < width-1;i++){
    for(int j = 1;j < height-1;j++){
      gridS[i][j] = -1;
    }
  }
  for(int i = 0;i < 5000;i++){
    int xr = floor(random(1,width-1));
    int yr = floor(random(1,height-1));
    float value = map(dist(200,200,xr,yr),200,0,0,255);
    if(monty_carlo(0,255)>value){
      continue;
    }
    gridS[xr][yr] = value;
  }
  for(int i = 0;i < gridS.length;i++){
    for(int j = 0;j < gridS[i].length;j++){
      yxgridS[i][j] = gridS[i][j];
    }
  }
  ////
  for(int i = 0;i < gridS[0].length;i++){//solving y of xygrid
    float[] col = new float[gridS.length];
    for(int j = 0;j < gridS.length;j++){
      col[j] = gridS[j][i];
    }
    boolean continueT = false;
    for(int j = 1;j < col.length-1;j++){//test for black line
      if(col[j] != -1){
        continueT = true;
      }
    }
    if(!continueT){
      continue;
    }
    int lastIndex = 0;
    for(int j = 1;j < col.length;j++){
      if(col[j] != -1){
        float m = (col[j]-col[lastIndex])/(j-lastIndex);
        for(int k = lastIndex;k < j;k++){
          int relaPos = k-lastIndex;
          float change = m*relaPos;
          yxgridS[k][i] = change+col[lastIndex];
        }
        lastIndex = j;
      }
    }
  }
  ////
  for(int i = 0;i < gridS.length;i++){//solving x of xygrid
    float[] row = yxgridS[i];
    int lastIndex = 0;
    for(int j = 1;j < row.length;j++){
      if(row[j] != -1){
        float m = (row[j]-row[lastIndex])/(j-lastIndex);
        for(int k = lastIndex;k < j;k++){
          int relaPos = k-lastIndex;
          float change = m*relaPos;
          yxgridS[i][k] = change+row[lastIndex];
        }
        lastIndex = j;
      }
    }
  }
  ////
  for(int i = 0;i < gridS.length;i++){//solving x of xygrid
    float[] row = gridS[i];
    boolean continueT = false;
    for(int j = 1;j < row.length-1;j++){//test for black line
      if(row[j] != -1){
        continueT = true;
      }
    }
    if(!continueT){
      continue;
    }
    int lastIndex = 0;
    for(int j = 1;j < row.length;j++){
      if(row[j] != -1){
        float m = (row[j]-row[lastIndex])/(j-lastIndex);
        for(int k = lastIndex;k < j;k++){
          int relaPos = k-lastIndex;
          float change = m*relaPos;
          gridS[i][k] = change+row[lastIndex];
        }
        lastIndex = j; //<>// //<>// //<>// //<>// //<>//
      }
    }
  }
  ////
  for(int i = 0;i < gridS[0].length;i++){//solving y of xygrid
    float[] col = new float[gridS.length];
    for(int j = 0;j < gridS.length;j++){
      col[j] = gridS[j][i];
    }
    int lastIndex = 0;
    for(int j = 1;j < col.length;j++){
      if(col[j] != -1){
        float m = (col[j]-col[lastIndex])/(j-lastIndex);
        for(int k = lastIndex;k < j;k++){
          int relaPos = k-lastIndex;
          float change = m*relaPos;
          gridS[k][i] = change+col[lastIndex];
        }
        lastIndex = j;
      }
    }
  }
  //average the two grids
  for(int i = 0;i < gridS.length;i++){
    for(int j = 0;j < gridS[i].length;j++){
      gridS[i][j] = (gridS[i][j]+yxgridS[i][j])/2;
    }
  }
}

void draw(){
  background(255);
  for(int i = 0;i < gridS.length;i++){
    for(int j = 0;j < gridS[i].length;j++){
      if(gridS[i][j]!=-1){
        noStroke();
        fill(gridS[i][j]);
        rect(j,i,1,1);
      }
    }
  }
}