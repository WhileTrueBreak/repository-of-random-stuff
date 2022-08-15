float TS = 20;
float DeltaT;

ArrayList<element> flock = new ArrayList();
ArrayList<element2> flock2 = new ArrayList();
ArrayList<element2> flock2toRemove = new ArrayList();
ArrayList<circle> circles = new ArrayList();

void setup(){
  size(1000, 600);
  for(int i = 0;i < 0;i++){
    circles.add(new circle(new PVector(random(20,width-20),random(20,height-20))));
  }
  for(int i = 0;i < 1000;i++){
    flock.add(new element(new PVector(random(20,width-20),random(20,height-20))));
  }
  for(int i = 0;i < 0;i++){
    flock2.add(new element2(new PVector(random(500,510),random(300,310))));
  }
}

void draw(){
  DeltaT = TS/frameRate;
  println(DeltaT);
  background(0);
  for(int i = 0;i < flock.size();i++){
    element e = flock.get(i);
    ArrayList<element> tempFlock = new ArrayList();
    for(element e1:flock){
      if(e != e1){
        tempFlock.add(e1);
      }
    }
    e.run_movement(tempFlock);
    e.avoid(flock2);
  }
  for(int i = 0;i < flock2.size();i++){
    element2 e = flock2.get(i);
    ArrayList<element2> tempFlock = new ArrayList();
    for(element2 e1:flock2){
      if(e != e1){
        tempFlock.add(e1);
      }
    }
    e.run_movement(tempFlock);
    e.chase(flock);
  }
  for(element e:flock){
    e.update();
    e.display();
  }
  for(element2 e:flock2){
    e.update();
    e.display();
    if(e.isDead()){
      flock2toRemove.add(e);
    }
  }
  for(circle c:circles){
    //c.display();
  }
  flock2.removeAll(flock2toRemove);
  fill(255,0,0);
  //text(frameRate,width-100,20);
}

void mouseReleased(){
  flock2.add(new element2(new PVector(mouseX,mouseY)));
}
