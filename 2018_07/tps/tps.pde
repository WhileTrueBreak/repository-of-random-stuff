float TileSIZE = 50;
wall w = new wall(330,430,30,80,40);
ArrayList<tile>tiles = new ArrayList();

void setup(){
  size(1000,1000);
  //creating the tiles
  for(int i = 0;i < width/TileSIZE;i++){
    for(int j = 0;j < height/TileSIZE;j++){
      tiles.add(new tile(i*TileSIZE,j*TileSIZE));
    }
  }
}

void draw(){
  background(255);
  for(tile t:tiles){  
    if(collision(new PVector(t.x,t.y),new PVector(t.x,t.y+t.size),new PVector(t.x+t.size,t.y+t.size),new PVector(t.x+t.size,t.y),w.c1,w.c2,w.c3,w.c4)){
      t.checkBlocked(true);
      //println(t.x,t.y);
    }
    t.display();
  }
  w.display();
  fill(255,0,0);
  textSize(15);
  text(frameRate,width-70,15);
}