public final int WORLD_DIM_X = 1000;
public final int WORLD_DIM_Y = 1000;

public final float SEA_LEVEL = 30;
public final float MAX_HEIGHT = 100;
public final float HEIGHT_DROPOFF_RATE = 10;

public final float MIN_TEMP = -40;
public final float MAX_TEMP = 40;
public final float MAX_TEMP_DROPOFF = 15;

public final long SEED = 0;

public float[][] heightMap = new float[WORLD_DIM_X][WORLD_DIM_Y];
public float[][] temperatureMap = new float[WORLD_DIM_X][WORLD_DIM_Y];

void setup(){
  noiseSeed(SEED);
  size(1000, 1000);
  println("Creating Height Map...");
  initHeightMap();
  println("Creating Temperature Map...");
  initTemperatureMap();
  println("Done.");
}

void draw(){
  background(0);
  noStroke();
  for(int x = 0;x < WORLD_DIM_X;x++){
    for(int y = 0;y < WORLD_DIM_Y;y++){
      fill(map(heightMap[x][y], 0, 100, 0, 255));
      rect(x*width/WORLD_DIM_X, y*height/WORLD_DIM_Y, width/WORLD_DIM_X, height/WORLD_DIM_Y);
      if(heightMap[x][y] <= SEA_LEVEL) fill(0, 255, 255, 50);
      rect(x*width/WORLD_DIM_X, y*height/WORLD_DIM_Y, width/WORLD_DIM_X, height/WORLD_DIM_Y);
      colorMode(HSB, 255, 100, 100, 255);
      //fill(map(temperatureMap[x][y], MIN_TEMP, MAX_TEMP, 239, 0), 100, 50, 150);
      //rect(x*width/WORLD_DIM_X, y*height/WORLD_DIM_Y, width/WORLD_DIM_X, height/WORLD_DIM_Y);
      colorMode(RGB, 255, 255, 255, 255);
    }
  }
}

void initTemperatureMap(){
  float xoff = 0.005f, yoff = 0.005f;
  for(int x = 0;x < temperatureMap.length;x++){
    for(int y = 0;y < temperatureMap[x].length;y++){
      float base_value = noise(x*xoff, y*yoff)*(MAX_TEMP-MIN_TEMP)+MIN_TEMP;
      temperatureMap[x][y] = base_value;
      if(heightMap[x][y]-SEA_LEVEL > 0) temperatureMap[x][y] -= map(heightMap[x][y]-SEA_LEVEL, 0, MAX_HEIGHT-SEA_LEVEL, 0, MAX_TEMP_DROPOFF);
      
    }
  }
}

void initHeightMap(){
  float xoff = 0.01f, yoff = 0.01f;
  //produce main land shape
  for(int x = 0;x < heightMap.length;x++){
    for(int y = 0;y < heightMap[x].length;y++){
      float base_value = noise(x*xoff, y*yoff)*MAX_HEIGHT;
      heightMap[x][y] = (float) -Math.abs(MAX_HEIGHT/(1+Math.pow(Math.E, HEIGHT_DROPOFF_RATE*map(base_value, 0, 100, -50, 50)/MAX_HEIGHT)))+MAX_HEIGHT;
    }
  }
}
