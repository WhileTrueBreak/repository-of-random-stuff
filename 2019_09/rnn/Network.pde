public class NeuralNetwork {

  private ArrayList<Layer>layers = new ArrayList<Layer>();
  private Layer[] recurrentLayers;

  public NeuralNetwork(int[] struct){
    recurrentLayers = new Layer[struct.length-2];
    for(int i = 1;i < struct.length;i++){
      if(i >= struct.length-1){
        layers.add(new Layer(struct[i-1], struct[i]));
        continue;
      }
      layers.add(new Layer(struct[i-1]+struct[i], struct[i]));
      recurrentLayers[i-1] = layers.get(layers.size()-1);
    }
    for(Layer layer:recurrentLayers){
      println(layer.getNodes().toArray());
    }
  }
  
  
  
  public Layer[] getRecurrentLayers(){
    return recurrentLayers;
  }
  
}
