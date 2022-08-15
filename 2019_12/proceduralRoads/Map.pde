class Map{
  
  int[][] map;
  
  public Map(int w, int h){
    map = new int[w][h];
  }
  
  public void render(){
    noStroke();
    for(int i = 0;i < map.length;i++){
      for(int j = 0;j < map[i].length;j++){
        switch(map[i][j]){
          case 0:
          fill(255);
          break;
          case 1:
          fill(0);
          break;
        }
        rect(i*width/map.length, j*height/map[i].length, width/map.length, height/map[i].length);
      }
    }
  }
  
  public void startCity(int x, int y, int size){
    //create main roads
    //for(int i = x-size<0?0:x-size;i < (x+size>map.length-1?map.length-1:x+size);i++)map[i][y] = 1;
    //for(int i = y-size<0?0:y-size;i < (y+size>map[x].length-1?map[x].length-1:y+size);i++)map[x][i] = 1;
    
    //pick branch points
    ArrayList<Node> nodes = new ArrayList<Node>();
    
    //create center branch
    nodes.add(new Node(x, y, 10));
    
    //create scattered branch
    for(int i = 0;i < ((int)size/50==0?1:(int)size/50);i++){
      float theta = random(360);
      float dist = random(size);
      int xPoint = (int)(dist*cos(radians(theta)))+x;
      int yPoint = (int)(dist*sin(radians(theta)))+y;
      nodes.add(new Node(xPoint<0?0:xPoint>map.length-1?map.length-1:xPoint, yPoint<0?0:yPoint>map.length-1?map.length-1:yPoint, 5));
    }
    
    //expand from points
    while(nodes.size() != 0){
      ArrayList<Node> nNodes = new ArrayList<Node>();
      //update all points
      for(int i = 0;i < nodes.size();i++){
        //check if outside radius
        if(dist(nodes.get(i).getX(),nodes.get(i).getY(),x,y)>size)continue;
        //set map value
        map[nodes.get(i).getX()][nodes.get(i).getY()] = 1;
        //check on border
        if(nodes.get(i).getX()==0||nodes.get(i).getY()==0||nodes.get(i).getX()==map.length-1||nodes.get(i).getY()==map[nodes.get(i).getX()].length-1)continue;
        //check neighbours
        int neighbourCount = 0;
        if(map[nodes.get(i).getX()][nodes.get(i).getY()+1]==1)neighbourCount++;
        if(map[nodes.get(i).getX()][nodes.get(i).getY()-1]==1)neighbourCount++;
        if(map[nodes.get(i).getX()+1][nodes.get(i).getY()]==1)neighbourCount++;
        if(map[nodes.get(i).getX()-1][nodes.get(i).getY()]==1)neighbourCount++;
        //create new nodes
        if(neighbourCount == 0){
          nNodes.add(new Node(nodes.get(i).getX(),nodes.get(i).getY()+1,nodes.get(i).getSize()));
          nNodes.add(new Node(nodes.get(i).getX(),nodes.get(i).getY()-1,nodes.get(i).getSize()));
          nNodes.add(new Node(nodes.get(i).getX()+1,nodes.get(i).getY(),nodes.get(i).getSize()));
          nNodes.add(new Node(nodes.get(i).getX()-1,nodes.get(i).getY(),nodes.get(i).getSize()));
        }
        if(map[nodes.get(i).getX()][nodes.get(i).getY()+1]==1&&map[nodes.get(i).getX()][nodes.get(i).getY()-1]==0)nNodes.add(new Node(nodes.get(i).getX(),nodes.get(i).getY()-1,nodes.get(i).getSize()));
        if(map[nodes.get(i).getX()][nodes.get(i).getY()-1]==1&&map[nodes.get(i).getX()][nodes.get(i).getY()+1]==0)nNodes.add(new Node(nodes.get(i).getX(),nodes.get(i).getY()+1,nodes.get(i).getSize()));
        if(map[nodes.get(i).getX()+1][nodes.get(i).getY()]==1&&map[nodes.get(i).getX()-1][nodes.get(i).getY()]==0)nNodes.add(new Node(nodes.get(i).getX()-1,nodes.get(i).getY(),nodes.get(i).getSize()));
        if(map[nodes.get(i).getX()-1][nodes.get(i).getY()]==1&&map[nodes.get(i).getX()+1][nodes.get(i).getY()]==0)nNodes.add(new Node(nodes.get(i).getX()+1,nodes.get(i).getY(),nodes.get(i).getSize()));
      }
      //update new points
      nodes = nNodes;
    }
    
  }
  
}
