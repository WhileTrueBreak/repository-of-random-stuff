class graph{
  
  float[] graph;
  float x, y;
  float maxHeight, maxWidth, barSize, maxValue;
  
  graph(float x, float y, float maxHeight, float maxWidth, float maxValue, float barSize){
    this.barSize = barSize;
    this.maxHeight = maxHeight;
    this.maxWidth = maxWidth;
    this.maxValue = maxValue;
    this.x = x;
    this.y = y;
    graph = new float[round(maxWidth/barSize)];
  }
  
  void addNew(float num){
    for(int i = 1;i < graph.length;i++){
      graph[i-1] = graph[i];
    }
    if(num > maxValue){
      num = maxValue;
    }
    graph[graph.length-1] = num;
  }
  
  void setLine(float num){
    float h = maxHeight*num/maxValue;
    stroke(255,0,0);
    line(x,y + maxHeight - h,x+maxWidth,y + maxHeight - h);
  }
  
  void display(){
    noStroke();
    fill(255);
    for(int i = 0;i < graph.length;i++){
      float h = maxHeight*graph[i]/maxValue;
      rect(x+i*barSize,y + maxHeight - h,barSize,h);
    }
  }
  
}