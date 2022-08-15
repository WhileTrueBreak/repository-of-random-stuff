class node{
  ArrayList<node> connectedNodes = new ArrayList();
  float currentNodeValue = 0;
  int layer;
  node(int l){
    layer = l;
    for(node n:n.nodes){
      if(n.layer < layer){
        connectedNodes.add(n);
      }
    }
  }
  void intConnections(){
    for(node n:n.nodes){
      if(n.layer < layer){
        connectedNodes.add(n);
      }
    }
  }
  void PlaceValue(float in){
    currentNodeValue = in;
  }
  void getInputs(){
    for(node n:connectedNodes){
      currentNodeValue += n.getOutput();
    }
  }  
  float getOutput(){
    float total = 0;
    total += currentNodeValue;
    return atan(total);
  }
}