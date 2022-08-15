class Network{
  
  float learning_rate = 0.1;
  
  int input_n;
  int output_n;
  int hidden_n;
  
  Matrix input_nodes;
  Matrix hidden_nodes;
  Matrix output_nodes;
  
  Matrix weights_ih;
  Matrix weights_ho;
  
  Matrix bias_h;
  Matrix bias_o;
  
  Network(int input, int hidden, int output){
    this.input_n = input;
    this.hidden_n = hidden;
    this.output_n = output;
    
    weights_ih = new Matrix(hidden, input);
    weights_ho = new Matrix(output, hidden);
    
    bias_h = new Matrix(hidden, 1);
    bias_o = new Matrix(output, 1);
    
    weights_ih.randomize(-1, 1);
    weights_ho.randomize(-1, 1);
    
    bias_h.randomize(-1, 1);
    bias_o.randomize(-1, 1);
  }
  
  float[] feedforward(float[] in){
    Matrix input = Matrix.from_array(in);//array to matrix
    input_nodes = input.copy_matrix();
    //calc hidden
    Matrix hidden = Matrix.dot_product(weights_ih, input);
    hidden.add_matrix(bias_h);//adds bias
    hidden.map_sigmoid();//applies actvation function
    hidden_nodes = hidden.copy_matrix();
    
    //calc output
    Matrix output = Matrix.dot_product(weights_ho, hidden);
    output.add_matrix(bias_o);//adds bias
    output.map_sigmoid();//apply activation function
    output_nodes = output.copy_matrix();
    
    return output.to_array();
  }
  
  void train(float[] in, float[] out){
    float[] actual = feedforward(in);
    Matrix output = Matrix.from_array(actual);
    
    //calc error
    Matrix output_err = Matrix.sub_matrix(Matrix.from_array(out), output);
    
    //calc hidden error
    Matrix weights_ho_t = Matrix.transpose(weights_ho);
    Matrix hidden_err = Matrix.dot_product(weights_ho_t, output_err);
    
    //calc lr*error*(output*(1-output))
    //calc gradient
    output_nodes.map_dsigmoid();
    output_nodes.multiply_matrix(output_err);
    output_nodes.multiply_number(learning_rate);
    
    //calc the hidden -> output deltas
    Matrix hidden_t = Matrix.transpose(hidden_nodes);
    Matrix weights_ho_delta = Matrix.dot_product(output_nodes, hidden_t);
    
    //change weights based on deltas
    weights_ho.add_matrix(weights_ho_delta);
    
    //calc lr*hidden_error*(hidden*(1-hidden))
    //calc gradient
    hidden_nodes.map_dsigmoid();
    hidden_nodes.multiply_matrix(hidden_err);
    hidden_nodes.multiply_number(learning_rate);
    
    //calc the input -> hidden deltas
    Matrix input_t = Matrix.transpose(input_nodes);
    Matrix weights_ih_delta = Matrix.dot_product(hidden_nodes, input_t);
    
    //change weight based on deltas
    weights_ih.add_matrix(weights_ih_delta);
  }
  
  Matrix get_weights_ih(){
    return weights_ih;
  }
  
  Matrix get_weights_ho(){
    return weights_ho;
  }
  
  Matrix get_bias_h(){
    return bias_h;
  }
  
  Matrix get_bias_o(){
    return bias_o;
  }
  
}