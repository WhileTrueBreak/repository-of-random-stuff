boolean mUp = false;
boolean mDown = false;
boolean mRight = false;
boolean mLeft = false;

void keyPressed(){
  if(key == 'w'){
    mUp = true;
  }
  if(key == 'a'){
    mLeft = true;
  }
  if(key == 's'){
    mDown = true;
  }
  if(key == 'd'){
    mRight = true;
  }
}

void keyReleased(){
  if(key == 'w'){
    mUp = false;
  }
  if(key == 'a'){
    mLeft = false;
  }
  if(key == 's'){
    mDown = false;
  }
  if(key == 'd'){
    mRight = false;
  }
}