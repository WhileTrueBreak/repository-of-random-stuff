import peasy.*;
PeasyCam cam;

float rotX, rotY, rotZ;

void setup(){
  size(800, 800, P3D);
  cam = new PeasyCam(this, 1000);
  //cam.setYawRotationMode();
  //cam.setPitchRotationMode();
  //cam.setRollRotationMode();
  //cam.setSuppressRollRotationMode();
}

void draw(){
  rotX+=1;
  rotY+=1.5;
  rotZ+=0.7;
  
  
  background(0);
  fill(255);
  stroke(0, 255, 255);
  line(0, 0, 0, 0, 0, 1000);
  line(0, 0, 0, 0, 1000, 0);
  line(0, 0, 0, 1000, 0, 0);
  
  stroke(0);
  pushMatrix();
    rotateX(radians(rotX));
    rotateY(radians(rotY));
    rotateZ(radians(rotZ));
    pushMatrix();
      translate(100, 0, 0);
      box(100, 100, 100);
    popMatrix();
    pushMatrix();
      translate(0, 100, 0);
      box(100, 100, 100);
    popMatrix();
    pushMatrix();
      translate(0, 0, 100);
      box(100, 100, 100);
    popMatrix();
  popMatrix();
}