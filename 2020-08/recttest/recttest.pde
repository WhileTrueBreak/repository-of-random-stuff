ArrayList<Wall>walls = new ArrayList<Wall>();

void setup(){
  size(800, 800);
  background(0);
  
  walls.addAll(createRect());
  walls.addAll(createRect());
  
  println(walls.size());
  walls = splitWalls(walls);
  println(walls.size());
  
  for(Wall wall:walls){
    wall.render();
  }
}

ArrayList<Wall> splitWalls(ArrayList<Wall>walls){
  ArrayList<Wall>newWalls = new ArrayList<Wall>();
  for(Wall w:walls){
    newWalls.add(w);
  }
  
  for(Wall w1:walls){
    for(Wall w2:walls){
      PVector collisionPoint = lineLine(w1.x1, w1.y1, w1.x2, w1.y2, w2.x1, w2.y1, w2.x2, w2.y2);
      if(collisionPoint!=null){
        newWalls.add(new Wall(w1.x1, w1.y1, collisionPoint.x, collisionPoint.y));
        newWalls.add(new Wall(w1.x2, w1.y2, collisionPoint.x, collisionPoint.y));
        newWalls.remove(w1);
      }
    }
  }
  return newWalls;
}

ArrayList<Wall> createRect(){
  ArrayList<Wall>walls = new ArrayList<Wall>();
  int stepSize = 20;
  //create random dimensions
  float x, y, w, h;
  
  do{
    w = floor(random(1)*stepSize);
    h = floor(random(1)*stepSize);
    x = floor(random(1-(w/stepSize))*stepSize);
    y = floor(random(1-(h/stepSize))*stepSize);
  }while(w == 0||h == 0);
  
  w *= width/stepSize;
  h *= height/stepSize;
  x *= width/stepSize;
  y *= height/stepSize;
  
  walls.add(new Wall(x, y, x+w, y));
  walls.add(new Wall(x, y, x, y+h));
  walls.add(new Wall(x+w, y, x+w, y+h));
  walls.add(new Wall(x, y+h, x+w, y+h));
  
  return walls;
}
