class button{
  
  onClick oc;
  float x, y, w, h;
  
  button(float x, float y, float w, float h, onClick oc){
    this.oc = oc;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  boolean checkHover(){
    return mouseX<x+w&&mouseX>x&&mouseY>y&&mouseY<y+h;
  }
  
  void display(){
    rect(x,y,w,h);
  }
  
  void onHover(){
    if(checkHover()){
      oc.onHover();
    }
  }
  
  void onPressed(){
    if(leftPressed&&checkHover()){
      oc.onPressed();
    }
  }
  
  void onClick(){
    if(leftClick&&checkHover()){
      oc.onClick();
    }
  }
  
}