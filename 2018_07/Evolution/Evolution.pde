matrix m = new matrix();
ArrayList<PVector> food = new ArrayList();
ArrayList<PVector> removeFood = new ArrayList();

ArrayList<creature> creatures = new ArrayList();
ArrayList<creature> toAddC = new ArrayList();
ArrayList<creature> toRemoveC = new ArrayList();

void setup(){
  size(1000,1000);
}

void draw(){
  background(200);
  for(int i = 0;i < 1;i++){
    for(PVector f:food){
      fill(0,255,0);
      ellipse(f.x,f.y,10,10);
    }
    for(creature c:creatures){
      c.update();
      c.move();
      if(c.hunger>1000){
        c.hunger=c.hunger-500;
        toAddC.add(new creature(new PVector(c.pos.x,c.pos.y)));
        toAddC.get(toAddC.size()-1).n=c.n;
        toAddC.get(toAddC.size()-1).dna=c.dna;
        toAddC.get(toAddC.size()-1).gen=c.gen+1;
        toAddC.get(toAddC.size()-1).hunger=500;
        toAddC.get(toAddC.size()-1).mutate();
      }
      if(c.checkDead()){
        food.add(c.pos);
        toRemoveC.add(c);
      }
      c.display();
    }
    println(creatures.size());
    food.removeAll(removeFood);
    removeFood = new ArrayList();
    creatures.addAll(toAddC);
    toAddC = new ArrayList();
    creatures.removeAll(toRemoveC);
    toRemoveC = new ArrayList();
    if(food.size() < 30){
      food.add(new PVector(random(width),random(height)));
    }
    if(creatures.size() < 10){
      creatures.add(new creature(new PVector(random(width),random(height))));
    }
  }
}