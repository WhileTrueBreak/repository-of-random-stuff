boolean mouseL = false;
boolean mouseR = false;

boolean k1 = false;
boolean k2 = false;
boolean k3 = false;
boolean k4 = false;

boolean r = false;
boolean e = false;

boolean temp = true;

void keyPressed(){
  if(key == '1'){
    k1 = true;
  }
  if(key == '2'){
    k2 = true;
  }
  if(key == '3'){
    k3 = true;
  }
  if(key == '4'){
    k4 = true;
  }
  if(key == 'r'){
    r = true;
  }
  if(!e){
    temp = true;
  }
  if(key == 'e'&&temp){
    e = true;
  }
  if(!temp){
    e = false;
  }
}
void keyReleased(){
  if(key == '1'){
    k1 = false;
  }
  if(key == '2'){
    k2 = false;
  }
  if(key == '3'){
    k3 = false;
  }
  if(key == '4'){
    k4 = false;
  }
  if(key == 'r'){
    r = false;
  }
  if(key == 'e'){
    e = false;
  }
}
void mousePressed(){
  if(mouseButton == LEFT){
    mouseL = true;
  }
  if(mouseButton == RIGHT){
    mouseR = true;
  }
}
void mouseReleased(){
  if(mouseButton == LEFT){
    mouseL = false;
  }
  if(mouseButton == RIGHT){
    mouseR = false;
  }
}