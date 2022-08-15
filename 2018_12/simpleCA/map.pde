class Terrain{
  
  PImage mapT;
  
  Terrain(){
    mapT = loadImage("map.png");
  }
  
  void display(){
    image(mapT,0,0);
  }
  
  color getPixel(int x, int y){
    mapT.loadPixels();
    return mapT.get(x,y);
  }
}