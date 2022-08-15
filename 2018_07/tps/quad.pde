class quadTemp{
  PVector c1;
  PVector c2;
  PVector c3;
  PVector c4;
  quadTemp(float x1,float y1,float x2,float y2,float x3,float y3,float x4,float y4){
    c1 = new PVector(x1,y1);
    c2 = new PVector(x2,y2);
    c3 = new PVector(x3,y3);
    c4 = new PVector(x4,y4);
  }
  void display(){
    quad(c1.x,c1.y,c2.x,c2.y,c3.x,c3.y,c4.x,c4.y);
  }
}