class ComplexNumber {
  
  float re,im;
  
  public ComplexNumber(float r, float i){
    this.re = r;
    this.im = i;
  }
  
  public void addNum(float r, float i){
    this.re += r;
    this.im += i;
  }
  
  public void subNum(float r, float i){
    this.re -= r;
    this.im -= i;
  }
  
  public void multiNum(float r, float i){
    this.re = this.re*r-this.im*i;
    this.im = this.re*i-this.im*r;
  }
  
  public String toString(){
    return str(re)+"+"+str(im)+"i";
  }
  
  public void setIm(float i){
    this.im = i;
  }
  
  public void setRe(float r){
    this.re = r;
  }
  
  public float getIm(){
    return im;
  }
  
  public float getRe(){
    return re;
  }
  
}
