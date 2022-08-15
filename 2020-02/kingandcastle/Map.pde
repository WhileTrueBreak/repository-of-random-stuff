class World{
  Tile[][] map;
  
  World(int sizeX, int sizeY){
    map = new Tile[sizeX][sizeY];
  }
  
  void createMap(){
    for(int i = 0;i < map.length;i++){
      for(int j = 0;j < map[i].length;j++){
        map[i][j] = new Tile();
      }
    }
  }
  
  void update(){
    for(int i = 0;i < map.length;i++){
      for(int j = 0;j < map[i].length;j++){
        map[i][j].update();
      }
    }
  }
  
  void render(){
    for(int i = 0;i < map.length;i++){
      for(int j = 0;j < map[i].length;j++){
        map[i][j].render(i*GRID_SIZE,j*GRID_SIZE);
      }
    }
  }
  
}