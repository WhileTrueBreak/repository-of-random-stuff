class Node{
  
  ArrayList<Node> adjNodes = new ArrayList<Node>();
  float x, y;
  
  Node(float x, float y){
      this.x = x;
      this.y = y;
  }
  
  void addAdjNode(Node node){
    if(adjNodes.contains(node))return;
    adjNodes.add(node);
  }
  
}

class Quadtree{
  
  int MAX_LEVEL = 10;
  int MIN_SIZE = 5;
  
  Node node;
  Quadtree[] nodes;
  float x, y, w, h;
  boolean blocked;
  int level;
  
  Quadtree(int w, int h){
    this(0, 0, 0, w, h);
  }
  
  Quadtree(int level, float x, float y, float w, float h){
    node = new Node(x+w/2, y+h/2);
    this.blocked = false;
    this.level = level;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  private void split(){
    //splits the current quadtree in four 
    nodes = new Quadtree[4];
    nodes[0] = new Quadtree(level+1, x    , y    , w/2, h/2);
    nodes[1] = new Quadtree(level+1, x+w/2, y    , w/2, h/2);
    nodes[2] = new Quadtree(level+1, x    , y+h/2, w/2, h/2);
    nodes[3] = new Quadtree(level+1, x+w/2, y+h/2, w/2, h/2);
  }
  
  void addBlocks(ArrayList<Block>blocks){
    for(Block b:blocks) add(b);
  }
  
  void add(Block block){
    //check if split is possible
    if(nodes == null && level < MAX_LEVEL) split();
    if(level >= MAX_LEVEL) return;
    //check if the node is completely contain in the block
    if(block.x < x && block.y < y && block.x+block.w > x+w && block.y+block.h > y+h) return;
    //check if node will not be too small
    if(w/2 < MIN_SIZE || h/2 < MIN_SIZE) return;
    //check if block intersects quadrants
    if(block.x < nodes[0].x + nodes[0].w && block.x + block.w > nodes[0].x && block.y < nodes[0].y + nodes[0].h && block.y + block.h > nodes[0].y){
      nodes[0].blocked = true;
      nodes[0].add(block);
    }
    if(block.x < nodes[1].x + nodes[1].w && block.x + block.w > nodes[1].x && block.y < nodes[1].y + nodes[1].h && block.y + block.h > nodes[1].y){
      nodes[1].blocked = true;
      nodes[1].add(block);
    }
    if(block.x < nodes[2].x + nodes[2].w && block.x + block.w > nodes[2].x && block.y < nodes[2].y + nodes[2].h && block.y + block.h > nodes[2].y){
      nodes[2].blocked = true;
      nodes[2].add(block);
    }
    if(block.x < nodes[3].x + nodes[3].w && block.x + block.w > nodes[3].x && block.y < nodes[3].y + nodes[3].h && block.y + block.h > nodes[3].y){
      nodes[3].blocked = true;
      nodes[3].add(block);
    }
  }
  
  void dfs(){
    System.out.printf("\nLevel = %d [X=%d Y=%d]", level, (int)x, (int)y);
    System.out.printf("\n\tBlocked=" + blocked);
    if(nodes == null){
      print("\n\t[Leaf Node]");
      noFill();
      stroke(0,255,255);
      rect(x, y, w, h);
    }else{
      print("\n\t[Branch Node]");
      nodes[0].dfs();
      nodes[1].dfs();
      nodes[2].dfs();
      nodes[3].dfs();
    }
  }
  
  ArrayList<Quadtree> dfsGetLeaf(){
    ArrayList<Quadtree> qtLeaf = new ArrayList<Quadtree>();
    if(nodes == null){
      if(blocked)return qtLeaf;
      qtLeaf.add(this);
    }else{
      qtLeaf.addAll(nodes[0].dfsGetLeaf());
      qtLeaf.addAll(nodes[1].dfsGetLeaf());
      qtLeaf.addAll(nodes[2].dfsGetLeaf());
      qtLeaf.addAll(nodes[3].dfsGetLeaf());
    }
    return qtLeaf;
  }
  
  void createNavMesh(){
    ArrayList<Quadtree> qtLeaf = dfsGetLeaf();
    for(Quadtree qt:qtLeaf){
      for(Quadtree qts:qtLeaf){
        println(qts.blocked);
        if(qt==qts)continue;
        //check top adj nodes
        float lowY = qts.y+qts.h;
        if(lowY == qt.y)qt.node.addAdjNode(qts.node);
        //check left adj nodes
        float lowX = qts.x+qts.w;
        if(lowX == qt.x)qt.node.addAdjNode(qts.node);
        //check bottom adj nodes
        if(qts.y == qt.y+qt.h)qt.node.addAdjNode(qts.node);
        //check right adj nodes
        if(qts.x == qt.x+qt.w)qt.node.addAdjNode(qts.node);
      }
    }
  }
  
  void renderNavMesh(){
    ArrayList<Quadtree> qtLeaf = dfsGetLeaf();
    stroke(0,255,255);
    for(Quadtree qt:qtLeaf){
      for(Node n:qt.node.adjNodes){
        line(n.x, n.y, qt.node.x, qt.node.y);
      }
    }
  }
}