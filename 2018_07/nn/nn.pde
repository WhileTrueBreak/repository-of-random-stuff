float c = 0.00001;
float scl = 25;

ArrayList<network> networks = new ArrayList();
float[][][] in1 = {
{{0},{0}},
{{1},{0}},
{{0},{1}},
{{1},{1}},
};
float[][][] answer = {
{{0}},
{{1}},
{{1}},
{{0}},
};
float[][] out1;
void setup(){
  frameRate(100);
  size(500,500);
  for(int i = 0;i < 1;i++){
    networks.add(new network(16,1000,4));
  }
}
void draw(){
  background(200);
  int index = floor(random(in1.length));
  for(int i = 0;i < networks.size();i++){
    network nn = networks.get(i);
    for(int j  = 0;j < 2;j++){
      index = floor(random(4));
      nn.train(in1[index],answer[index]);
    }
    noStroke();
    for(int x = 0;x < scl;x++){
      for(int y = 0;y < scl;y++){
        float[][]test = {{map(x,0,scl,0,1)},{map(y,0,scl,0,1)}};
        fill(map(nn.feedforward(test)[0][0],0,1,255,0),map(nn.feedforward(test)[0][0],0,1,0,255),0);
        rect(x*width/scl,y*width/scl,width/scl,width/scl);
      }
    }
    println(nn.feedforward(in1[index])[0][0]);
  }
}