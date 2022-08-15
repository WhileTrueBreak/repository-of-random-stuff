
Board board;

Network n = new Network(9, 18, 9);

void setup(){
  board = new Board();
  float[] out = n.feedforward(convIntArr(board.getGrid()));
  for(float f:out){
    println(f);
  }
}

void draw(){
  
}

float[] convIntArr(int[] a){
  float[] out = new float[a.length];
  for(int i = 0;i < a.length;i++){
    out[i] = (float)a[i];
  }
  return out;
}
