import com.hamoid.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim         minim;
AudioOutput   out;

AudioPlayer song;

FFT fftLin;
FFT fftLog;

VideoExport videoExport;

int sampling = 1024;
int bands = 128;

float smoothingFactor = 0.25;
float scale = 2;

float[] sumlin = new float[bands];
float[] sumlog = new float[bands];

float x, y, w, h;

String name = "Systems_Check";

int fps = 60;

double error = 0;
double rTime = 1000/fps;
double startT = (double)System.nanoTime()/1000000;
double endT = (double)System.nanoTime()/1000000;

public void setup() {
  
  frameRate(fps);
  
  fullScreen();
  x = width/4;
  y = height/2;
  w = width/2;
  h = height/4;

  minim = new Minim(this);
  out = minim.getLineOut();
  
  song = minim.loadFile(name+".wav", 2048);
  song.play();
  
  videoExport = new VideoExport(this, name+".mp4");
  videoExport.setFrameRate(60);  
  
  fftLin = new FFT(song.bufferSize(), song.sampleRate());
  
  fftLin.linAverages(30);
  
  videoExport.startMovie();
  song.play();
}

public void draw() {
  background(0);
  noStroke();

  fftLin.forward(song.mix);


  for (int i = 0; i < bands; i++) {
    
    sumlin[i] += (fftLin.getBand(i)/40 - sumlin[i]) * smoothingFactor;
    
    float div = 0;
    float avg = 0;
    
    for(int j = -3;j <= 3;j++){
      if(i+j>=0&&i+j<bands){
        div += 1/pow(2,(float)abs(j));
        avg += sumlin[i+j]/pow(4,(float)abs(j));
      }
    }
    avg /= div;
    
    fill(255);
    rect(x+i*w/bands, y, w/bands-(w/bands)/10, -map(sigmoid(avg),0.5,1,0,1)*h);
    fill(155);
    rect(x+i*w/bands, y, w/bands-(w/bands)/10, map(sigmoid(avg),0.5,1,0,1)*h);
  }
  videoExport.saveFrame();
  if(!song.isPlaying()){
    videoExport.endMovie();
    println("Done saving.");
    exit();
  }
  while(error>rTime){
    videoExport.saveFrame();
    error-=rTime;
  }
  endT = (double)System.nanoTime()/1000000;
  error += (double)(endT-startT)-rTime;
  startT = (double)System.nanoTime()/1000000;
}


void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    println("Done saving.");
    exit();
  }
}  

public float sigmoid(float x) {
  return (float) (1/( 1 + Math.pow(Math.E,(-1*x))));
}
