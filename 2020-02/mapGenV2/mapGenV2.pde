static final int MAP_X = 128, MAP_Y = 128;
static final int VORONOI_NODE_COUNT = 20;
static final float WATER_LV = 0;

Cell[][] cells;
PVector[] vPoints;

void setup(){
  size(768, 768);
  
  cells = new Cell[MAP_X][MAP_Y];
  vPoints = new PVector[VORONOI_NODE_COUNT];
  
  float xcen = MAP_X/2, ycen = MAP_Y/2;
  float xoff = 0.05*128/MAP_X, yoff = 0.05*128/MAP_Y;
  
  for(int i = 0;i < VORONOI_NODE_COUNT;i++){
    vPoints[i] = new PVector(random(width), random(height));
  }
  
  for(int x = 0;x < MAP_X;x++){
    for(int y = 0;y < MAP_Y;y++){
      float cDist = map(dist(xcen, ycen, x, y), 0, dist(xcen, ycen, 0, 0), 0, -1);
      float[] distance = new float[vPoints.length];
      for(int i = 0;i < vPoints.length;i++){
        distance[i] = dist(x*(width/128), y*(height/128), vPoints[i].x, vPoints[i].y);
      }
      float[] sorted = sort(distance);
      float vDist = min(max(sorted[0]/2*255/(width/sqrt(VORONOI_NODE_COUNT)),0),255);
      cells[x][y] = new Cell(vDist);
    }
  }
}

void draw(){
  float xstep = 768/MAP_X, ystep = 768/MAP_Y;
  for(int x = 0;x < MAP_X;x++){
    for(int y = 0;y < MAP_Y;y++){
      cells[x][y].renderTile(x*xstep, y*ystep, xstep, ystep);
    }
  }
  for(PVector p:vPoints){
    fill(255, 0, 0);
    ellipse(p.x, p.y, 2, 2);
  }
}
