ArrayList<Entity>entities = new ArrayList<Entity>();
Bot bot;
public void setup(){
  size(800, 800);
  bot = new Bot(new PVector(width/2, height/2));
}

public void draw(){
  background(0);
  bot.render();
  for(Entity e:entities){
    e.render();
  }
  bot.update();
}

public void mouseReleased(){
  entities.add(new Entity(new PVector(mouseX, mouseY),random(-1,1)));
}
