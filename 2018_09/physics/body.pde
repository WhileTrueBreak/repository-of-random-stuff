class body{
  float radius;//in pixels
  float volume;//in pixels cubed
  float mass;//in kg
  float density;//in kg per pixels cubed
  PVector acc = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector pos = new PVector(0,0);
  body(PVector p,float m,float d){
    pos = p.copy();
    mass = m;
    density = d;
    volume = mass/density;
    radius = pow(volume/(4/3*PI),(1/3.0));
  }
  PVector[] collideP(PVector Pos1, PVector Pos2, PVector Vel1, PVector Vel2, float Mass1, float Mass2){
    PVector secondBallVec1 = new PVector(Pos2.x-Pos1.x,Pos2.y-Pos1.y).setMag(1);
    PVector firstBallVec1 = new PVector(-secondBallVec1.y,secondBallVec1.x).setMag(1);
    float magSecond1 = Vel1.mag()*cos(PVector.angleBetween(secondBallVec1,Vel1));
    float magFirst1 = Vel1.mag()*cos(PVector.angleBetween(firstBallVec1,Vel1));
    
    PVector secondBallVec2 = new PVector(Pos1.x-Pos2.x,Pos1.y-Pos2.y).setMag(1);
    PVector firstBallVec2 = new PVector(-secondBallVec2.y,secondBallVec2.x).setMag(1);
    float magSecond2 = Vel2.mag()*cos(PVector.angleBetween(secondBallVec2,Vel1));
    float magFirst2 = Vel2.mag()*cos(PVector.angleBetween(firstBallVec2,Vel1));
    
    PVector[] newVs = {firstBallVec2.setMag(magFirst2),secondBallVec1.setMag(magSecond1)};
    return newVs;
  }
  void collision_rebound(ArrayList<body> all){
    for(body b:all){
      if(b.radius+radius >= dist(pos.x+vel.x,pos.y+vel.y,b.pos.x+b.vel.x,b.pos.y+b.vel.y)){
        //PVector[] newV = collideP(pos,b.pos,vel,b.vel,mass,b.mass);
        //println(vel);
        //println(newV[0]);
        //vel = newV[0].mult(-1);
        //acc.mult(0);
        println(vel);
        println(b.vel);
        vel.mult(0);
        b.vel.mult(0);
        acc.mult(0);
        b.acc.mult(0);
        
        //PVector t = b.vel;
        //b.vel = vel;
        //vel = t;
      }
    }
  }
  void applyGrav(ArrayList<body> all){
    for(body b:all){
      float m1 = b.mass;
      float m2 = mass;
      float r = dist(pos.x,pos.y,b.pos.x,b.pos.y);
      float gravF = gConst*(m1*m2/pow(r,2));
      if(gravF > 1000){
        //gravF = 1000;
      }
      acc.add(new PVector(b.pos.x-pos.x,b.pos.y-pos.y).setMag(gravF/m2));
    }
  }
  void update(){
    vel.mult(deltaT);
    vel.add(acc.mult(0.5*deltaT));
    pos.add(vel);
    acc.mult(0);
  }
  void display(){
    noStroke();
    fill(map(mass,100,1000,255,100));
    ellipse(pos.x,pos.y,radius*2,radius*2);
  }
}