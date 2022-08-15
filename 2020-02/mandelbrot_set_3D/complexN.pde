class Complex{
  float real;
  float img;
  Complex(float real, float img){
    this.real = real;
    this.img = img;
  }
  Complex mult(Complex cn){
    float real = this.real*cn.real-this.img*cn.img;
    float img = this.real*cn.img+cn.real*this.img;
    return new Complex(real, img);
  }
  String toString(){
    return str(this.real)+"+"+str(this.img)+"i";
  }
}
