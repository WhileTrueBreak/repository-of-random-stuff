class wall{
  quadTemp temp;
  float x;
  float y;
  float w;
  float h;
  float a;
  PVector c1;
  PVector c2;
  PVector c3;
  PVector c4;
  wall(float xPos,float yPos,float Width,float Height,float Angle){
    x = xPos;
    y = yPos;
    w = Width;
    h = Height;
    a = Angle;
    c1 = new PVector(x,y);
    c2 = new PVector(h*sin(radians(a))+x,h*cos(radians(a))+y);
    c3 = new PVector(x-w*sin(radians(a-90))+h*sin(radians(a)),y-w*cos(radians(a-90))+h*cos(radians(a)));
    c4 = new PVector(x-w*sin(radians(a-90)),y-w*cos(radians(a-90)));
    temp = new quadTemp(c1.x,c1.y,c2.x,c2.y,c3.x,c3.y,c4.x,c4.y);
  }
  void display(){
    strokeWeight(2);
    stroke(255,0,255);
    fill(0,0);
    temp.display();
  }
}