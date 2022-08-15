PVector[][] field= new PVector[125][125];
float n = 0;

void setup(){
  size(500,500);
  for(int i = 0;i < field.length;i++){
    for(int j = 0;j < field[i].length;j++){
        field[i][j] = PVector.fromAngle(radians(noise(i*0.01,j*0.01)*360));
    }
  }
}

void draw(){
  background(255);
  for(int i = 0;i < field.length;i++){
    for(int j = 0;j < field[i].length;j++){
      line(i*4,j*4,i*4+field[i][j].x*4,j*4+field[i][j].y*4);
    }
  }
  for(int i = 0;i < field.length;i++){
    for(int j = 0;j < field[i].length;j++){
        field[i][j] = PVector.fromAngle(radians(noise(i*0.01,j*0.01,n)*360));
    }
  }
  n+=0.005;
}