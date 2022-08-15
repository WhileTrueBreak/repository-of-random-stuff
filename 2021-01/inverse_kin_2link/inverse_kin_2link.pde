float xo = 0, yo = 200;
float t1 = 0, t2 = 0;
float l1 = 200, l2 = 200;

void setup() {
  size(600, 600);
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(4);
  line(xo, yo, xo+l1*cos(t1), yo+l1*sin(t1));
  line(xo+l1*cos(t1), yo+l1*sin(t1), xo+l1*cos(t1)+l2*cos(t1+t2), yo+l1*sin(t1)+l2*sin(t1+t2));
  
  float x = mouseX-xo, y = mouseY-yo;
  
  t2 = acos((x*x+y*y-l1*l1-l2*l2)/(2*l1*l2));
  t1 = atan2(y,x)-atan2(l2*sin(t2),l1+l2*cos(t2));
}