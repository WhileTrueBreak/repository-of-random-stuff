class layer{
  
  node[] nodes;
  float[] prevInputs;
  
  layer(int numNodes, int inputs){
    nodes = new node[numNodes];
    for(int i = 0;i < nodes.length;i++){
      nodes[i] = new node(inputs+1);
    }
  }
  
  float[] guess(float [] inputs){
    float[] guesses = new float[nodes.length];
    prevInputs = inputs;
    for(int i = 0;i < nodes.length;i++){
      guesses[i] = nodes[i].guess(inputs);
    }
    return guesses;
  }
  
  void correct(float[] error){
    for(int i = 0;i < nodes.length;i++){
      nodes[i].correct(error[i]);
    }
  }
  
  float[] prefNextLayer(float[] error){//fix
    //println(nodes.length);
    float[] nextLayerError = new float[nodes[0].weights.length];
    for(int i = 0;i < nodes.length;i++){
      for(int j = 0;j < nextLayerError.length;j++){
        nextLayerError[j] += nodes[i].nextLayerChange(error[i])[j];
      }
      //println(error[i]);
      //println(nodes[i].weights);
      //println(nodes[i].nextLayerChange(error[i]));
    }
    //println(nextLayerError);
    for(int i = 0;i < nextLayerError.length;i++){
      nextLayerError[i] /= nodes.length;
    }
    return nextLayerError;
  }
  
  void display(float x, float y){
    for(int i = 0;i < nodes.length;i++){
      nodes[i].display(x,float(i)*20+y,y);
    }
  }
}