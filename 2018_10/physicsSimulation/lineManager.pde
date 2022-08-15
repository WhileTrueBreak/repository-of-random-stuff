class lineManager{
  
  ArrayList<barrier> barriers;
  handler h;
  
  lineManager(handler h){
    this.h = h;
    barriers = new ArrayList();
  }
  
  void update(){
    for(barrier b:barriers){
      b.update();
    }
  }
  
  void render(){
    for(barrier b:barriers){
      b.render();
    }
  }
  
  void addBarrier(barrier b){
    barriers.add(b);
  }
  
}