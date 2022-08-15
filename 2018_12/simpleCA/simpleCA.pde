Terrain terrain;

void setup(){
  terrain = new Terrain();
  size(800,800);
}

void draw(){
  //terrain.getPixel(300,300);
  println(terrain.getPixel(300,300));
  terrain.display();
}