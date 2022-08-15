int brightR = 0;
int brightG = 0;
int brightB = 0;

float fadeR = 2.5;
float fadeG = 1.5;
float fadeB = 1;

int LEDR = 11;
int LEDG = 10;
int LEDB = 9;

void setup()  {
  pinMode(LEDR, OUTPUT);
  pinMode(LEDG, OUTPUT);
  pinMode(LEDB, OUTPUT);
} 
void loop()  {
  analogWrite(LEDR, brightR);
  analogWrite(LEDG, brightG);
  analogWrite(LEDB, brightB);

  brightR+=fadeR;
  brightG+=fadeG;
  brightB+=fadeB;

  if(brightR<=0||brightR>=255){
    fadeR*=-1;
  }if(brightG<=0||brightG>=255){
    fadeG*=-1;
  }if(brightB<=0||brightB>=255){
    fadeB*=-1;
  }
  delay(10);
}
