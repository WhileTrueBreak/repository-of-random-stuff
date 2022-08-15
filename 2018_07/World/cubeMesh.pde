class cube{
  float a = 255;
  float r = 5;
  float g = 255;
  float b = 255;
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
    stroke(0);
    fill(c);
    box(dimension.x,dimension.y,dimension.z);
    popMatrix();
  }
}