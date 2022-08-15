ArrayList<PointManager>pms = new ArrayList<PointManager>();
ArrayList<PointManager>toRemove = new ArrayList<PointManager>();
void setup(){
  //fullScreen();
  size(600, 600);
}

void draw(){
  background(0);
  for(PointManager pm:pms){
    pm.update();
    pm.render();
    if(pm.canRemove()){
      toRemove.add(pm);
    }
  }
  pms.removeAll(toRemove);
}

void mouseReleased(){
  float mag = dist(mouseX, mouseY, width/2, height/2);
  PointManager pm = new PointManager();
  pm.createHit(10, 15);
  pms.add(pm);
}
