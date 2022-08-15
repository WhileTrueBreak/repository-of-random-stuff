PVector[] points = new PVector[100];

void setup(){
  size(800, 800);
  for(int i = 0;i < points.length;i++){
    points[i] = new PVector(random(width), random(height));
  }
}

void draw(){
  loadPixels();
  for(int x = 0;x < width;x++){
    for(int y = 0;y < width;y++){
      float[] distance = new float[points.length];
      for(int i = 0;i < points.length;i++){
        distance[i] = dist(x, y, points[i].x, points[i].y);
      }
      float[] sorted = sort(distance);
      pixels[x+y*width] = color((int)map(sorted[0],width/2,0,255,0), (int)map(sorted[1],width/2,0,255,0), (int)map(sorted[2],width/2,0,255,0));
    }
  }
  updatePixels();
  noLoop();
}
