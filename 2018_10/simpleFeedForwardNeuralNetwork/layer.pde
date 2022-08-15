class layer{
  
  neuron[] neurons;
  
  int[] neuronLayout;
  int layerNum;
  
  layer(int[] neuronLayout, int layerNum, int numInput){
    neurons = new neuron[neuronLayout[layerNum]];
    this.neuronLayout = neuronLayout;
    this.layerNum = layerNum;
    for(int i = 0;i < neurons.length;i++){
      if(layerNum == 0){
        neurons[i] = new neuron(numInput);
      }else{
        neurons[i] = new neuron(neuronLayout[layerNum-1]);
      }
    }
  }
  
  public void feedForward(){
    if(layerNum != 0){
      float[] inputValues;
      inputValues = new float[layers[layerNum-1].neurons.length];
      for(int i = 0;i < inputValues.length;i++){
        inputValues[i] = layers[layerNum-1].neurons[i].getCurrentValue();
      }
      for(int i = 0;i < neurons.length;i++){
        neurons[i].giveInputs(inputValues);
      }
    }
  }
  
  public void backPropagate(){
    if(layerNum != neuronLayout.length-1){
      float[] totalError = new float[neurons.length];
      for(int i = 0;i < layers[layerNum+1].neurons.length ;i++){
        for(int j = 0;j < totalError.length ;j++){
          totalError[j] += layers[layerNum+1].neurons[i].getNextErrors()[j];
        }
      }
      for(int i = 0;i < neurons.length;i++){
        neurons[i].setError(totalError[i]);
        neurons[i].changeWeights();
      }
    }else{
      float[] totalError = new float[neurons.length];
      for(int i = 0;i < neurons.length;i++){
        totalError[i] = neurons[i].getError();
      }
      
      for(int i = 0;i < neurons.length;i++){
        neurons[i].setError(totalError[i]);
        neurons[i].changeWeights();
      }
    }
  }
  
  public void setInput(float[] inputs){//only for first
    for(int i = 0;i < neurons.length;i++){
      neurons[i].giveInputs(inputs);
    }
  }
  
  public float[] getOutput(){
    float[] outputValues = new float[neurons.length];
    for(int i = 0;i < outputValues.length;i++){
      outputValues[i] = neurons[i].getCurrentValue();
    }
    return outputValues;
  }
  
  public void setError(float[] error, float lr){
    for(int i = 0;i < neurons.length;i++){
      neurons[i].setError(error[i]*lr);
    }
  }
  
  public void display(){
    for(int i = 0;i < neurons.length;i++){
      noStroke();
      fill(map(neurons[i].bias,-1,1,255,0),map(neurons[i].bias,-1,1,0,255),0);
      ellipse(layerNum*30+40, i*20+40, 10 ,10);
      for(int j = 0;j < neurons[i].weights.length;j++){
        strokeWeight(2);
        stroke(map(neurons[i].weights[j],-1,1,255,0),map(neurons[i].weights[j],-1,1,0,255),0);
        line(layerNum*30+40, i*20+40, (layerNum-1)*30+40, j*20+40);
      }
    }
  }
  
}