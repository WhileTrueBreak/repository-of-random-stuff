PVector matrixVectorMult(float[][] m1, PVector p1){
  PVector p2 = new PVector(0,0,0);
  p2.x = m1[0][0]*p1.x+m1[0][1]*p1.y+m1[0][2]*p1.z;
  p2.y = m1[1][0]*p1.x+m1[1][1]*p1.y+m1[1][2]*p1.z;
  p2.z = m1[2][0]*p1.x+m1[2][1]*p1.y+m1[2][2]*p1.z;
  return p2;
}
float[][] matrixFloatMult(float[][] m1, float s){
  float m2[][] = new float[m1.length][m1[0].length];
  for(int i = 0;i < m1.length;i++){
    for(int j = 0;j < m1[i].length;j++){
      m2[i][j] = m1[i][j]*s;
    }
  }
  return m2;
}
float[][] getRotXMat(float theta){
  float radTheta = radians(theta);
  float[][] m1 = {
    {1,0,0},
    {0,cos(radTheta),-sin(radTheta)},
    {0,sin(radTheta),cos(radTheta)}
  };
  return m1;
}
float[][] getRotYMat(float theta){
  float radTheta = radians(theta);
  float[][] m1 = {
    {cos(radTheta),0,sin(radTheta)},
    {0,1,0},
    {-sin(radTheta),0,cos(radTheta)}
  };
  return m1;
}
float[][] getRotZMat(float theta){
  float radTheta = radians(theta);
  float[][] m1 = {
    {cos(radTheta),-sin(radTheta),0},
    {sin(radTheta),cos(radTheta),0},
    {0,0,1}
  };
  return m1;
}
float[][] getProjMat(){
  float[][] m1 = {
    {1,0,0},
    {0,1,0},
    {0,0,0}
  };
  return m1;
}
