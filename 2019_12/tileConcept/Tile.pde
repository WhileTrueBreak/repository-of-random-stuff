public class Tile{
  
  private BObject bObject;
  private FObject fObject;
  
  public Tile(BObject bo, FObject fo){
    this.bObject = bo;
    this.fObject = fo;
  }
  
  public void update(){
    bObject.update();
    fObject.update();
  }
  
  public void render(float xPos, float yPos){
    bObject.render(xPos, yPos);
    fObject.render(xPos, yPos);
  }
  
}
