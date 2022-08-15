/*
the graph displays the error of the ai
the higher the bar the bigger the error is
the ai will train itself until the error is 0

currently the ai can only solve linearly seperatable problem
*/
//misc
float averageError = 0;
float[] pastErrors = new float[100];
//graphing
graph g1 = new graph(0, 0, 400, 400, 0.5, 1);
//network var
int[] layers = {2,1};
int inputs = 2;

float lr = 0.001;//change this to change how fast it learns(learning rate) the larger the number the easier it overshoots. if small it takes a long time.

network n;
//training data
float[][] input = {
  {0,0},
  {1,0},
  {0,1},
  {1,1},
  
};

float[][] answer = {
  {0},
  {1},
  {1},
  {0},
  
};

void setup(){
  size(400,400);
  n = new network(layers, inputs);
}

void draw(){
  background(0);
  //neural network
  int index = floor(random(input.length));
  for(int i = 0;i < 100;i++){
    n.train(input[index], answer[index],1000);
  }
  //misc
  println(input[index]);
  println(n.guess(input[index]));
  float roundE = abs(n.getError(input[index], answer[index]));
  for(int i = pastErrors.length-2;i >= 0;i--){
    pastErrors[i+1] = pastErrors[i];
  }
  pastErrors[0] = roundE;
  for(int i = 0;i < pastErrors.length;i++){
    averageError += abs(pastErrors[i]);
  }
  averageError /= pastErrors.length;
  //graphics
  g1.addNew(averageError);
  g1.display();
  n.display(60,30);
  //reset
  averageError = 0;
}