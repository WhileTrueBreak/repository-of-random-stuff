ArrayList<PVector>points = new ArrayList<PVector>();

void setup(){
  size(512, 512);
  //create point
  for(int i=0;i<10;i++){
    points.add(new PVector(random(width), random(height)));
  }
  //space properly
  for(int n=0;n<100;n++){
    //find point values
    float[] values = new float[points.size()];
    for(int i=0;i<points.size();i++){
      float total = 0;
      for(int j=0;j<points.size();j++){
        if(i==j)continue;
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x, points.get(j).y);
        
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x-width, points.get(j).y);
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x+width, points.get(j).y);
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x, points.get(j).y-height);
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x, points.get(j).y+height);
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x-width, points.get(j).y-height);
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x-width, points.get(j).y+height);
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x+width, points.get(j).y-height);
        total += 1/dist(points.get(i).x, points.get(i).y, points.get(j).x+width, points.get(j).y+height);
      }
      values[i] = total;
    }
    //get largest
    float largest = 0;
    float smallest = 10000;
    int lIndex = 0;
    for(int i=0;i<values.length;i++){
      if(values[i] > largest){
        largest = values[i];
        lIndex = i;
      }
      if(values[i] < smallest){
        smallest = values[i];
      }
    }
    println(lIndex);
    points.remove(lIndex);
    points.add(new PVector(random(width), random(height)));
  }
  
  //make tileable
  int size = points.size();
  for(int i=0;i<size;i++){
    points.add(new PVector(points.get(i).x-width, points.get(i).y));
    points.add(new PVector(points.get(i).x+width, points.get(i).y));
    points.add(new PVector(points.get(i).x, points.get(i).y-height));
    points.add(new PVector(points.get(i).x, points.get(i).y+height));
    points.add(new PVector(points.get(i).x-width, points.get(i).y-height));
    points.add(new PVector(points.get(i).x-width, points.get(i).y+height));
    points.add(new PVector(points.get(i).x+width, points.get(i).y-height));
    points.add(new PVector(points.get(i).x+width, points.get(i).y+height));
  }
}

void draw(){
  loadPixels();
  for(int i=0;i<width;i++){
    for(int j=0;j<height;j++){
      float mdist = width+height;
      for(PVector p:points){
        float d = dist(i, j, p.x, p.y);
        if(d < mdist){
          mdist = d;
        }
      }
      pixels[j*width+i] = color(map(mdist,0,200,255,100));
    }
  }
  updatePixels();
  saveFrame("##.png");
  stop();
}
