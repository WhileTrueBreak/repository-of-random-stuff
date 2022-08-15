boolean leftPressed = false;
boolean leftReleased = true;
boolean leftClick = false;
boolean rightPressed = false;
boolean rightReleased = true;
boolean rightClick = false;

void resetMouseVar(){
  leftReleased = true;
  leftClick = false;
  rightReleased = true;
  rightClick = false;
}

void mousePressed(){
  if(mouseButton == LEFT){
    leftClick = true;
    leftPressed = true;
    leftReleased = false;
  }
  if(mouseButton == RIGHT){
    rightClick = true;
    rightPressed = true;
    rightReleased = false;
  }
}

void mouseReleased(){
  if(mouseButton == LEFT){
    leftReleased = true;
    leftClick = false;
    leftPressed = false;
  }
  if(mouseButton == RIGHT){
    rightReleased = true;
    rightClick = false;
    rightPressed = false;
  }
}