class RayWall extends RayObject{
  
  public RayWall(float x1, float y1, float x2, float y2){
    super(x1, y1, x2, y2);
  }
  
  public void render(){
    stroke(255);
    line(x1, y1, x2, y2);
  }
  public void update(){}
  
}

class RayMirror extends RayObject{
  
  public RayMirror(float x1, float y1, float x2, float y2){
    super(x1, y1, x2, y2);
  }
  
  public void render(){
    stroke(255, 0, 255);
    line(x1, y1, x2, y2);
  }
  public void update(){}
  
}

class RayRotate extends RayObject{
  
  private float angle;
  
  public RayRotate(float x1, float y1, float x2, float y2, float angle){
    super(x1, y1, x2, y2);
    this.angle = angle;
  }
  
  public void render(){
    stroke(255, 255, 0);
    line(x1, y1, x2, y2);
  }
  public void update(){}
  
  public float getAngle(){
    return angle;
  }
  
}

abstract class RayObject{
  
  protected float x1, y1, x2, y2;
  
  public RayObject(float x1, float y1, float x2, float y2){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  
  public abstract void render();
  public abstract void update();
  
  public float getX1(){
    return x1;
  }
  
  public float getY1(){
    return y1;
  }
  
  public float getX2(){
    return x2;
  }
  
  public float getY2(){
    return y2;
  }
  
}
