class terrain{
  
  float zOff = 0;
  
  float[][] heightMap;
  PVector[][] points;
  color[][] pointsC;
  PVector[][] rotPoints;
  PVector[][] projPoints;
  //index 1 is Y
  //index 2 is X
  float maxHeight;
  
  float xScl, yScl;
  int pointsX, pointsY;
  float offset;
  
  terrain(int pointsX, int pointsY, float xScl, float yScl, float offset, float maxHeight, int noiseSeed){
    this.pointsX = pointsX;
    this.pointsY = pointsY;
    this.offset = offset;
    heightMap = new float[pointsY][pointsX];
    points = new PVector[pointsY][pointsX];
    pointsC = new color[pointsY][pointsX];
    rotPoints = new PVector[pointsY][pointsX];
    projPoints = new PVector[pointsY][pointsX];
    this.maxHeight = maxHeight;
    this.xScl = xScl;
    this.yScl = yScl;
    noiseSeed(noiseSeed);
    float yOff = 0;
    for(int y = 0;y < heightMap.length;y++){
      float xOff = 0;
      for(int x = 0;x < heightMap[y].length;x++){
        float h = noise(xOff, yOff,zOff)*maxHeight;
        pointsC[y][x] = color(0,200,0);
        if(h < 170){
          h = 170;
          pointsC[y][x] = color(0,200,255);
          if(x % 2 == 0&&y % 2 == 0){
            h = 172;
          }
        }
        heightMap[y][x] = h;
        points[y][x] = new PVector(x*xScl-pointsX*xScl/2,y*yScl-pointsY*yScl/2,h);
        xOff += offset;
      }
      yOff += offset;
    }
  }
  void rotateXYZ(float x, float y, float z){
    float[][] rotX = getRotXMat(x);
    float[][] rotY = getRotYMat(y);
    float[][] rotZ = getRotZMat(z);
    for(int i = 0;i < points.length;i++){
      for(int j = 0;j < points[i].length;j++){
        rotPoints[i][j] = matrixVectorMult(rotZ,points[i][j]);
        rotPoints[i][j] = matrixVectorMult(rotY,rotPoints[i][j]);
        rotPoints[i][j] = matrixVectorMult(rotX,rotPoints[i][j]);
      }
    }
  }
  
  int r = 0;
  
  void update(){
    zOff+=0.01;
    float yOff = 0;
    for(int y = 0;y < heightMap.length;y++){
      float xOff = 0;
      for(int x = 0;x < heightMap[y].length;x++){
        float h = noise(xOff, yOff,zOff)*maxHeight;
        pointsC[y][x] = color(0,200,0);
        if(h < 170){
          h = 170;
          pointsC[y][x] = color(13,119,255);
          if(x % 2 == 0&&y % 2 == 0){
            h = 172;
          }
        }
        heightMap[y][x] = h;
        points[y][x] = new PVector(x*xScl-pointsX*xScl/2,y*yScl-pointsY*yScl/2,h);
        xOff += offset;
      }
      yOff += offset;
    }
  }
  void projectPoints(){
    for(int y = 0;y < rotPoints.length;y++){
      for(int x = 0;x < rotPoints[y].length;x++){
        projPoints[y][x] = matrixVectorMult(getProjMat(),rotPoints[y][x]).mult(0.7);
      }
    }
  }
  void display(float xS, float yS){
    rotateXYZ(65,0,r);
    r++;
    projectPoints();
    for(int y = 0;y < projPoints.length-1;y++){
      for(int x = 0;x < projPoints[y].length-1;x++){
        noFill();
        stroke(pointsC[y][x]);
        strokeWeight(1);
        triangle(projPoints[y][x].x+xS,projPoints[y][x].y+yS,projPoints[y+1][x].x+xS,projPoints[y+1][x].y+yS,projPoints[y+1][x+1].x+xS,projPoints[y+1][x+1].y+yS);
        triangle(projPoints[y][x].x+xS,projPoints[y][x].y+yS,projPoints[y][x+1].x+xS,projPoints[y][x+1].y+yS,projPoints[y+1][x+1].x+xS,projPoints[y+1][x+1].y+yS);
        //point(projPoints[y][x].x+200,projPoints[y][x].y+200);
      }
    }
  }
}