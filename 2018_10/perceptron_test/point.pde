float f(float x){
  return 0.5*x+200;
}

class point{
  float px,py,bias;
  float sign = 1;
  point(float px, float py){
    this.px = px;
    this.py = py;
    bias = 1;
    if(f(px) < py){
      sign = -1; 
    }
  }
  
  void show(){
    if(sign == -1){
      fill(255,0,0);
    }else{
      fill(0,255,0);
    }
    ellipse(px,py,10,10);
  }
  
}