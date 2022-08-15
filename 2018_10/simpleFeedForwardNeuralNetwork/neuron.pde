class neuron{
  
  float neuronError = 0;
  
  float currentValue = 0;
  float[] weights;
  float bias;
  
  float[] lastInput;
  
  neuron(int numAxons){
    weights = new float[numAxons];
    lastInput = new float[numAxons];
    for(int i = 0;i < weights.length;i++){
      weights[i] = random(-1,1);
    }
    bias = random(-1,1);
  }
  
  public void giveInputs(float[] inputs){
    lastInput = inputs;
    //inputsNum must be equal to weightsNum
    float total = 0;
    for(int i = 0;i < inputs.length;i++){
      total += inputs[i]*weights[i];
    }
    currentValue = map(total+bias,-2,2,-1,1);
  }
  
  public void setCurrentValue(float input){
    currentValue = input;
  }
  
  public float[] getInput(){
    return weights;
  }
  
  public float getCurrentValue(){
    return currentValue;
  }
  
  public void setError(float error){
    neuronError = error;
  }
  
  public void changeWeights(){
    float[] lastInputPer = new float[lastInput.length+1];
    float totalInput = 0;
    for(int i = 0;i < lastInput.length;i++){
      totalInput += lastInput[i];
    }
    totalInput += 1;
    for(int i = 0;i < lastInputPer.length-1;i++){
      if(totalInput!=0){
        lastInputPer[i] = lastInput[i]/totalInput;
      }
    }
    if(totalInput!=0){
      lastInputPer[lastInput.length] = 1/totalInput;
    }
    for(int i = 0;i < lastInputPer.length-1;i++){
      weights[i] += lastInputPer[i]*neuronError;
    }
    bias += lastInputPer[lastInput.length]*neuronError;
  }
  
  public float[] getNextErrors(){
    float[] nextError = new float[weights.length];
    for(int i = 0;i < weights.length;i++){
      nextError[i] = neuronError*weights[i];
    }
    return nextError;
  }
  
  public float getError(){
    return neuronError;
  }
  
}