boolean leftC = false;
boolean rightC = false;
boolean w = false;
boolean a = false;
boolean s = false;
boolean d = false;

void keyPressed(){
  if(key == 'w'){
    w = true;
  }
  if(key == 'a'){
    a = true;
  }
  if(key == 's'){
    s = true;
  }
  if(key == 'd'){
    d = true;
  }
}
void keyReleased(){
  if(key == 'w'){
    w = false;
  }
  if(key == 'a'){
    a = false;
  }
  if(key == 's'){
    s = false;
  }
  if(key == 'd'){
    d = false;
  }
}