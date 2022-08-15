class creature{
  int gen = 1;
  
  matrix m = new matrix();
  network n;
  
  float angle = 0;
  
  PVector acc = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector pos = new PVector(0,0);
  
  int inputNum = 16;
  float[] dna = {8,random(255),random(255),random(255)};
  
  float[] outputs = new float[round(dna[1])];
  
  float health = 100;
  float hunger = 1000;
  creature(PVector p){
    pos = p.copy();
    n = new network(inputNum,32,3);
  }
  void display(){
    noStroke();
    fill(color(dna[1],dna[2],dna[3]));
    ellipse(pos.x,pos.y,dna[0]*5,dna[0]*5);
    textAlign(CENTER,CENTER);
    fill(0);
    textSize(20);
    text(gen,pos.x,pos.y);
  }
  void update(){
    for(PVector f:food){
      if(dist(pos.x,pos.y,f.x,f.y)<(dna[0]*5+10)/2){
        removeFood.add(f);
        hunger+=100;
      }
    }
    vel.add(acc.copy());
    vel.limit(5);
    pos.add(vel.copy());
    acc.mult(0);
    hunger--;
    if(hunger < 0){
      health--;
    }
    
    float[] inputs = new float[inputNum];
    //inputs[inputNum*2] = outputs[3];
    PVector[] endPoint = new PVector[inputNum];
    for(int  i = 0;i < inputNum;i++){
      boolean reached = false;
      float distance = 0;
      PVector dir = PVector.fromAngle(radians(360/inputNum*i+angle)).copy();
      PVector ray = pos.copy();
      while(reached == false){
        ray.add(dir);
        distance++;
        if(dist(ray.x,ray.y,pos.x,pos.y)>dna[0]*5){
          for(PVector f:food){
            if(dist(ray.x,ray.y,f.x,f.y)<(dna[0]*5+10)/2){
              reached = true;
              endPoint[i] = new PVector(ray.x,ray.y);
            }
          }
          if(ray.x<0||ray.x>width||ray.y<0||ray.y>height){
            reached = true;
            endPoint[i] = new PVector(ray.x,ray.y);
          }
        }
        //println(reached);
      }
      
      inputs[i] = map(distance,0,sqrt(pow(width,2)+pow(height,2)),1,0);
    }
    for(int i = 0;i < endPoint.length;i++){
      if(i<inputNum){
        stroke(0);
        strokeWeight(0.2);
      }else{
        stroke(0,255,0);
        strokeWeight(0.2);
      }
      //line(endPoint[i].x,endPoint[i].y,pos.x,pos.y);
    }
    outputs = m.matrixToArray(n.feedforward(m.arrayToMatrix(inputs)),0);
    
  }
  void move(){
    if(outputs[0]>1){
      angle+=0.5;
    }
    if(outputs[0]<1){
      angle-=0.5;
    }
    acc.add(PVector.fromAngle(angle).mult(outputs[1]));
    acc.add(PVector.fromAngle(angle).mult(-outputs[2]));
    if(pos.x<0){
      pos.x=width;
    }
    if(pos.x>width){
      pos.x=0;
    }
    if(pos.y<0){
      pos.y=height;
    }
    if(pos.y>height){
      pos.y=0;
    }
  }
  boolean checkDead(){
    if(health<0){
      return true;
    }
    return false;
  }
  void mutate(){
    n.weight_ih=m.entSum(n.weight_ih,m.Random(n.weight_ih[0].length,n.weight_ih.length,-0.1,0.1));
    n.weight_ho=m.entSum(n.weight_ho,m.Random(n.weight_ho[0].length,n.weight_ho.length,-0.1,0.1));
    //println(n.hiddenNodeBias.length,n.hiddenNodeBias[0].length);
    //println(n.outNodeBias.length,n.outNodeBias[0].length);
    n.hiddenNodeBias = m.entSum(n.hiddenNodeBias,m.Random(1,n.hiddenNodeBias.length,-1,1));
    n.outNodeBias = m.entSum(n.hiddenNodeBias,m.Random(1,n.outNodeBias.length,-1,1));
    dna[1]+=random(-5,5);
    dna[2]+=random(-5,5);
    dna[3]+=random(-5,5);
  }
}