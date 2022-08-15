class node{
  
  float[] prevInputs;
  float[] weights;
  
  float lastOut = 0;
  
  node(int inputs){
    weights = new float[inputs];
    prevInputs = new float[inputs];
    for(int i = 0;i < weights.length;i++){
      weights[i] = random(-1,1);
    }
  }
  
  float guess(float[] inputs){
    prevInputs = inputs;
    float total = 0;
    for(int i = 0;i < inputs.length;i++){
      total += inputs[i]*weights[i];
    }
    lastOut = sigmoid(total);
    return sigmoid(total);//activation function
  }
  
  void correct(float error){
    for(int i = 0;i < weights.length;i++){
      weights[i] += error * prevInputs[i] * lr;
    }
  }
  
  float[] nextLayerChange(float error){//fix
    if(error > 1.1){
      error = 1.1;
    }if(error < -1.1){
      error = -1.1;
    }
    float[] change = new float[weights.length];
    for(int i = 0;i < weights.length-1;i++){
      change[i] = error * weights[i];
    }
    return change;
  }
  
  void display(float x, float y, float yN){
    float min = -2;
    float max = 2;
    for(int i = 0;i < weights.length-1;i++){
      if(weights[i]>0){
        stroke(0,255,0);
      }else{
        stroke(255,0,0);
      }
      float absW = abs(weights[i]);
      strokeWeight(constrain(absW,0,500));
      line(x,y,x-30,yN+i*20);
    }
    //fill(map(weights[weights.length-1],min,max,255,0),map(weights[weights.length-1],min,max,0,255),0);
    fill(map(lastOut,min,max,255,0),map(lastOut,min,max,0,255),0);
    noStroke();
    ellipse(x,y,10,10);
  }
  
}

float sigmoid(float n){
  return 2*((1/(1 + exp(-1 * n)))-0.5);
}
float sign(float n){
  if(n < 0){
    return -1;
  }if(n > 0){
    return 1;
  }
  return 0;
}