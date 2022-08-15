#include <Servo.h>

Servo motor;

void setup() {
  motor.attach(9);
  motor.write(180);
}

void loop() {
  
}
