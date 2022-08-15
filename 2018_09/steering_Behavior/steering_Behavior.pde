boolean debug = false;

ArrayList<element> elements = new ArrayList();
element2 e2;

void setup(){
  fullScreen();
  for(int i = 0;i < 500;i++){
    elements.add(new element(new PVector(random(width),random(height))));
  }
  e2 = new element2(new PVector(random(width),random(height)));
}

void draw(){
  background(0);
  for(element e1:elements){
    e1.avoidBound();
    e1.steer();
    //e1.follow();
    //if(dist(e1.pos.x,e1.pos.y,e2.pos.x,e2.pos.y)<250){
    //  e1.avoid();
    //}
    e1.update();
    e1.display();
    if(dist(e1.pos.x,e1.pos.y,e1.target.x,e1.target.y)<10){
      e1.target = new PVector(random(50,width-50),random(50,height-50));
    }
  }
  e2.avoidBound();
  e2.steer();
  e2.update();
  e2.display();
  if(dist(e2.pos.x,e2.pos.y,e2.target.x,e2.target.y)<10){
    e2.target = new PVector(random(50,width-50),random(50,height-50));
  }
}

PVector truncate(PVector i1, float max){
  if(i1.mag()>max){
    return i1.copy().setMag(max);
  }
  return i1.copy();
}