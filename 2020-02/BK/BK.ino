int LEDDelay = 100;

long r1 = 198;
long r2 = 23;
long r3 = 222;
void setup() {
  pinMode(A0,OUTPUT);
  pinMode(A1,OUTPUT);
  pinMode(A2,OUTPUT);
  pinMode(A3,OUTPUT);
  pinMode(A4,OUTPUT);
  pinMode(A5,OUTPUT);
}

void loop() {
  analogWrite(A0,r1);
  analogWrite(A3,r1);
  analogWrite(A1,r2);
  analogWrite(A4,r2);
  analogWrite(A2,r3);
  analogWrite(A5,r3);
  delay(LEDDelay);
}
