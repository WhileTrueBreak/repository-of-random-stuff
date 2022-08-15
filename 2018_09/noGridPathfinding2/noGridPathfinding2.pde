ArrayList<block>blocks = new ArrayList();
boolean mapMade = false;
pointMap pm;

public void setup(){
  size(1000,1000);
  for(int i = 0;i < 0;i++){
    blocks.add(new block(new PVector(random(width),random(height))));
  }
}

public void draw(){
  background(0);
  for(block b:blocks){
    b.display();
  }
  if(mapMade){
    if(!pm.rayToFin(blocks)){
      pm.roundC();
      pm.checkClosest();
      pm.updateFromC();
      pm.displayPoint();
    }else{
      pm.optPath();
      pm.displayP();
    }
  }
}

public void mouseDragged(){
  boolean on = true;
  for(block b:blocks){
    if(mouseX>b.pos.x-2&&mouseX<b.pos.x+b.dime.x+2&&mouseY>b.pos.y-2&&mouseY<b.pos.y+b.dime.y+2){
      on = false;
    }
  }
  if(on){
    blocks.add(new block(new PVector(mouseX-5,mouseY-5)));
  }
}

public void keyReleased(){
  mapMade = true;
  pm = new pointMap(new PVector(5,5),new PVector(width-5,height-5));
  println("Connecting points");
  pm.checkAllReachable();
}