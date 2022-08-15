
PVector p1 = new PVector(50, 100);
PVector p2 = new PVector(400, 50);

void setup(){
  size(600, 600);
}

void draw(){
  background(0);
  PVector c = circleFromPoints(mouseX, mouseY, p1.x, p1.y, p2.x, p2.y);
  noStroke();
  fill(255);
  ellipse(p1.x, p1.y, 5, 5);
  ellipse(p2.x, p2.y, 5, 5);
  noFill();
  stroke(255);
  println(c.x+","+c.y+","+c.z);
  ellipse(c.x, c.y, c.z*2, c.z*2);
}

public PVector circleFromPoints(float x1, float y1, float x2, float y2, float x3, float y3){
  float H1 = x1*x1+y1*y1;
  float H2 = x2*x2+y2*y2;
  float H3 = x3*x3+y3*y3;
  
  float A = x1*(y2-y3)-y1*(x2-x3)+x2*y3-x3*y2;
  float B = H1*(y3-y2)+H2*(y1-y3)+H3*(y2-y1);
  float C = H1*(x2-x3)+H2*(x3-x1)+H3*(x1-x2);
  //float D = H1*(x3*y2-x2*y3)+H2*(x1*y3-x3*y1)+H3*(x2*y1-x1*y2);
  
  float x = -B/(2*A);
  float y = -C/(2*A);
  float r = (float) Math.sqrt((x-x1)*(x-x1)+(y-y1)*(y-y1));
  
  return new PVector(x, y, r);
}
