PVector n = new PVector(1, 1, 0).setMag(1);
PVector v1 = new PVector(2, 1, 0);

void setup(){
  size(600, 600);
  background(0);
  stroke(255);
  line(width/2, height/2, width/2+n.x*50, height/2+n.y*50);
  line(width/2, height/2, width/2-v1.x*50, height/2-v1.y*50);
  PVector v2 = slide(n, v1);
  line(width/2, height/2, width/2+v2.x*50, height/2+v2.y*50);
  println(v2);
}

PVector slide(PVector n, PVector v){
  //dot product of normal and v
  float dot = n.dot(v);
  //return v subtract normal multiplied by the dot product
  return v.sub(n.mult(dot));
}
