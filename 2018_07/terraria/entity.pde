class entity{
  boolean collide(float x, float y, float w, float h){
    for(chunk c:chunks){
      for(int i = 0;i < c.chunkMap.length;i++){
        for(int j = 0;j < c.chunkMap[i].length;j++){
          if(x < i*10+c.px+10&&x+w > i*10+c.px&&y < j*10+c.py+10&&y+h > j*10+c.py&&c.chunkMap[i][j] != 0){
            return true;
          }
        }
      }
    }
    return false;
  }
}