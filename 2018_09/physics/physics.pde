float deltaT = 0.5;
float gConst = 6.674*pow(10,1);

ArrayList<body>bodies = new ArrayList();

void setup(){
  fullScreen();
  //for(int i = 0;i < 2;i++){
  //  bodies.add(new body(new PVector(random(width),random(height)),1000,random(0.01,0.05)));
  //}
  bodies.add(new body(new PVector(100,400),1000,0.003));
  bodies.add(new body(new PVector(500,400),1000,0.003));
}

void draw(){
  background(0);
  for(body b:bodies){
    ArrayList<body>temp = new ArrayList();
    for(body b1:bodies){
      if(b != b1){
        temp.add(b1);
      }
    }
    b.applyGrav(temp);
    b.collision_rebound(temp);
  }
  for(body b:bodies){
    b.update();
    b.display();
  }
}