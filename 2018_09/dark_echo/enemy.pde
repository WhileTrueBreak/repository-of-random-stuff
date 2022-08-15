class enemy{
  ArrayList<sound> sounds = new ArrayList();
  ArrayList<sound> removeS = new ArrayList();
  
  int counterS = 0;
  int stepDelay = 20;
  boolean nextStep = false;
  
  PVector target = new PVector();
  
  PVector acc = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector pos = new PVector(500,500);
  
  enemy(PVector p){
    pos = p;
    target = p;
  }
  void display(PVector shift){
    for(sound s:sounds){
      s.display(shift);
    }
    //sounds.add(new sound(30,30,PVector.fromAngle(radians(random(0,360))),new PVector(pos.x+random(-5,5),pos.y+random(-5,5))));
  }
  void update(){
    PVector temp = new PVector(pos.x-target.x,pos.y-target.y);
    println(target);
    println(pos);
    acc.add(temp.setMag(0.1));
    vel.add(acc);
    pos.add(vel);
    if(counterS > stepDelay){
      nextStep = true;
    }else{
      counterS++;
    }
    for(sound s:sounds){
      s.update();
      if(s.gone()){
        removeS.add(s);
      }
    }
    sounds.removeAll(removeS);
  }
}