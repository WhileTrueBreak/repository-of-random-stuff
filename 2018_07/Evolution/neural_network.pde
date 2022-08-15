class network{
  matrix m = new matrix();
  
  float[][] inNode;
  float[][] hiddenNode;
  float[][] outNode;
  float[][] hiddenNodeBias;
  float[][] outNodeBias;
  
  float[][] weight_ih;
  float[][] weight_ho;
  network(int i,int h,int o){
    inNode = new float[1][i];
    hiddenNode = new float[1][h];
    outNode = new float[1][o];
    
    hiddenNodeBias = m.Random(1,h,-1,1);
    outNodeBias = m.Random(1,o,-1,1);
    
    weight_ih = m.Random(i,h,-1,1);
    weight_ho = m.Random(h,o,-1,1);
  }
  float[][] feedforward(float[][] input){
    inNode = input;
    hiddenNode = m.Mult(weight_ih,inNode);
    hiddenNode = m.entSum(hiddenNode,hiddenNodeBias);
    outNode = m.Mult(weight_ho,hiddenNode);
    outNode = m.entSum(outNode,outNodeBias);
    return outNode;
  }
  void display(float x, float y,float scl){
    textMode(CENTER);
    for(int i = 0;i < inNode.length;i++){
      for(int j = 0;j < hiddenNode.length;j++){
        stroke(map(weight_ih[j][i],1,-1,0,255),map(weight_ih[j][i],-1,1,0,255),0);
        strokeWeight(abs(weight_ih[j][i])*scl);
        line(x*scl,y*scl+i*20*scl,x*scl+60*scl,y*scl+j*20*scl);
      }
    }
    for(int i = 0;i < hiddenNode.length;i++){
      for(int j = 0;j < outNode.length;j++){
        stroke(map(weight_ho[j][i],1,-1,0,255),map(weight_ho[j][i],-1,1,0,255),0);
        strokeWeight(map(abs(weight_ho[j][i]),0,2,0,4)*scl);
        line(x*scl+60*scl,y*scl+i*20*scl,x*scl+120*scl,y*scl+j*20*scl);
      }
    }
    for(int i = 0;i < hiddenNode.length;i++){
      stroke(map(hiddenNodeBias[i][0],1,-1,0,255),map(hiddenNodeBias[i][0],-1,1,0,255),0);
      strokeWeight(map(abs(hiddenNodeBias[i][0]),0,2,0,4)*scl);
      line(x*scl+60*scl,y*scl+i*20*scl,x*scl,y*scl+inNode.length*20*scl);
    }
    noStroke();
    fill(0,255,0);
    ellipse(x*scl,y*scl+inNode.length*20*scl,10*scl,10*scl);
    ellipse(x*scl+60*scl,y*scl+hiddenNode.length*20*scl,10*scl,10*scl);
    textSize(10*scl);
    text(1,x*scl,y+inNode.length*20*scl);
    text(1,x*scl+60*scl,y*scl+hiddenNode.length*20*scl);
    for(int i = 0;i < outNode.length;i++){
      stroke(map(outNodeBias[i][0],1,-1,0,255),map(outNodeBias[i][0],-1,1,0,255),0);
      strokeWeight(map(abs(outNodeBias[i][0]),0,2,0,4)*scl);
      line(x*scl+120*scl,y*scl+i*20*scl,x*scl+60*scl,y*scl+hiddenNode.length*20*scl);
    }
    for(int i = 0;i < inNode.length;i++){
      noStroke();
      fill(map(inNode[i][0],1,-1,0,255),map(inNode[i][0],-1,1,0,255),0);
      ellipse(x*scl,y*scl+i*20*scl,10*scl,10*scl);
      textSize(10*scl);
      text(inNode[i][0],x*scl,y*scl+i*20*scl);
    }
    for(int i = 0;i < hiddenNode.length;i++){
      noStroke();
      fill(map(hiddenNode[i][0],1,-1,0,255),map(hiddenNode[i][0],-1,1,0,255),0);
      ellipse(x*scl+60*scl,y*scl+i*20*scl,10*scl,10*scl);
      textSize(10*scl);
      text(hiddenNode[i][0],x*scl+60*scl,y*scl+i*20*scl);
    }
    for(int i = 0;i < outNode.length;i++){
      noStroke();
      fill(map(outNode[i][0],1,-1,0,255),map(outNode[i][0],-1,1,0,255),0);
      ellipse(x*scl+120*scl,y*scl+i*20*scl,10*scl,10*scl);
      textSize(10*scl);
      text(outNode[i][0],x*scl+120*scl,y*scl+i*20*scl);
    }
  }
}