
public String text = "Hello World!\nHello World!\nHello World!\nHello World!";

public int nextDelay = 0;

public int timeElapse = 0;
public String displayText = "";
public int index = 0;

public void settings(){
  size(600, 600);
}

public void setup(){
  textSize(40);
  textAlign(CENTER, CENTER);
}

public void draw(){
  if(millis()-timeElapse > nextDelay && index<text.length()){
    displayText += text.charAt(index);
    index++;
    timeElapse = millis();
    nextDelay = (int)(random(100,300));
  }
  background(0);
  fill(255);
  text(displayText, width/2, height/2);
}
