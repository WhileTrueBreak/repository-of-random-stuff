int inputsNum = 2;
int[] layout = {2,1};
float lr = 0.001;

layer[] layers;

float[][] inputSet = {
  {0,0},
  {0,1},
  {1,0},
  {1,1},
};

float [][] answerSet = {
  {1},
  {1},
  {1},
  {0},
};

public void setup(){
  size(400,400);
  //neural network setup
  layers = new layer[layout.length];
  for(int i = 0;i < layout.length;i++){
    layers[i] = new layer(layout, i, inputsNum);
  }
}

public void draw(){
  //testing neural network
  float[] totalError = new float[answerSet[0].length];
  int t = 0;
  for(int num = 0;num < 10;num++){
    //feedward
    int index = floor(random(4));
    float[] input = inputSet[index];
    layers[0].setInput(input);
    for(int i = 0;i < layers.length;i++){
      layers[i].feedForward();
    }
    //calculating error
    float[] error = new float[answerSet[index].length];
    for(int i = 0;i < answerSet[index].length;i++){
      error[i] = answerSet[index][i]-layers[layers.length-1].getOutput()[i];
    }
    //displaying result
    /*for(int i = 0;i < answerSet[index].length;i++){
      println("output: " + layers[layers.length-1].getOutput()[i]);
      println("expected: " + answerSet[index][i]);
      println("error: " + error[i]);
    }*/
    for(int i = 0;i < error.length;i++){
      totalError[i] += error[i];
    }
    t++;
  }
  for(int i = 0;i < totalError.length;i++){
    totalError[i] /= t;
  }
  println(totalError);
  //sending error
  layers[layers.length-1].setError(totalError, lr);
  for(int i = layers.length-1;i >= 0;i--){
    layers[i].backPropagate();
  }
  //displaying as grid
  for(int i = 0;i < width;i+=10){
    for(int j = 0;j < height;j+=10){
      float[] inputT = {PApplet.parseFloat(i)/width, PApplet.parseFloat(j)/height};
      layers[0].setInput(inputT);
      for(int k = 0;k < layers.length;k++){
        layers[k].feedForward();
      }
      noStroke();
      fill(map(layers[layers.length-1].getOutput()[0],-1,1,0,255));
      rect(i, j, 10, 10);
      fill(255,0,0);
      text(round(layers[layers.length-1].getOutput()[0]),i,j+10);
    }
  }
  float cost = 0;
  for(int i = 0;i < totalError.length;i++){
    cost += pow(totalError[i],2);
  }
  //cost /= totalError.length;
  println(cost);
  lr = cost/10;
  if(lr >= 1){
    lr = 0.9;
  }
  for(int i = 0;i < layers.length;i++){
    layers[i].display();
  }
}