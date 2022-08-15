class cube{
  float a = 255;
  float r = 255;
  float g = 255;
  float b = 255;
  color c = color(r,g,b,a);
  
  PVector pos;
  PVector dimension;
  cube(PVector pos_,PVector d){
    pos = pos_;
    dimension = d;
  }
  void display(PVector rotate,PVector pr,boolean stroke){
    pushMatrix();
    translate(pr.x,pr.y,pr.z);
    rotateX(rotate.x);
    rotateY(rotate.y);
    rotateZ(rotate.z);
    translate(pos.x-pr.x,pos.y-pr.y,pos.z-pr.z);
    if(stroke){
      stroke(255);
    }else{
      noStroke();
    }
    fill(c);
    box(dimension.x,dimension.y,dimension.z);
    popMatrix();
  }
  boolean collide(PVector p1,PVector d1,PVector p2,PVector d2){
    if(p2.x<p1.x+d1.x&&p2.x+d2.x>p1.x&&p2.y<p1.y+d1.y&&p2.y+d2.y>p1.y&&p2.z<p1.z+d1.z&&p2.z+d2.z>p1.z){
      return true;
    }
    return false;
  }
}