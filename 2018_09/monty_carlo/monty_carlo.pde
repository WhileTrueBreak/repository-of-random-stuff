ArrayList<rp>points = new ArrayList();
PVector center;
drawing d = new drawing();
tracing t = new tracing();
boolean startTrace = false;

void setup(){
  size(1000,1000);
  center = new PVector(width/2,height/2);
}

void draw(){
  background(0);
  noFill();
  stroke(255);
  ellipse(center.x, center.y, width, height);
  d.display();
  for(rp p:points){
    if(p.in){
      fill(255);
    }else{
      fill(100);
    }
    noStroke();
    ellipse(p.pos.x,p.pos.y,5,5);
  }
}

void mousePressed(){
  if(dist(center.x,center.y,mouseX,mouseY)<500){
    d.addPoint(new PVector(mouseX,mouseY));
    d.createLine();
  }
}
void keyPressed(){
  startTrace = true;
  for(int i = 0;i < 10000;i++){
    float rx = random(width);
    float ry = random(height);
    if(dist(center.x,center.y,rx,ry)<500){
      points.add(new rp(new PVector(rx,ry)));
    }else{
      i--;
    }
  }
  t.check();
  float areaOfCircle = PI * pow(500,2);
  println("area of the circle is " + areaOfCircle + " pixel squared");
  float valuePerP = areaOfCircle/points.size();
  int numIn = 0;
  for(rp p:points){
    if(p.in){
      numIn++;
    }
  }
  println("area of drawn shape is " + valuePerP*numIn + " pixel squared");
}