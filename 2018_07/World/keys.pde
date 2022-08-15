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
}