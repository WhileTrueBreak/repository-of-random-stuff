class lineManager{
  ArrayList<line> lines;
  
  handler h;
  
  lineManager(handler h){
    this.h = h;
    lines = new ArrayList();
  }
  
  public void update(){
    for(line l:lines){
      l.update();
    }
  }
  
  public void render(){
    for(line l:lines){
      l.render();
    }
  }
  
  public void addLine(line l){
    lines.add(l);
  }
  
  public ArrayList<line> getLines(){
    return lines;
  }
}