ArrayList<block>blocks = new ArrayList();
boolean pMade = false;
path p;

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
  if(pMade){
    if(!p.rayToFin(blocks)){
      p.moveDoneM();
      p.removeCrowd();
      p.rayC(blocks);
      p.checkCrowd();
      p.checkClosest();
      p.display();
    }else{
      //p.removeIllegal();
      p.optPath();
      p.displayP();
    }
  }
  fill(255,0,0);
  textSize(20);
  text(frameRate,width-70,25);
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
  pMade = true;
  p = new path(new PVector(5,5),new PVector(width-5,height-5));
}