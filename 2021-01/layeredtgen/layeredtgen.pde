import java.util.*;

boolean Verbose = false;

long worldSeed = new Random().nextLong();

float water_level = 0.1f;

float L1height_Xoff = 0.01f;
float L1height_Yoff = 0.01f;
float L2height_Xoff = 0.0005f;
float L2height_Yoff = 0.0005f;
float temperature_Xoff = 0.001f;
float temperature_Yoff = 0.001f;
float humidity_Xoff = 0.005f;
float humidity_Yoff = 0.005f;

ArrayList<Chunk>chunks = new ArrayList<Chunk>();

Map<String, Long> seedDict = new HashMap<String, Long>();
Map<String, Grid> gridDict = new HashMap<String, Grid>();

PVector camOffset;

void setup(){
  size(600, 600);
  
  //temperary set seed
  worldSeed = -1863241849221373923L;

  println("World Seed: "+worldSeed);
  
  Random seedGen = new Random(worldSeed);
  
  seedDict.put("L1heightSeed",seedGen.nextLong());
  seedDict.put("L2heightSeed",seedGen.nextLong());
  seedDict.put("temperatureSeed",seedGen.nextLong());
  seedDict.put("humiditySeed",seedGen.nextLong());
  
  camOffset = new PVector(width/2, height/2);
  
  long startTime = System.nanoTime();
  int r = 20;
  for(int i = -r;i <= r;i++){
    for(int j = -r;j <= r;j++){
      Grid g = new Grid(i,j);
      g.gen1();
      gridDict.put(xyToString(i,j),g);
    }
  }
  long endTime = System.nanoTime();
  long duration = (endTime - startTime)/1000000;
  println("Gen 1: "+duration+"ms");
  background(0);
  startTime = System.nanoTime();
  for(String key:gridDict.keySet()){
    gridDict.get(key).gen2();
  }
  endTime = System.nanoTime();
  duration = (endTime - startTime)/1000000;
  println("Gen 2: "+duration+"ms");
  startTime = System.nanoTime();
  for(String key:gridDict.keySet()){
    gridDict.get(key).gen3();
  }
  endTime = System.nanoTime();
  duration = (endTime - startTime)/1000000;
  println("Gen 3: "+duration+"ms");
  startTime = System.nanoTime();
  for(String key:gridDict.keySet()){
    gridDict.get(key).gen4();
  }
  endTime = System.nanoTime();
  duration = (endTime - startTime)/1000000;
  println("Gen 4: "+duration+"ms");
  
  
}

void draw(){
  background(0);
  
  //println(floor((mouseX-camOffset.x)/20)+","+floor((mouseY-camOffset.y)/20));
  
  for(String key:gridDict.keySet()){
    gridDict.get(key).render();
  }
}



String xyToString(int x, int y){
  return str(x)+","+str(y);
}
