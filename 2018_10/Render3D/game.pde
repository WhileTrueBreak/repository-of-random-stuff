class game{
  
  player p;
  
  rayManager rm;
  lineManager lm;
  blockManager bm;
  block3DManager b3dm;
  handler h;
  
  game(){
    h = new handler(this);
    p = new player(new PVector(500,500),h);
    rm = new rayManager(h);
    lm = new lineManager(h);
    bm = new blockManager(h);
    b3dm = new block3DManager(h);
    //bm.addBlock(new block(new PVector(700,0),new PVector(800,0),new PVector(800,1000),new PVector(700,1000),h));
    bm.addBlock(new block(new PVector(550,0),new PVector(600,0),new PVector(600,1000),new PVector(550,1000),h));
    bm.addBlock(new block(new PVector(525,0),new PVector(475,0),new PVector(475,250),new PVector(525,200),h));
    bm.addBlock(new block(new PVector(450,0),new PVector(400,0),new PVector(400,700),new PVector(450,700),h));
    bm.addBlock(new block(new PVector(450,800),new PVector(400,800),new PVector(400,1000),new PVector(450,1000),h));
  }
  
  public void update(){
    p.update();
    rm.update();
    lm.update();
    bm.update();
    b3dm.update();
  }
  
  public void render(){
    if(!view3d){
      p.render();
      rm.render();
      lm.render();
      bm.render();
    }else{
      b3dm.render();
    }
  }
  
}