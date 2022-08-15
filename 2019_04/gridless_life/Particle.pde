class particle{
  
  float px, py;
  float vx = 0, vy = 0;
  float ax = 0, ay = 0;
  
  float rot;
  
  float[] rule;
  int id;
  
  particle(float[] rule, int id){
    this.rule = rule;
    this.id = id;
    
    px = random(width);
    py = random(height);
    
    rot = random(360);
  }
  
  void render(){
    noStroke();
    if(id == 0){
      fill(255, 0, 0);
    }else if(id == 1){
      fill(0, 255, 0);
    }else{
      fill(0, 0, 255);
    }
    ellipse(px, py, 10, 10);
    noFill();
    stroke(255);
    ellipse(px, py, 100, 100);
  }
  
  void update(){
    if(px <= 50){
      ax += 0.05;
    }else if(px >= width-50){
      ax -= 0.05;
    }if(py <= 50){
      ay += 0.05;
    }else if(py >= height-50){
      ay -= 0.05;
    }
    
    vx += ax;
    vy += ay;
    
    float lim = 5;
    
    float mag = (float)Math.sqrt(vx * vx + vy * vy);
    if(mag > lim){
      vx = vx*lim/mag;
      vy = vy*lim/mag;
    }
    
    px += vx;
    py += vy;
    
    //println(vx);
    //println(vy);
    
    vx *= 1;
    vy *= 1;
    
    ax = 0;
    ay = 0;
  }
  
  void check(){
    ax = 0;
    ay = 0;
    for(particle p:particles){
      if(dist(p.px, p.py, px, py) < 100 && p != this){
        float dx = p.px - px, dy = p.py - px;
        float mag = (float)Math.sqrt(dx * dx + dy * dy);
        float ndx = dx/mag, ndy = dy/mag;
        ax += ndx*rule[p.id];
        ay += ndy*rule[p.id];
      }
    }
  }
  
}