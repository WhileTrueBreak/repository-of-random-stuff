class Cell{
  
  float heightMap;
  
  Cell(float heightMap){
    this.heightMap = heightMap;
  }
  
  void renderTile(float x, float y, float w, float h){
    noStroke();
    fill(heightMap);
    if(heightMap<WATER_LV)
      fill(0, 0, 255);
    rect(x, y, w, h);
  }
  
}
