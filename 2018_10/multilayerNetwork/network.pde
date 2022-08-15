class network{
  
  layer[] layers;
  float[] totalError;
  
  network(int[] layers, int inputs){
    totalError = new float[layers[layers.length-1]];
    this.layers = new layer[layers.length];
    this.layers[0] = new layer(layers[0], inputs);
    for(int i = 1;i < layers.length;i++){
      this.layers[i] = new layer(layers[i], layers[i-1]);
    }
  }
  
  float[] guess(float[] inputs){
    float[] lastLayerGuess;
    lastLayerGuess = layers[0].guess(append(inputs,1));//add bias
    for(int i = 1;i < layers.length;i++){
      lastLayerGuess = layers[i].guess(append(lastLayerGuess,1));//add bias
    }
    return lastLayerGuess;
  }
  
  float getError(float[] inputs, float[] answers){
    float[] act = guess(inputs);
    float[] error = new float[answers.length];
    for(int i = 0;i < error.length;i++){//get error
      error[i] = answers[i] - act[i];
    }
    float totalSquaredError = 0;
    for(int i = 0;i < error.length;i++){
      totalSquaredError += pow(error[i],2);
    }
    return totalSquaredError;
  }
  
  void train(float[] inputs, float[] answers, int num){
    float[] act = guess(inputs);
    float[] error = new float[answers.length];
    for(int i = 0;i < num;i++){
      for(int j = 0;j < error.length;j++){//get error
        error[j] += answers[j] - act[j];
      }
    }
    for(int i = 0;i < error.length;i++){
      error[i] /= num;
    }
    float[] errorN;
    errorN = shorten(layers[layers.length-1].prefNextLayer(error));
    layers[layers.length-1].correct(error);
    for(int i = 2;i < layers.length+1;i++){
      float[] le = errorN;
      errorN = shorten(layers[layers.length-i].prefNextLayer(errorN));
      layers[layers.length-(i)].correct(le);
    }
  }
  
  void display(float x, float y){
    for(int i = 0;i < layers.length;i++){
      layers[i].display(i*30+x,y);
    }
  }
  
}