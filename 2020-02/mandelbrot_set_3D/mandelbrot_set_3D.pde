import peasy.*;
PeasyCam cam;

float step = 0.5;

int maxI;
int[][] cmap;

void setup() {
  size(1000, 1000, P3D);
  cmap = new int[(int)(width/step)][(int)(height/step)];
  cam = new PeasyCam(this, 1000);
  colorMode(HSB);
  float threshhold = 0.01;

  noStroke();
  maxI = 100;
  for (float i = 0; i < width; i+=step) {
    for (float j = 0; j < height; j+=step) {
      Complex c = new Complex(map(i, 0, width, -2, 2), map(j, 0, height, -2, 2));
      Complex x = new Complex(0, 0);
      int k = 0;
      while (k<maxI) {
        x = x.mult(x);
        x.real+=c.real;
        x.img+=c.img;
        if (k!=0&&(x.real+threshhold>=c.real&&x.real<=c.real+threshhold)&&(x.img<=c.img+threshhold&&x.img+threshhold>=c.img)) break;
        k++;
      }
      cmap[(int)(i/step)][(int)(j/step)]=k;
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < cmap.length; i++) {
    for (int j = 0; j < cmap[i].length; j++) {
      if (cmap[i][j]==maxI)continue;
      fill(cmap[i][j]*10, 255, 255-cmap[i][j]*255/maxI);
      pushMatrix();
      translate(-width/2, -height/2, -cmap[i][j]);
      rect(i*step, j*step, step, step);
      popMatrix();
    }
  }
}