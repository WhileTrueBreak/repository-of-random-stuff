boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;

boolean r = false;

void keyPressed(){
  if(keyCode == UP || key == 'w'){
    up = true;
  }
  if(keyCode == LEFT || key == 'a'){
    down = true;
  }
  if(keyCode == DOWN || key == 's'){
    left = true;
  }
  if(keyCode == RIGHT || key == 'd'){
    right = true;
  }
  if(key == 'r'){
    r = true;
  }
}
void keyReleased(){
  if(keyCode == UP || key == 'w'){
    up = false;
  }
  if(keyCode == LEFT || key == 'a'){
    down = false;
  }
  if(keyCode == DOWN || key == 's'){
    left = false;
  }
  if(keyCode == RIGHT || key == 'd'){
    right = false;
  }
  if(key == 'r'){
    r = false;
  }
}