class block3DManager{
  
  ArrayList<block3D>blocks3D;
  
  handler h;
  
  block3DManager(handler h){
    this.h = h;
    blocks3D = new ArrayList();
  }
  
  public void update(){
    for(block3D b:blocks3D){
      b.update();
    }
  }
  
  public void render(){
    for(block3D b:blocks3D){
      b.render();
    }
    blocks3D = new ArrayList();
  }
  
  public void add3DBlock(block3D b){
    blocks3D.add(b);
  }
  
}