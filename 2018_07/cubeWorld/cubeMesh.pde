class cube{
  float a = random(0,255);
  float r = random(0,255);
  float g = random(0,255);
  float b = random(0,255);
  color c = color(r,g,b,a);
  PVector pos;
  PVector dimension;
  cube(PVector pos_,PVector d){
    pos = pos_;
    dimension = d;
  }
  void display(PVector rotate,PVector pr){
    pushMatrix();
    translate(pr.x,pr.y,pr.z);
    rotateX(rotate.x);
    rotateY(rotate.y);
    rotateZ(rotate.z);
    translate(pos.x-pr.x,pos.y-pr.y,pos.z-pr.z);
    fill(255);
    noStroke();
    fill(c);
    box(dimension.x,dimension.y,dimension.z);
    popMatrix();
  }
}