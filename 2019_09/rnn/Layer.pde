public class Layer {
  
  private int nodeNum;

  private Matrix nodes, weights, bias;
  private Matrix tmpWeights, tmpBias;

  public Layer(int in, int out){
    this.nodeNum = out;
    
    nodes = new Matrix(in, 1);
    weights = new Matrix(out, in);
    bias = new Matrix(out, 1);
    
    nodes.randomiseMatrix(0, 0);
    weights.randomiseMatrix(-1, 1);
    tmpWeights = weights.cloneMatrix();
    bias.randomiseMatrix(-1, 1);
    tmpBias = bias.cloneMatrix();
  }

  public Matrix feedForward(Matrix in){
    //calc node
    nodes = Matrix.matrixProduct(weights, in);
    nodes.applyFunc(new Activation() {public double function(double n) {return (float)(1/( 1 + Math.pow(Math.E,(-1*n))))*2-1;}});
    return nodes;
  }
  
  public void resetTmp(){
    tmpWeights.randomiseMatrix(0, 0);
    tmpBias.randomiseMatrix(0, 0);
  }

  public Matrix train(Matrix prevNode, Matrix error, double learningRate){
    //get next error
    Matrix weights_t = Matrix.transpose(weights);
    Matrix next_err = Matrix.matrixProduct(weights_t, error);
    //calc gradient
    nodes.applyFunc(new Activation() {public double function(double n) {return ((n+1)/2)*(1-((n+1)/2));}});
    nodes = Matrix.hadamardProduct(nodes, error);
    nodes = Matrix.scalarProduct(nodes, learningRate);
    //update bias
    tmpBias = Matrix.add(tmpBias, Matrix.add(bias, nodes));
    //get deltas
    Matrix prev_node_t = Matrix.transpose(prevNode.cloneMatrix());
    Matrix weights_delta = Matrix.matrixProduct(nodes, prev_node_t);
    //update weights
    tmpWeights = Matrix.add(tmpWeights, Matrix.add(weights, weights_delta));

    return next_err;
  }
  
  public void updateTrueValues(int n){
    bias = Matrix.scalarProduct(tmpBias, 1/n);
    weights = Matrix.scalarProduct(tmpWeights, 1/n);
  }

  public int getNodeNum() {
    return nodeNum;
  }

  public Matrix getNodes() {
    return nodes;
  }
  
}
