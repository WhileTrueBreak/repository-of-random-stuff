class element{
  float speed = 4;
  PVector point = new PVector(0,0);
  int timer = 0;
  float avoid_dist = 5;
  int rank;
  PVector acc = new PVector(0,0);
  PVector vel = new PVector(random(-1,1),random(-1,1));
  PVector pos = new PVector(0,0);
  element(PVector p){
    pos = p;
  }
  void run_movement(ArrayList<element> elements){
    if(timer == 0){
      int numBird = 0;
      PVector averageAlignment = new PVector(0,0);
      for(element e:elements){
        if(dist(e.pos.x,e.pos.y,pos.x,pos.y)<60){
          averageAlignment.add(e.vel);
          numBird++;
        }
        if(dist(e.pos.x,e.pos.y,pos.x,pos.y)<5){
          PVector repulseDir = new PVector(pos.x-e.pos.x,pos.y-e.pos.y);
          acc.add(repulseDir.mult(0.01/(dist(e.pos.x,e.pos.y,pos.x,pos.y)+0.001)));
        }
      }
      for(circle c:circles){
        if(dist(c.pos.x,c.pos.y,pos.x,pos.y)<30){
          PVector repulseDir = new PVector(pos.x-c.pos.x,pos.y-c.pos.y);
          acc.add(repulseDir.mult(0.5/(dist(c.pos.x,c.pos.y,pos.x,pos.y)+0.5)));
        }
      }
      averageAlignment.add(new PVector(random(-2,2),random(-2,2)));
      averageAlignment.setMag(0.5);
      acc.add(averageAlignment);
      acc.add(vel.setMag(1));
      if(numBird > 30){
        speed = 3.5;
      }else{
        speed = map(numBird,0,30,5,3.5);
      }
    }else{
      for(element e:elements){
        if(dist(e.pos.x,e.pos.y,pos.x,pos.y)<5){
          PVector repulseDir = new PVector(pos.x-e.pos.x,pos.y-e.pos.y);
          acc.add(repulseDir.mult(0.01/(dist(e.pos.x,e.pos.y,pos.x,pos.y)+0.001)));
        }
      }
      for(circle c:circles){
        if(dist(c.pos.x,c.pos.y,pos.x,pos.y)<30){
          PVector repulseDir = new PVector(pos.x-c.pos.x,pos.y-c.pos.y);
          acc.add(repulseDir.mult(0.5/(dist(c.pos.x,c.pos.y,pos.x,pos.y)+0.5)));
        }
      }
      acc.add(new PVector(point.x-pos.x,point.y-pos.y).setMag(1));
    }
    
  }
  void avoid(ArrayList<element2> elements){
    for(element2 e:elements){
      if(dist(e.pos.x,e.pos.y,pos.x,pos.y)<30){
        PVector repulseDir = new PVector(pos.x-e.pos.x,pos.y-e.pos.y);
        acc.add(repulseDir.mult(5/(dist(e.pos.x,e.pos.y,pos.x,pos.y)+1)));
      }
    }
  }
  void display(){
    float theta = this.vel.heading() + PI/2;
    noStroke();
    fill(255,100);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(theta);
    triangle(0,0,4,8,-4,8);
    popMatrix();
  }
  void update(){
    timer--;
    if(timer<0){
      timer = 0;
    }
    if(random(1)<0.4/DeltaT){
      timer = 2;
      point = new PVector(random(width),random(height));
    }
    vel.add(acc.mult(0.5*DeltaT));
    vel.setMag(speed*DeltaT);
    pos.add(vel);
    vel.mult(1);
    acc.mult(0);
    if(pos.x>width){
      pos.x = 0;
    }else if(pos.x < 0){
      pos.x = width;
    }
    if(pos.y>height){
      pos.y = 0;
    }else if(pos.y < 0){
      pos.y = height;
    }
  }
}
