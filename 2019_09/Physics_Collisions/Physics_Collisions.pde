final float GRAVITY = 2;

boolean left, right, up;

ArrayList<Cline>lines = new ArrayList();
Player player;

void settings(){
  size(600, 600);
}

void setup(){
  player = new Player(width/2, 0, 5);
  //create random lines
  lines.add(new Cline(0, 300, 600, 300));
  lines.add(new Cline(100, 600, 100, 0));
  lines.add(new Cline(400, 600, 600, 0));
  lines.add(new Cline(0, 600, 600, 150));
}

void draw(){
  background(0);
  for(Cline l:lines) l.render();
  player.render();
  player.update();
}

void keyPressed(){
  if(key=='d'){
    right = true;
  }
  if(key=='a'){
    left = true;
  }
  if(key=='w'){
    up = true;
  }
  if(key=='r'){
    player.x = width/2;
    player.y = 0;
  }
}

void keyReleased(){
  if(key=='d'){
    right = false;
  }
  if(key=='a'){
    left = false;
  }
  if(key=='w'){
    up = false;
  }
}
