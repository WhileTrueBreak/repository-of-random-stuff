point[] points = new point[600];

perceptron p;

void setup(){
  size(400,400);
  for(int i = 0;i < points.length;i++){
    points[i] = new point(random(width),random(height));
  }
  p = new perceptron(3);
}

void draw(){
  background(200);
  line(0,f(0), width, f(width));
  for(point pt:points){
    pt.show();
  }
  for(point pt:points){
    float[] input = {pt.px,pt.py,1};
    //p.train(input,pt.sign);
    float guess = p.guess(input);
    if(guess == pt.sign){
      fill(0,255,0);
    }else{
      fill(255,0,0);
    }
    ellipse(pt.px,pt.py,10,10);
  }
  line(0,p.guessY(0),width, p.guessY(width));
   for(point pt:points){
    float[] input = {pt.px,pt.py,1};
    p.train(input,pt.sign);
  }
}