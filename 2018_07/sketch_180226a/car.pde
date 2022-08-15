class car{
  float pos;
  float vel;
  float acc;
  car(float p){
    pos = p;
  }
  void update(){
    vel += acc;
    pos += vel;
    acc = 0;
  }
  void display(){
    noFill();
    stroke(0);
    rect(width/2,pos,50,20);
  }
}