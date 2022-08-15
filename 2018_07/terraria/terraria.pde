float threshhold = 100;
PVector pos = new PVector(0,0);

boolean mouseR = false;
boolean mouseL = false;
boolean mouse = false;
boolean space = false;
boolean w = false;
boolean a = false;
boolean s = false;
boolean d = false;
boolean i = false;

player p = new player(new PVector(width/2,0));

ArrayList<chunk> chunks = new ArrayList();
ArrayList<chunk> addChunk = new ArrayList();
ArrayList<chunk> removeChunk = new ArrayList();

void setup(){
  size(1000,1000);
  for(int i = -0;i < 11;i++){
    chunks.add(new chunk(i*0.5,i*100));
  }
}

void draw(){
  background(255);
  /////////////////////////////////chunks//////////////////////////////////////////////////
  for(chunk c:chunks){
    if(s){
      //c.py -= 4;
    }
    if(p.pos.x>width/2+threshhold){
      c.px -= 4;
    }
    if(w){
      //c.py += 4;
    }
    if(p.pos.x<width/2-threshhold){
      c.px += 4;
    }
    if(c.px<-100||c.px>width){  
      removeChunk.add(c);
      if(c.px<-100){
        addChunk.add(new chunk((floor((pos.x+width+100)/100)-1)*0.5,c.px+width+100));
        addChunk.get(addChunk.size()-1).py = c.py;
      }
      if(c.px>width){
        addChunk.add(new chunk((floor(pos.x/100)-1)*0.5,c.px-width-100));
        addChunk.get(addChunk.size()-1).py = c.py;
      }
    }
    c.display();
  }
  if(s){
    //pos.add(new PVector(0,4));
  }
  if(p.pos.x>width/2+threshhold){
    pos.add(new PVector(4,0));
    p.pos.x -= 4;
  }
  if(w){
    //pos.add(new PVector(0,-4));
  }
  if(p.pos.x<width/2-threshhold){
    pos.add(new PVector(-4,0));
    p.pos.x += 4;
  }
  chunks.removeAll(removeChunk);
  chunks.addAll(addChunk);
  removeChunk = new ArrayList();
  addChunk = new ArrayList();
  /////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////player////////////////////////////////////////////
  p.gravity();
  p.move();
  p.update();
  p.display();
  /////////////////////////////////////////////////////////////////////////////////////////
  println(mouseR,mouseL);
}
///////////////////////////////////keys//////////////////////////////////////////////////
void keyPressed(){
  if(key == 'a'){
    a = true;
  }
  if(key == 'd'){
    d = true;
  }
  if(key == 'w'){
    w = true;
  }
  if(key == 's'){
    s = true;
  }
  if(key == ' '){
    space = true;
  }
}
void keyReleased(){
  if(key == 'a'){
    a = false;
  }
  if(key == 'd'){
    d = false;
  }
  if(key == 'w'){
    w = false;
  }
  if(key == 's'){
    s = false;
  }
  if(key == ' '){
    space = false;
  }
}
/////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////mouse/////////////////////////////////////////////////
void mousePressed(){
  if (mouseButton == LEFT) {
    mouseL = true;
  }
  if (mouseButton == RIGHT) {
    mouseR = true;
  }
}
void mouseReleased(){
  if (mouseButton == LEFT) {
    mouseL = false;
  }
  if (mouseButton == RIGHT) {
    mouseR = false;
  }
}
/////////////////////////////////////////////////////////////////////////////////////////