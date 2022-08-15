button b = new button(100,100,200,200,new onClick(){
  void onClick(){
    fill(255,0,0);
  }void onPressed(){
    fill(0,0,255);
  }void onHover(){
    fill(0,255,255);
  }});

void setup(){
  size(400,400);
}

void draw(){
  background(255);
  fill(0);
  b.onHover();
  b.onPressed();
  println(leftPressed);
  b.onClick();
  b.display();
  resetMouseVar();
}