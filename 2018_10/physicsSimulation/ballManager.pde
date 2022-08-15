class ballManager{
  
  ArrayList<ball>balls;
  handler h;
  
  ballManager(handler h){
    this.h = h;
    balls = new ArrayList();
  }
  
  void applyGravity(){
    for(ball b:balls){
      b.applyForce(gravity);
    }
  }
  
  void update(){
    applyGravity();
    for(ball b:balls){
      b.update();
    }
  }
  
  void render(){
    for(ball b:balls){
      b.render();
    }
  }
  
  void addBall(ball b){
    balls.add(b);
  }
  
}