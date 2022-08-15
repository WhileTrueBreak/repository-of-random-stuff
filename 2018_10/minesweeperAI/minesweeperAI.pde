MineSweeper mineSweeper;

void setup(){
  size(1000,1000);
  mineSweeper = new MineSweeper(100,100,200);
}

void draw(){
  mineSweeper.update();
  mineSweeper.display();
}