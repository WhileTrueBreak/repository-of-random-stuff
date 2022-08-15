class simulation{
  
  handler h;
  ballManager ballM;
  lineManager lineM;
  
  simulation(){
    h = new handler(this);
    ballM = new ballManager(h);
    lineM = new lineManager(h);
    for(int i = 0;i < 0;i++){
      ballM.addBall(new ball(new PVector(random(30,width-30),random(30,height-30)), random(10,30), h));
    }
  }
  
  void update(){
    lineM.update();
    ballM.update();
  }
  
  void render(){
    lineM.render();
    ballM.render();
  }
}