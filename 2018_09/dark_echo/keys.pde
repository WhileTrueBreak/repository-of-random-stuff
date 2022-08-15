boolean shift = false;
boolean space = false;
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;

void keyPressed(){
  if(key == 'w'){
    up = true;
  }
  if(key == 'a'){
    left = true;
  }
  if(key == 's'){
    down = true;
  }
  if(key == 'd'){
    right = true;
  }
  if(keyCode == CONTROL){
    shift = true;
  }
  if(key == ' '){
    space = true;
  }
}
void keyReleased(){
  if(key == 'w'){
    up = false;
  }
  if(key == 'a'){
    left = false;
  }
  if(key == 's'){
    down = false;
  }
  if(key == 'd'){
    right = false;
  }
  if(keyCode == CONTROL){
    shift = false;
  }
  if(key == ' '){
    space = false;
  }
}