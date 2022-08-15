static float sigmoid(float n){
  return (float)(1/( 1 + Math.pow(Math.E,(-1*n))));
}
static float dsigmoid(float n){//the real dsigmoid with have n pass through a sigmoid
  return n*(1-n);
}
