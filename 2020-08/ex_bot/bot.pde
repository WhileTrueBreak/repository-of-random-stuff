class Bot{
  
  
  float expectation = 0;
  float mood = 0;
  
  
  PVector pos;
  Entity dest = null;
  Entity prevDest = null;
  
  
  Bot(PVector pos){
    this.pos=pos;
  }
  public void render(){
    strokeWeight(3);
    stroke(map(mood,-10,10,255,0),map(mood,-10,10,0,255),0);
    fill(255);
    ellipse(pos.x, pos.y, 10, 10);
  }
  public void update(){
    findDest(entities);
    move();
  }
  public void findDest(ArrayList<Entity>entities){
    if(dest==null&&entities.size()>0){
      dest = entities.get(floor(random(entities.size())));
      if(prevDest!=dest){
        prevDest = dest;
      }else{
        dest = null;
      }
    }
  }
  public void move(){
    if(dest!=null){
      PVector dPos = dest.pos;
      if(dist(pos.x, pos.y, dPos.x, dPos.y)>10){
        PVector diff = PVector.sub(dPos, pos);
        diff.setMag(1);
        pos.add(diff);
      }else{
        float dValue = dest.value;
        float vDiff = dValue-expectation;
        expectation += 1/(1+Math.exp(-vDiff-dValue))-0.5f;
        mood+=vDiff+dValue;
        println("Mood Change: "+str(vDiff+dValue));
        println("Mood: "+str(mood));
        println("Expectation: "+str(expectation));
        dest=null;
      }
    }
  }
}
