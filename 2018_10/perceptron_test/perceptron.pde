int sign(float input){
  if(input > 0){
    return 1;
  }if(input < 0){
    return -1;
  }
  return 0;
}

class perceptron{
  
  float lr = 0.1;
  float[] weights;
  
  perceptron(int n){
    weights = new float[n];
    for(int i = 0;i < weights.length;i++){
      weights[i] = random(-1,1);
    }
  }
  
  float guess(float[] input){
    float total = 0;
    for(int i = 0;i < input.length;i++){
      total += input[i]*weights[i];
    }
    return sign(total);
  }
  
  void train(float[] input, float target){
    float guess = guess(input);
    float error = target-guess;
    for(int i = 0;i < input.length;i++){
      weights[i] +=   error * input[i] * lr;
    }
  }
  
  float guessY(float x){
    return -weights[2]/weights[1] - weights[0]/weights[1]*x;
  }
}