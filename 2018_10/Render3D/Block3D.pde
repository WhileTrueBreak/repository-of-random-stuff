class block3D{
  
  float angle;
  float onScreenXPos;
  float dist;
  int tracedNum;
  
  block3D(float onScreenXPos, float dist, int tracedNum, float angle){
    this.onScreenXPos = onScreenXPos;
    this.dist = dist;
    this.tracedNum = tracedNum;
    this.angle = angle;
  }
  
  public void update(){
    
  }
  
  public void render(){
    float Rh = 50/dist*height;
    float Cdist = map(dist, 0, 400, 255, 0);
    PVector pos = new PVector(onScreenXPos, height/2-(Rh)/2);
    noStroke();
    fill(Cdist);
    rect(pos.x,pos.y,width/tracedNum, Rh);
  }
  
  public float castToSemi(float in, float size){
    return sqrt(pow(size,2)-pow(in,2));
  }
}