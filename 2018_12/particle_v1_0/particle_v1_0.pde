int PARTICLE_NUM = 100;

ArrayList<Particle>particles = new ArrayList();

void setup(){
  size(400,400);
  //for(int i = 0;i < PARTICLE_NUM;i++){
  //  particles.add(new Particle(new PVector(random(10,width-10),random(10,height-10))));
  //}
  for(int i = 0;i < 10;i++){
    for(int j = 0;j < 30;j++){
      particles.add(new Particle(new PVector(i*11+10,j*11+10)));
    }
  }
  
}

void draw(){
  background(255);
  for(Particle p:particles){
    p.add_random();
    p.apply_force(new PVector(0,0.2));
    p.collide_particles();
  }
  for(Particle p:particles){
    p.render();
    p.update();
  }
}

void mousePressed(){
  for(int i = 0;i < 30;i++){
    particles.add(new Particle(new PVector(random(-10,10)+mouseX,random(-10,10)+mouseY)));
  }
}