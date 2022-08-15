class player{
  boolean hit = true;
  boolean onCube = false;
  
  float maxSpeed = 5;
  
  ArrayList<border>collided = new ArrayList();
  ArrayList<border>collidedToRemove = new ArrayList();
  cube c;
  PVector acc = new PVector(0,0,0);
  PVector vel = new PVector(0,0,0);
  PVector pos;
  PVector dimension;
  player(PVector pos_,PVector d){
    c = new cube(pos_,d);
    pos = pos_;
    dimension = d;
  }
  void update(){
    acc.add(new PVector(0,0.2,0));
    vel.add(acc);
    if(c.collide(new PVector(0,height/2,0),new PVector(1000,height/2,1000),new PVector(pos.x+vel.x,pos.y,pos.z),dimension)){
      if(vel.x > 0){
        if(!hit){
          collided.add(new border(new PVector(pos.x+dimension.y,pos.y,pos.z)));
          
          collided.add(new border(new PVector(pos.x+dimension.y,pos.y,pos.z+dimension.z)));
          collided.add(new border(new PVector(pos.x+dimension.x,pos.y+dimension.y,pos.z)));
          collided.add(new border(new PVector(pos.x+dimension.y,pos.y,pos.z-dimension.z)));
          collided.add(new border(new PVector(pos.x+dimension.x,pos.y-dimension.y,pos.z)));
        }
      }
      if(vel.x < 0){
        if(!hit){
          collided.add(new border(new PVector(pos.x-dimension.y,pos.y,pos.z)));
          
          collided.add(new border(new PVector(pos.x-dimension.y,pos.y,pos.z+dimension.z)));
          collided.add(new border(new PVector(pos.x-dimension.x,pos.y+dimension.y,pos.z)));
          collided.add(new border(new PVector(pos.x-dimension.y,pos.y,pos.z-dimension.z)));
          collided.add(new border(new PVector(pos.x-dimension.x,pos.y-dimension.y,pos.z)));
        }
      }
      hit = true;
      vel.x = 0;
    }else{
      hit = false;
    }
    if(c.collide(new PVector(0,height/2,0),new PVector(1000,height/2,1000),new PVector(pos.x,pos.y+vel.y,pos.z),dimension)||pos.y+dimension.y+vel.y>=height/2){
      if(vel.y > 0){
        if(!hit){
          collided.add(new border(new PVector(pos.x,pos.y+dimension.y,pos.z)));
          
          collided.add(new border(new PVector(pos.x,pos.y+dimension.y,pos.z+dimension.z)));
          collided.add(new border(new PVector(pos.x+dimension.x,pos.y+dimension.y,pos.z)));
          collided.add(new border(new PVector(pos.x,pos.y+dimension.y,pos.z-dimension.z)));
          collided.add(new border(new PVector(pos.x-dimension.x,pos.y+dimension.y,pos.z)));
        }
        onCube = true;
      }
      if(vel.y < 0){
        if(!hit){
          collided.add(new border(new PVector(pos.x,pos.y+dimension.y,pos.z)));
          
          collided.add(new border(new PVector(pos.x,pos.y-dimension.y,pos.z+dimension.z)));
          collided.add(new border(new PVector(pos.x+dimension.x,pos.y-dimension.y,pos.z)));
          collided.add(new border(new PVector(pos.x,pos.y-dimension.y,pos.z-dimension.z)));
          collided.add(new border(new PVector(pos.x-dimension.x,pos.y-dimension.y,pos.z)));
        }
      }
      hit = true;
      vel.y = 0;
    }else{
      if(vel.y < 0){
        onCube = false;
      }
      hit=false;
    }
    if(c.collide(new PVector(0,height/2,0),new PVector(1000,height/2,1000),new PVector(pos.x,pos.y,pos.z+vel.z),dimension)){
      if(vel.z > 0){
        if(!hit){
          collided.add(new border(new PVector(pos.x+dimension.y,pos.y,pos.z+dimension.z)));
          
          collided.add(new border(new PVector(pos.x+dimension.y,pos.y,pos.z+dimension.z)));
          collided.add(new border(new PVector(pos.x,pos.y+dimension.y,pos.z+dimension.z)));
          collided.add(new border(new PVector(pos.x-dimension.y,pos.y,pos.z+dimension.z)));
          collided.add(new border(new PVector(pos.x,pos.y-dimension.y,pos.z+dimension.z)));
        }
      }if(vel.z < 0){
        if(!hit){
          collided.add(new border(new PVector(pos.x+dimension.y,pos.y,pos.z+dimension.z)));
          
          collided.add(new border(new PVector(pos.x+dimension.y,pos.y,pos.z-dimension.z)));
          collided.add(new border(new PVector(pos.x,pos.y+dimension.y,pos.z-dimension.z)));
          collided.add(new border(new PVector(pos.x-dimension.y,pos.y,pos.z-dimension.z)));
          collided.add(new border(new PVector(pos.x,pos.y-dimension.y,pos.z-dimension.z)));
        }
      }
      hit = true;
      vel.z = 0;
    }else{
      hit = false;
    }
    for(border b:collided){
      if(b.dead()){
        collidedToRemove.add(b);
      }
    }
    collided.removeAll(collidedToRemove);
    collidedToRemove = new ArrayList();
    vel.limit(maxSpeed);
    pos.add(vel);
    vel.mult(0.9);
    if(vel.mag()<0.01){
      vel.mult(0);
    }
    acc.mult(0);
  }
  void display(PVector rotate,PVector pr){
    c.display(rotate,pr,false);
    for(border b:collided){
      b.display(rotate,pr);
      b.update();
    }
  }
  void move(){
    if(up){
      acc.add(new PVector(0,0,-1));
    }
    if(down){
      acc.add(new PVector(0,0,1));
    }
    if(left){
      acc.add(new PVector(-1,0,0));
    }
    if(right){
      acc.add(new PVector(1,0,0));
    }
    if(jump&&onCube){
      acc.add(new PVector(0,-10,0));
      onCube = false;
    }
  }
}