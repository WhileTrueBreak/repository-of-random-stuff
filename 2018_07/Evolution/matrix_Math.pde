class matrix{
  matrix(){
    
  }
  float[][] arrayToMatrix(float[] a1){
    float[][] out = new float[a1.length][1];
    for(int i = 0;i < a1.length;i++){
      out[i][0]=a1[i];
    }
    return out;
  }
  float[] matrixToArray(float[][] m1,int row){
    float[] out = new float[m1.length];
    for(int i = 0;i < m1.length;i++){
      out[i]=m1[i][row];
    }
    return out;
  }
  //random matrix
  float[][] Random(int x,int y,float min,float max){
    float[][] out = new float[y][x];
    for(int i = 0;i < out.length;i++){
      for(int j = 0;j < out[0].length;j++){
        out[i][j]=random(min,max);
      }
    }
    return out;
  }
  //Entrywise sum
  float[][] entSum(float[][] m1,float[][] m2){
    float[][] out = new float[m2.length][m2[0].length];
    for(int i = 0;i < out.length;i++){
      for(int j = 0;j < out[0].length;j++){
        out[i][j] = m1[i][j]+m2[i][j];
      }
    }
    return out;
  }
  //subtraction
  float[][] Sub(float[][] m1,float[][] m2){
    float[][] out = new float[m1.length][m1[0].length];
    for(int i = 0;i < out.length;i++){
      for(int j = 0;j < out[0].length;j++){
        out[i][j] = m1[i][j]-m2[i][j];
      }
    }
    return out;
  }
  //Direct Sum
  float[][] directSum(float[][] m1,float[][] m2){
    float[][] out = new float[m1.length+m2.length][m1[0].length+m2[0].length];
    for(int i = 0;i < m1.length;i++){
      for(int j = 0;j < m1[0].length;j++){
        out[i][j] = m1[i][j];
      }
    }
    for(int i = m1.length;i < m2.length+m1.length;i++){
      for(int j = m1[0].length;j < m2[0].length+m1[0].length;j++){
        out[i][j] = m2[i-m1.length][j-m1[0].length];
      }
    }
    return out;
  }
  //Product
  float[][] Mult(float[][] m1,float[][] m2){
    float[][] out = new float[m1.length][m2[0].length];
    for(int m1y = 0;m1y < out.length;m1y++){
      for(int m2x = 0;m2x < out[0].length;m2x++){
        float total = 0;
        for(int m2y = 0;m2y < m1[0].length;m2y++){
          total += m1[m1y][m2y]*m2[m2y][m2x];
        }
        out[m1y][m2x] = total;
      }
    }
    return out;
  }
  float[][] dMult(float[][] m1,float[][] m2){
    float[][] out = new float[m1.length][m2[0].length];
    for(int m1y = 0;m1y < out.length;m1y++){
      for(int m2x = 0;m2x < out[0].length;m2x++){
        float total = 0;
        for(int m2y = 0;m2y < m1[0].length;m2y++){
          total += m1[m1y][m2y]*m2[m2y][m2x];
        }
        out[m1y][m2x] = total;
      }
    }
    return out;
  }
  float[][] Transpose(float[][] m1){
    float[][] out = new float[m1[0].length][m1.length];
    for(int m1y = 0;m1y < m1.length;m1y++){
      for(int m1x = 0;m1x < m1[0].length;m1x++){
        out[m1x][m1y]=m1[m1y][m1x];
      }
    }
    return out;
  }
  float[][] Mult(float[][] m1,float n){
    float[][] out = new float[m1.length][m1[0].length];
    for(int m1y = 0;m1y < m1.length;m1y++){
      for(int m1x = 0;m1x < m1[0].length;m1x++){
        out[m1y][m1x]=m1[m1y][m1x]*n;
      }
    }
    return out;
  }
  float[][] mapMult(float[][] m1,float[][] m2){
    float[][] out = new float[m1.length][m1[0].length];
    for(int y = 0;y < m1.length;y++){
      for(int x = 0;x < m1[0].length;x++){
        out[y][x]=m1[y][x]*m2[y][x];
      }
    }
    return out;
  }
}