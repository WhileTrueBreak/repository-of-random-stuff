class network{
  ArrayList<node>nodes = new ArrayList();
  network(int In,int Out,int MaxL){
    for(int i = 0;i < In;i++){
      nodes.add(new node(0));
      
    }
    for(int i = 0;i < Out;i++){
      nodes.add(new node(MaxL));
      
    }
  }
  void debug(){
    for(node n:nodes){
      print(n.connectedNodes.size()+"/");
      print("\n");
    }
  }
}