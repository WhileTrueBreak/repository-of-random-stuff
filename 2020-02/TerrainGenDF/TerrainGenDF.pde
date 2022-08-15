Map map;

void setup(){
  
  size(600, 600);
  
  map = new Map(600, 600);
  //map.createHeightMap((int)random((int)Double.POSITIVE_INFINITY));
  //while(map.getLandPercentage()<0.2){
  //  println("Land percentage: ", map.getLandPercentage()*100,"%");
  //  println("Shore to land percentage: ", map.getShorePercentage()*100,"%");
  //  println("Shore Complexity: ",map.getShoreComplexity());
  //  println("Regenerating...");
  //  map.createHeightMap((int)random((int)Double.POSITIVE_INFINITY));
  //}
  //map.createHumidityMap((int)random((int)Double.POSITIVE_INFINITY));
  
  map.createHeightMap(2033602432);
  map.createHumidityMap(1084556160);
  map.createDrainageMap(0);
  map.createRivers();
  
  map.render();
}
 
void draw(){
  
}
