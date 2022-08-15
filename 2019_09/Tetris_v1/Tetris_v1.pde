Game tetris = new Game();

public void setup(){
  size(400, 800);
}

public void draw(){
  background(0);
  tetris.render();
}

public void mouseReleased(){
  tetris.clearLine((int)(mouseY/(height/20)));
}
