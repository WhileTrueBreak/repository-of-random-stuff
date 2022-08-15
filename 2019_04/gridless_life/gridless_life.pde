
float[][] rules = {{-0.1, -0.1, 0}, {-0.1, -0.1, 0}, {0, 0, 0}};

ArrayList<particle>particles;

void setup(){
  size(800, 800);
  particles = new ArrayList();
  for(int i = 0;i < 10;i++){
    particles.add(new particle(rules[0], 0));
  }
}

void draw(){
  background(0);
  for(particle p:particles){
    p.check();
  }
  for(particle p:particles){
    p.update();
    p.render();
  }
}

void mouseReleased(){
  int id = floor(random(3));
  particles.add(new particle(rules[id], id));
}