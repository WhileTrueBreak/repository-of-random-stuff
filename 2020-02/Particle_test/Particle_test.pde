PointManager pm;

PVector prevMousePos;

void setup(){
  //fullScreen();
  size(600, 600);
  pm = new PointManager();
  prevMousePos = new PVector(mouseX, mouseY);
}

void draw(){
  background(0);
  float dist = dist(mouseX, mouseY, prevMousePos.x, prevMousePos.y);
  if(map(dist, 0, 10, 0, 1)>random(1)){
    float mag = random(2)-1;
    float theta = random(2*PI);
    PVector mVel = new PVector(mouseX, mouseY).sub(prevMousePos);
    if(mVel.mag()>1) mVel.setMag(1);
    pm.addPoint(new Point(mouseX, mouseY, mag*sin(theta)+mVel.x, mag*cos(theta)+mVel.y, (int)(60+random(120))));
  }
  prevMousePos = new PVector(mouseX, mouseY);
  pm.update();
  pm.render();
}
